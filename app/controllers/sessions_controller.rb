class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to questions_path, notice: "Hi, #{@user.name}!"
    else
      redirect_to root_path
    end
  end

  def destroy
    @user = User.find(session.delete(:user_id))
    redirect_to root_path, notice: "Bye #{@user.name}!"
  end

end
