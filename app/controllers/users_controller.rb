class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]
  before_action :redirect_if_authenticated, only: [:new, :create] 

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      SendWelcomeEmailJob.set(wait: 20.second).perform_later(user)
      # UserMailer.with(user: user).welcome_email(user.email).deliver_now
      redirect_to root_path, flash: { success: 'Registration successfully' }
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
