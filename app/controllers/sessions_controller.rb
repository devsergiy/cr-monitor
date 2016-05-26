class SessionsController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    redirect_to root_path if current_user
  end

  def create
    user = User.find_by_email(session_params[:email])

    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Signed in'
      redirect_to root_url
    else
      flash[:error] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logged out'
    redirect_to root_url
  end

  protected

  def session_params
    @params ||= params.require(:session).permit(:email, :password)
  end
end
