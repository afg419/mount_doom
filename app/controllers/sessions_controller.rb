class SessionsController < ApplicationController
  def new
    render layout: 'wide',  :locals => {:background => "start"}
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.username}"
      if @user.role == "admin"
        redirect_to admin_dashboard_index_path
      else
        redirect_to user_path(@user)
      end
    else
      flash.now[:error] = "Invalid Login. Try Again."
      render :new, layout: 'wide',  :locals => {:background => "start"}
    end
  end

  def destroy
    flash[:error] = "Successfully Logged Out!"
    session.clear
    redirect_to root_path
  end
end
