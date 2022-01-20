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
    #学習時間の羅列
    @records = Record.where(textbook_id: @textbook.id)
    sum_time(@records)
    
    #日付でグループ化
    date_group_h = @records.group_by_day(:r_date).sum(:hours)
    date_group_m = @records.group_by_day(:r_date).sum(:minutes)
    date_hash = hours_conversion(date_group_h, date_group_m)
    
    #グラフに渡すハッシュの作成 今日を含む１週間分のハッシュを作成
    #今週のグラフと合計
    @tb_date = Date.today.beginning_of_week
    @te_date = Date.today.end_of_week
    @date_hash_t = chart_create(date_hash, @tb_date, @te_date)
    @sum_time_t = sum_time_week(date_group_h, date_group_m, @tb_date, @te_date)
    #先週のグラフと合計
    @lb_date = Date.today.prev_week
    @le_date = Date.today.prev_week(:sunday)
    @date_hash_l = chart_create(date_hash, @lb_date, @le_date)
    @sum_time_l = sum_time_week(date_group_h, date_group_m, @lb_date, @le_date)
    
  end

  private

  def sum_time_week(date_group_h, date_group_m, b_date, e_date)
    s_date = b_date
    sum_time = {}
    sum_hours = 0
    sum_minutes = 0
    week_group_h = @records.group_by_week(:r_date, week_start: :monday).sum(:hours)
    week_group_m = @records.group_by_week(:r_date, week_start: :monday).sum(:minutes)
    sum_hours = week_group_h[s_date]
    sum_minutes = week_group_m[s_date]
    hours = sum_minutes / 60
    sum_hours += hours
    sum_minutes %= 60
    sum_time[:hours] = sum_hours
    sum_time[:minutes] = sum_minutes
    return sum_time
  end

  def hours_conversion(date_group_h, date_group_m) #分を時間に変換{日付=>時間}を返す
    date_hash = {}
    date_group_h.each do |date_record_h|
      date_m = date_group_m[date_record_h[0]]
      hours = date_m / 60
      date_hash[date_record_h[0]] = date_record_h[1] + hours
    end
    return date_hash
  end

  def chart_create(date_hash, b_date, e_date) #グラフ用のハッシュ作成
    s_date = b_date
    date_hash_w = {}
    while s_date <= e_date
      date_hash_w[s_date] = date_hash[s_date]
      s_date += 1
    end
    return date_hash_w
  end

  def id_params
    @textbook = Textbook.find(params[:id])
  end

  def textbook_params
    params.require(:textbook).permit(:book, :s_page, :e_page, :image).merge(user_id: current_user.id)
  end

  def sum_time(records)
    @sum_hours = 0
    @sum_minutes = 0
    records.each do |record|
      @sum_hours += record.hours
      @sum_minutes += record.minutes
    end
    @sum_hours += @sum_minutes / 60
    @sum_minutes = @sum_minutes % 60
  end
  
end
