class GoalsController < ApplicationController
  before_action :textbook_id_params, only: [:new,:create]
  def new
    @df_time = DfTime.new
  end

  def create
    @df_time = DfTime.new(params_df_time)
    if @df_time.save
      redirect_to textbook_path(@textbook)
    else
      render :new
    end
  end

  private

  def textbook_id_params
    @textbook = Textbook.find(params[:textbook_id])
  end

  def params_df_time
    params.require(:df_time).permit(:d_mon, :d_tue, :d_wed, :d_thu, :d_fri, :d_sat, :d_sun).merge(textbook_id: @textbook.id)
  end
  
end