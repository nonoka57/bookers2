class UsersController < ApplicationController

  def index
    @book = Book.new
    @user = User.where(params[:id])
  end


  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end
  
  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to new_user_registration_path
    end
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
