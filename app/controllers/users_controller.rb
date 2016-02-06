class UsersController < ApplicationController
  before_action :require_current_user, only: [:edit, :update]
  before_action :user_logged_in?, only: [:show, :edit]

  def new
    @user = User.new
    render layout: 'wide',  :locals => {:background => "start"}
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.username}"
      redirect_to user_path(@user)
    else
      flash.now[:error] = @user.errors.full_messages.join(', ')
      render :new, layout: 'wide',  :locals => {:background => "start"}
    end
  end

  def show
    if current_user.admin?
      redirect_to admin_dashboard_index_path
    else
      render layout: 'wide',  :locals => {:background => "dashboard"}
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    flash.notice = "Your Account Has Been Updated!"
    redirect_to dashboard_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
