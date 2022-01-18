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

    
    
    # array = []
    # @records.each do |record|
    #   #配列宣言　日付毎の集計
    #   g_records = @records.where(r_date: record.r_date)
    #   g_date = ""
    #   sum_hours = 0 
    #   sum_minutes = 0
    #   #日付毎に時間と分を集計
    #   g_records.each do |g_record|
    #     g_date = g_record.r_date
    #     sum_hours += g_record.hours
    #     sum_minutes += g_record.minutes
    #   end
    #   array << {r_date: g_date, hours: sum_hours, minutes: sum_minutes }
    # end
    #日付でグループ化
    @date_group_h = @records.group_by_day(:r_date).sum(:hours)
    @date_group_m = @records.group_by_day(:r_date).sum(:minutes)
    # @date_array = []
    @date_hash = {}
    @date_group_h.each do |date_record_h|
      date_m = @date_group_m[date_record_h[0]]
      # date_hash = {}
      # date_hash[:date] = date_record_h[0]
      hours = date_m / 60
      # date_hash[:hours] = date_record_h[1] + hours
      # date_hash[:minutes] = date_m % 60
      # @date_array << date_hash
      @date_hash[date_record_h[0]] = date_record_h[1] + hours
    end
    
    
  end

  private

  def id_params
    @textbook = Textbook.find(params[:id])
  end

  def textbook_params
    params.require(:textbook).permit(:book, :s_page, :e_page).merge(user_id: current_user.id)
  end

  def sum_time(records) #学習時間の合計 合計を使用しなければ必要なし
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
