class LearningsController < ApplicationController
  def index
    
  end

  def new
    
  end

  def create
    @s_learning = SLearning.new(s_learnings_params)
    @textbook 0 Textbook.new(textbooks_params)

    redirect_to root_path
  end

  private

  def s_learnings_params
    params.permit(:subject).merge(user_id: current_user.id)
  end

  def textbooks_params
    today = Date.today
    e_date = today + 10 #後ほど目標日付の計算を行う。
    params.permit(:book, :s_page, :e_page).merge(s_date: today, e_date: e_date,s_learning_id: @s_learning.id )
  end

  def w_goals_params
    today = Date.today
    we_date = today + 7
    speed = 10
    w_page = params[:w_time] * speed

    params.permit(:w_time)
  end
end
