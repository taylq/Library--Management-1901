class LikeBooksController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find_by id: params[:book_id]
    current_user.like_book @book
    @like_book = current_user.like_books.find_by book_id: @book.id
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end

  def destroy
    @book = LikeBook.find_by(id: params[:id]).book
    current_user.dislike_book @book
    @like_book = current_user.like_books.build
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end
end
