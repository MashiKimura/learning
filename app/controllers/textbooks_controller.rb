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
    @records = Record.where(textbook_id: @textbook.id)
    sum_time(@records)
  end

  private

  def id_params
    @textbook = Textbook.find(params[:id])
  end

  def textbook_params
    params.require(:textbook).permit(:book, :s_page, :e_page).merge(user_id: current_user.id)
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
