class TextbooksController < ApplicationController
  before_action :id_params, only: [:show]
  def index
    @textbooks = Textbook.where(user: current_user)
  end
  def new
    @textbook = Textbook.new
  end
  def create
    @textbook = Textbook.new(textbook_params)
    if @textbook.save
      redirect_to root_path
    else
      render :new
    end
  end
  def show
    #学習時間配列の取得
    @records = Record.where(textbook_id: @textbook.id).order(r_date: "DESC")
    #日付でグループ化
    date_group_h = @records.group_by_day(:r_date).sum(:hours)
    date_group_m = @records.group_by_day(:r_date).sum(:minutes)
    date_hash = hours_conversion(date_group_h, date_group_m)
    #グラフの開始日と終了日の取得
    arrays = date_hash.keys
    @max_date = arrays.max
    if @max_date.present?
      #1番目のグラフと合計
      @tb_date = @max_date.beginning_of_week
      @te_date = @max_date.end_of_week
      @date_hash_t = chart_create(date_hash, @tb_date, @te_date)
      @sum_time_t = sum_time_week(@tb_date, @te_date)
      #2番目のグラフと合計
      @lb_date = @max_date.prev_week
      @le_date = @max_date.prev_week(:sunday)
      @prev_week_present = date_hash.find{ |x| (x[0] >= @lb_date) && (x[0] <= @le_date)}
      if @prev_week_present.present?
        @date_hash_l = chart_create(date_hash, @lb_date, @le_date)
        @sum_time_l = sum_time_week(@lb_date, @le_date)
      end
    end

    #目標学習時間の取得
    @df_time = DfTime.find_by(textbook_id: @textbook.id)
  end

  private

  def sum_time_week(b_date, e_date) #週間合計学習時間 date型、週初と週末を渡し、合計学習時間{hours: 数値,minutes: 数値}を返す
    sum_time = {}
    sum_hours = 0
    sum_minutes = 0
    week_group_h = @records.group_by_week(:r_date, week_start: :monday).sum(:hours)
    week_group_m = @records.group_by_week(:r_date, week_start: :monday).sum(:minutes)
    sum_hours = week_group_h[b_date]
    sum_minutes = week_group_m[b_date]
    hours = sum_minutes / 60
    sum_hours += hours
    sum_minutes %= 60
    sum_time[:hours] = sum_hours
    sum_time[:minutes] = sum_minutes
    return sum_time
  end

  def hours_conversion(date_group_h, date_group_m) #分を時間に変換する　{日付=>時間}{日付=>分}を渡して{日付=>時間}を返す ※分は返さない
    date_hash = {}
    date_group_h.each do |date_record_h|
      date_m = date_group_m[date_record_h[0]]
      hours = date_m / 60
      date_hash[date_record_h[0]] = date_record_h[1] + hours
    end
    return date_hash
  end

  def chart_create(date_hash, b_date, e_date) #グラフ用のハッシュ作成　1週間分の{日付=>時間}を返す
    s_date = b_date
    date_hash_w = {}
    while s_date <= e_date
      date_hash_w[s_date] = date_hash[s_date]
      s_date += 1
    end
    return date_hash_w
  end

  def id_params #教材情報取得
    @textbook = Textbook.find(params[:id])
  end

  def textbook_params #教材情報をフォームから取得
    params.require(:textbook).permit(:book, :s_page, :e_page, :image).merge(user_id: current_user.id)
  end
  
end
