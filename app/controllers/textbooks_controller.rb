class TextbooksController < ApplicationController
  before_action :id_params, only: [:show, :destroy]
  before_action :authenticate_user, only: [:new, :create, :show, :destroy]
  before_action :user_match, only: [:show, :destroy]

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
    # 学習時間配列の取得
    @records = Record.where(textbook_id: @textbook.id).order(r_date: 'DESC')

    # 日付でグループ化
    date_group_h = @records.group_by_day(:r_date).sum(:hours)
    date_group_m = @records.group_by_day(:r_date).sum(:minutes)
    date_hash = hours_conversion(date_group_h, date_group_m)

    # dataに渡す目標時間
    @df_time_data = bar_data_dftime(@textbook)

    # ラベルに渡す日付(今日)
    # @b_date, @e_date, week_date, @week_date = week_date_set(Date.today) 変更済み
    @week_date_first, @week_date_f_json = week_date_set(Date.today)
    
    # 学習記録の最新日付の取得
    arrays = date_hash.keys
    @max_date = arrays.max
    
    # 学習記録がある場合
    if @max_date.present?
      # グラフ-1
      # グラフ-1に渡す日付(1番目のグラフ)
      # @tb_date, @te_date, @week_date_first, @week_date_f_json = week_date_set(@max_date) 変更済み
      @week_date_first, @week_date_f_json = week_date_set(@max_date)
      # グラフ-1に渡す学習時間
      @b_data = bar_data_record(date_hash, @week_date_first)
      @sum_time_t = sum_time_week(@week_date_first[0], @week_date_first[6])

      # グラフ-2
      # グラフ-2に渡す日付(2番目のグラフ)
      # @lb_date, @le_date, @week_date_second, @week_date_l = week_date_set(@max_date.weeks_ago(1)) 変更済み
      @week_date_second, @week_date_s_json = week_date_set(@max_date.weeks_ago(1))

      # グラフ-2に渡す学習時間
      @prev_week_present = date_hash.find { |x| (x[0] >= @week_date_second[0]) && (x[0] <= @week_date_second[6]) && (x[1] > 0) }
      if @prev_week_present.present?
        @b_data_l = bar_data_record(date_hash, @week_date_second)
        @sum_time_l = sum_time_week(@week_date_second[0], @week_date_second[6])
        
      end

      # 学習速度計算
      max_page = @records.maximum('r_page')
      progress_page = max_page - @textbook.s_page
      sum_hours = @records.sum(:hours)
      sum_minutes = @records.sum(:minutes)
      sum_time = calc_times(sum_hours, sum_minutes)
      @learning_speed = progress_page / (sum_time[:hours] + (sum_time[:minutes].to_f / 60))

      # 1日の目標学習時間
      today = Date.today
      today_wday = if today.wday == 0
                     6
                   else
                     today.wday - 1
                   end
      @df_time_today = @df_time_data[today_wday]

      # １日の学習時間
      today_h = date_group_h[Date.today].to_i
      today_m = date_group_m[Date.today].to_i
      @today_time = calc_times(today_h, today_m)

      if @df_time_data.max > 0
        # 目標学習時間の合計とページの取得
        # 週間目標学習時間合計
        @df_time_sum = @df_time_data.sum
        # 週間目標学習時間
        i = today_wday
        remaining_time = 0
        num = 7 - i
        num.times do
          remaining_time += @df_time_data[i]
          i += 1
        end
        remaining_time -= if @today_time[:hours] > @df_time_today
                            @df_time_today
                          else
                            @today_time[:hours]
                          end
        # 週間目標学習ページ
        @df_time_page = (@learning_speed * remaining_time).ceil(0) + @records.maximum(:r_page)

        # 学習終了予定日
        remaining_page = @textbook.e_page - max_page
        necessary_time = (remaining_page / @learning_speed).ceil(0)
        necessary_week = necessary_time / @df_time_sum.to_f
        necessary_day = (necessary_week * 7).ceil
        @necessary_date = Date.today + necessary_day
      end

    end
  end

  def destroy
    @textbook.destroy
    redirect_to root_path
  end

  private

  def week_date_set(search_date)
    b_date = search_date.beginning_of_week
    e_date = search_date.end_of_week
    week_date = (b_date..e_date).to_a
    week_date_json = week_date.to_json.html_safe
    return week_date, week_date_json
  end

  def calc_times(hours, minutes)
    hours += minutes / 60
    minutes = minutes % 60
    sum_time = {}
    sum_time[:hours] = hours
    sum_time[:minutes] = minutes
    sum_time
  end

  def bar_data_dftime(textbook) # 目標学習時間を配列に格納
    df_time = DfTime.find_by(textbook_id: textbook.id)
    df_times = []
    df_times << df_time.d_mon
    df_times << df_time.d_tue
    df_times << df_time.d_wed
    df_times << df_time.d_thu
    df_times << df_time.d_fri
    df_times << df_time.d_sat
    df_times << df_time.d_sun
    df_times
  end

  def bar_data_record(date_hash, week_date)
    b_data = []
    week_date.each do |d|
      b_data << if date_hash[d].present?
                  date_hash[d]
                else
                  0
                end
    end
    b_data
  end



  def sum_time_week(b_date, _e_date) # 週間合計学習時間 date型、週初と週末を渡し、合計学習時間{hours: 数値,minutes: 数値}を返す
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
    sum_time
  end

  def hours_conversion(date_group_h, date_group_m) # 分を時間に変換する　{日付=>時間}{日付=>分}を渡して{日付=>時間}を返す ※分は返さない
    date_hash = {}
    date_group_h.each do |date_record_h|
      date_m = date_group_m[date_record_h[0]]
      hours = date_m / 60
      date_hash[date_record_h[0]] = date_record_h[1] + hours
    end
    date_hash
  end

  def id_params
    @textbook = Textbook.find(params[:id])
  end

  def textbook_params
    params.require(:textbook).permit(:book, :s_page, :e_page, :image).merge(user_id: current_user.id)
  end

  def authenticate_user
    redirect_to new_user_session_path unless user_signed_in?
  end

  def user_match
    redirect_to root_path unless current_user == @textbook.user
  end
end
