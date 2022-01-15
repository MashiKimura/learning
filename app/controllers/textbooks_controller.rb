class TextbooksController < ApplicationController
  def index
    
  end
  def new
    @textbook = Textbook.new
  end
  def create
    @textbook =Textbook.new(textbook_params)
    if @textbook.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def textbook_params
    params.require(:textbook).permit(:book, :s_page, :e_page).merge(user_id: current_user.id)
  end
end
