class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email_address: params[:session][:email_address])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid login"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:notice] = "Successfully logged out."
    redirect_to root_path
  end
end
