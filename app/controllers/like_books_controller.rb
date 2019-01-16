class LikeBooksController < ApplicationController
  before_action :logged_in_user

  def create
    @book = Book.find_by id: params[:book_id]
    @like_book = current_user.like_books.new book_id: params[:book_id]
    if @like_book.save
      respond_to do |format|
        format.html {redirect_to @book}
        format.js
      end
    end
  end

  def destroy
    @like_book = LikeBook.find_by id: params[:id]
    @book = Book.find_by id: @like_book.book_id
    @like_book.destroy
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end
end
