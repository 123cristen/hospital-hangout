class UsersController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Hospital Hangout!"
      redirect_to @user
    else
      message = pluralize(@user.errors.count, "error")
      flash.now[:danger] = "This form contains #{message}"
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :hospital_id, :password,
                                   :password_confirmation)
    end

end
