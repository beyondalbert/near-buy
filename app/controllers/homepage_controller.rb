class HomepageController < ApplicationController
  skip_before_action :require_login
  def index
    @user = User.new
  end
end
