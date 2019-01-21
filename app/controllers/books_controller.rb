class BooksController < ApplicationController
  before_action :find_book, except: %i(index)
  before_action :status_follow_book, :status_like_book, only: %i(show)

  def index
    @books = Book.select_attr.page(params[:page]).per(Settings.book_per_page)
      .search params[:search]
    @categories = Category.select_attr
    respond_to do |format|
      format.html {}
      format.csv { send_data Book.search(params[:search]).to_csv }
      format.xls { send_data Book.search(params[:search]).to_csv }
    end
  end

  def show
    @borrow = current_user.borrows.new if logged_in?
  end

  private

  def find_book
    return if @book = Book.find_by(id: params[:id])
    flash[:danger] = t "books.find.fail"
    redirect_to books_path
  end

  def status_follow_book
    return unless logged_in?
    @follow_book = @book.follow_books.build || @book.follow_books.find_by(book_id: @book.id)
  end

  def status_like_book
    return unless logged_in?
    @like_book = @book.like_books.build || @book.like_books.find_by(book_id: @book.id)
  end
end
