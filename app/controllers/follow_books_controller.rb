class FollowBooksController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find_by id: params[:book_id]
    current_user.follow_book @book
    @follow_book = current_user.follow_books.find_by book_id: @book.id
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end

  def destroy
    @book = FollowBook.find_by(id: params[:id]).book
    current_user.unfollow_book @book
    @follow_book = current_user.follow_books.build
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end
end
