class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, flash: {success: "密码找回邮件已经发送到你邮箱，请在2小时内重置密码！"}
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "密码重置连接已过时，请重新重置！"
    elsif @user.update_attributes(user_params)
      login_as(@user, false)
      redirect_to root_url, flash: {success: "密码已经重置！"}
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
