class BooksController < ApplicationController
  before_action :baria_book, only: [:edit, :destroy, :update]
  helper_method :sort_column, :sort_direction

  def index
    @books = Book.all
    @book = Book.new
    @sort = @books.order("#{sort_column} #{sort_direction}")
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
    @book_comment=BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
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
    params.require(:book).permit(:title, :body, :rate, :category_id)
  end

  def baria_book
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end
  
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end
  
  def sort_column
    Book.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end


end
