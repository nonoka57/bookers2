class UsersController < ApplicationController

  def index
    @book = Book.new
    @users = User.all
  end


  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.where(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You habe updated user successfully."
      redirect_to books_path
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
