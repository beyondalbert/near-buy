class Feedback < ActiveRecord::Base
  validates :name, :email, :content, presence: true
end
