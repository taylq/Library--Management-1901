class UsersController < ApplicationController
  before_action :find_user, except: %i(index new create)

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

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def find_user
    return if @user = User.find_by(id: params[:id])
    flash[:danger] = t "users.find.fail"
    redirect_to users_path
  end
end
