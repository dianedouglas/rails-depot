class SessionsController < ApplicationController
  skip_before_action :authorize
  # to only allow certain actions say skip_before_action :authorize, only: [:new, :create]
  def new
    # loads login form.
  end

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    # delete user id stored in session.
    session[:user_id] = nil
    redirect_to store_url, notice: "Logged out"
  end
end
