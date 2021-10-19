class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
  end

  def show
    @books = Book.find(params[:id])
    @book = Book.new
    @user = User.find_by(params[:id])
    @users = @books.user
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
      redirect_to new_user_registration_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="You habe updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @books = Book.find(params[:id])
    @books.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
