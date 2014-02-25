class FeedbacksController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_admin, only: [:index]

  def index
    @feedbacks = Feedback.all
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      redirect_to new_feedback_path, flash: { success: "反馈提交成功，我们会尽快联系你的^-^"}
    else
      render "new"
    end
  end
  
  private

  def feedback_params
    params.require(:feedback).permit(:name, :email, :content)
  end
end
