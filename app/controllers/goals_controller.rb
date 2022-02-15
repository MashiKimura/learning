class GoalsController < ApplicationController
  before_action :textbook_id_params, only: [:edit, :update]
  before_action :authenticate_user, only: [:edit, :update]
  before_action :user_match, only: [:edit, :update]

  def edit
    @df_time = DfTime.find_by(textbook_id: @textbook.id)
  end

  def update
    @df_time = DfTime.find_by(textbook_id: @textbook.id)
    if @df_time.update(params_df_time)
      redirect_to textbook_path(@textbook)
    else
      render :edit
    end
  end

  private

  def textbook_id_params
    @textbook = Textbook.find(params[:textbook_id])
  end

  def params_df_time
    params.require(:df_time).permit(:d_mon, :d_tue, :d_wed, :d_thu, :d_fri, :d_sat, :d_sun).merge(textbook_id: @textbook.id)
  end

  def authenticate_user
    redirect_to new_user_session_path unless user_signed_in?
  end

  def user_match
    redirect_to root_path unless current_user == @textbook.user
  end
end
