class TextbooksController < ApplicationController
  before_action :id_params, only: [:show, :destroy]
  def index
    @textbooks = Textbook.where(user: current_user)
  end
  def new
    @textbook = Textbook.new
  end
  def create
    @textbook = Textbook.new(textbook_params)
    if @textbook.save
      dftime = DfTime.create(textbook_id: @textbook.id)
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

    #dataに渡す目標時間
    @df_time_data = bar_data_dftime(@textbook)

    #ラベルに渡す日付(今日)
    @b_date = Date.today.beginning_of_week
    @e_date = Date.today.end_of_week
    week_date = week_date_calc(@b_date, @e_date)
    @week_date = week_date.to_json.html_safe

    #学習記録の最新日付の取得
    arrays = date_hash.keys
    @max_date = arrays.max

    #学習記録がある場合
    if @max_date.present?
      #グラフ-1
        #グラフ-1に渡す日付(1番目のグラフ)
        @tb_date = @max_date.beginning_of_week
        @te_date = @max_date.end_of_week
        week_date = week_date_calc(@tb_date, @te_date)
        @week_date = week_date.to_json.html_safe
        #グラフ-1に渡す学習時間
        @b_data = bar_data_record(date_hash,week_date)
        @sum_time_t = sum_time_week(@tb_date, @te_date)

      #グラフ-2
        #グラフ-2に渡す日付(2番目のグラフ)
        @lb_date = @max_date.prev_week
        @le_date = @max_date.prev_week(:sunday)
        week_date = week_date_calc(@lb_date, @le_date)
        @week_date_l = week_date.to_json.html_safe
        #グラフ-2に渡す学習時間
        @prev_week_present = date_hash.find{ |x| (x[0] >= @lb_date) && (x[0] <= @le_date) && (x[1] > 0)}
        if @prev_week_present.present?
          @b_data_l = bar_data_record(date_hash,week_date)
          @sum_time_l = sum_time_week(@lb_date, @le_date)
        end
    end

  end

  def destroy
    @textbook.destroy
    redirect_to root_path
  end

  private

  def bar_data_dftime(textbook) #目標学習時間を配列に格納
    df_time = DfTime.find_by(textbook_id: textbook.id)
    df_times = []
    df_times << df_time.d_mon
    df_times << df_time.d_tue
    df_times << df_time.d_wed
    df_times << df_time.d_thu
    df_times << df_time.d_fri
    df_times << df_time.d_sat
    df_times << df_time.d_sun
    return df_times
  end

  def bar_data_record(date_hash, week_date)
    b_data = []
    week_date.each do |d|
      if date_hash[d].present?
        b_data << date_hash[d]
      else
        b_data << 0
      end
    end
    return b_data
  end

  def week_date_calc(b_date, e_date) #date型を２つ渡し、その間の日付を配列に格納する
    w_date = []
    s_date = b_date
    while s_date <= e_date
      w_date << s_date
      s_date += 1
    end
    return w_date
  end

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

  def id_params #教材情報取得
    @textbook = Textbook.find(params[:id])
  end

  def textbook_params #教材情報をフォームから取得
    params.require(:textbook).permit(:book, :s_page, :e_page, :image).merge(user_id: current_user.id)
  end
  
end
