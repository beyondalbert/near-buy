class UsersController < ApplicationController
  layout "user", except: [:edit]
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_as(@user, false)
      redirect_to root_url, flash: {success: "注册成功！"}
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
    @addresses = @user.addresses
  end

  def update
    @user = User.find(params[:id])

    @user.update(user_params)
    redirect_to root_url, flash: {success: "更新个人资料成功！"}
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :phone, :sns_type, :sns_num)
  end
end
