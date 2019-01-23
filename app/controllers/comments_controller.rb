class CommentsController < ApplicationController
  before_action :correct_user, only: :destroy

  def create
    @comment = current_user.comments.build comment_params.merge(book_id: params[:book_id])
    @comments = @comment.book.comments
    @comment_book = @comment.book
    if @comment.save
      respond_to do |format|
        format.html {redirect_to @comment}
        format.js
      end
    else
      redirect_to book_path @comment_book
    end
  end

  def destroy
    @comments = @comment.book.comments
    @comment_book = @comment.book
    if @comment.destroy
      respond_to do |format|
        format.html {redirect_to request.referrer || root_url}
        format.js
      end
    else
      redirect_to book_path @comment_book
    end
  end

  private

  def comment_params
    params.require(:comment).permit :user_id, :content, :book_id
  end

  def correct_user
    @comment = current_user.comments.find_by id: params[:id]
    redirect_to root_url if @comment.nil?
  end
end
