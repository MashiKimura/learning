class RecordsController < ApplicationController
  before_action :textbook_id_params, only: [:new, :create]
  def new
    @record = Record.new
    records = Record.where(textbook_id: textbook_id_params)
    @max_page = records.maximum(:r_page)
  end

  def create
    @record = Record.new(record_params)
    @record = hours_and_minutes_into_zero(@record)
    if @record.save
      # redirect_to textbook_path(@textbook.id)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def textbook_id_params
    @textbook = Textbook.find(params[:textbook_id])
  end

  def record_params
    r_date = params.require(:record).permit(:r_date)
    @date = Date.parse(r_date["r_date(1i)"] + "-" + r_date["r_date(2i)"] + "-" + r_date["r_date(3i)"])
    params.require(:record).permit(:hours, :minutes, :r_page, :r_text).merge(textbook_id: @textbook.id, r_date: @date)
  end

  def hours_and_minutes_into_zero(record)
    if record.hours == nil
      record.hours = 0
    end
    if record.minutes == nil
      record.minutes = 0
    end
    return record
  end
end

