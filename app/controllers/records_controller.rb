class RecordsController < ApplicationController
  before_action :textbook_id_params, only: [:new]
  def new
    @record = Record.new
  end

  def create
    binding.pry
    @record = Record.new(:record_params)
    if @record.save
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
    params.require(:record).permit(:r_date, :r_time, :r_page, :r_text).merge(textbook_id: @textbook.id)
  end
end

