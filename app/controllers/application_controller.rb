class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  before_action :require_login

  private

  def require_login
    if current_user.nil?
      redirect_to login_path
    end
  end

  def require_admin
    if current_user.nil?
      redirect_to login_path
    else
      if !current_user.admin?
        render_403
      end
    end
  end

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:user]) if cookies[:user]
  end

  def login_as(user, remember_me)
    if remember_me
      cookies[:user] = {value: user.auth_token, expires: 2.weeks.from_now}
    else
      cookies[:user] = user.auth_token
    end
    @current_user = user
  end

  def render_403(options={})
    render_error({:message => "对不起，您无权访问此页面。", :status => 403}.merge(options))
    return false
  end

  def render_404(options={})
    render_error({:message => "您访问的页面不存在或已被删除。", :status => 404}.merge(options))
    return false
  end

  # 用于错误页面的处理
  def render_error(arg)
    arg = {:message => arg} unless arg.is_a?(Hash)
    @message = arg[:message]
    @status = arg[:status] || 500
    respond_to do |format|
      format.html {
        render :template => 'common/error', :layout => false, :status => @status
      }
    end
  end

end
