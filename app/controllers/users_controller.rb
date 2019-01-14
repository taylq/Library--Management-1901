class UsersController < ApplicationController
  before_action :find_user, except: %i(index new create)
  before_action :logged_in_user, only: %i(index following followers)
  before_action :status_relationship, only: %i(show following followers)

  def index
    @users = User.select_attr.page(params[:page]).per(Settings.per_page).search params[:search]
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "users.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def following
    @title = t "users.following"
    @users = @user.following.page(params[:page]).per(Settings.per_page)
    render "show_follow"
  end

  def followers
    @title = t "users.followers"
    @users = @user.followers.page(params[:page]).per(Settings.per_page)
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def find_user
    return if @user = User.find_by(id: params[:id])
    flash[:danger] = t "users.find.fail"
    redirect_to users_path
  end

  def status_relationship
    return unless logged_in?
    @active_relationships = current_user.active_relationships.build
    @inactive_relationships = current_user.active_relationships.find_by(followed_id: @user.id)
  end
end
