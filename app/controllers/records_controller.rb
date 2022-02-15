class RecordsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :edit, :update]
  before_action :textbook_id_params, only: [:new, :create, :edit, :update]
  before_action :user_match, only: [:new, :create, :edit, :update]
  before_action :find_record, only: [:edit, :update]

  def new
    @record = Record.new
    records = Record.where(textbook_id: textbook_id_params)
    @max_page = records.maximum(:r_page)
  end

  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to textbook_path(@textbook.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @record.update(record_params)
      redirect_to textbook_path(@record.textbook)
    else
      render :edit
    end
  end

  private

  def textbook_id_params
    @textbook = Textbook.find(params[:textbook_id])
  end

  def record_params
    r_date = params.require(:record).permit(:r_date)
    @date = Date.parse(r_date['r_date(1i)'] + '-' + r_date['r_date(2i)'] + '-' + r_date['r_date(3i)'])
    record = params.require(:record).permit(:hours, :minutes, :r_page, :r_text).merge(textbook_id: @textbook.id, r_date: @date)
    record = hours_and_minutes_into_zero(record)
  end

  def find_record
    @record = Record.find(params[:id])
  end

  def hours_and_minutes_into_zero(record)
    record[:hours] = record[:hours].to_i
    record[:minutes] = record[:minutes].to_i
    record[:r_page] = record[:r_page].to_i
    record
  end

  def authenticate_user
    redirect_to new_user_session_path unless user_signed_in?
  end

  def user_match
    redirect_to root_path unless current_user == @textbook.user
  end
end
