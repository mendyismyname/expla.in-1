class UsersController < ApplicationController
  authorize :user, only: :show

  before_action :set_user


  def new
    if current_user   
      redirect_to questions_path 
    end 
  end

  def create

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "Hi, #{@user.name}!"
    else
      flash[:error] = 'Something isn\'t right'
      render :new
    end
  end

  def show
  end

  private

    def set_user
      @user = if(id = params[:id])
                User.find(id)
              else
                User.new
              end
              
      @user.assign_attributes(user_params) if params[:user]
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio)
    end
end
