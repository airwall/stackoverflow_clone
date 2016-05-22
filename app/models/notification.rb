class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :question_id, :user_id, presence: true
end
