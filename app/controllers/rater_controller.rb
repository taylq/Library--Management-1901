class RaterController < ApplicationController
  before_action :find_book

  def create
    if user_signed_in?
      obj = params[:klass].classify.constantize.find_by id: params[:id]
      obj.rate params[:score].to_f, current_user, params[:dimension]
    end
    respond_to :js
  end

  private

  def find_book
    return if @book = Book.find_by(id: params[:id])
    flash[:danger] = t "books.find_fail"
    redirect_to books_path
  end
end
