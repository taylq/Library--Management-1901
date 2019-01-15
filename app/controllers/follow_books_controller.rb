class FollowBooksController < ApplicationController
  before_action :logged_in_user

  def create
    @book = Book.find_by id: params[:book_id]
    @follow_book = current_user.follow_books.new book_id: params[:book_id]
    if @follow_book.save
      respond_to do |format|
        format.html {redirect_to @book}
        format.js
      end
    end
  end

  def destroy
    @follow_book = FollowBook.find_by id: params[:id]
    @book = Book.find_by id: @follow_book.book_id
    @follow_book.destroy
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end
end
