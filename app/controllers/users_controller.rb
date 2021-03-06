class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome aboard, thank you for signing up!"
      redirect_to user_url(@user)
    else
      flash[:danger] = "Sorry, but an error has occurred. Please check the
error messages below and fix your form accordingly :-)"
      render new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
