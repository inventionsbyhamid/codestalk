class CodechefId < ActiveRecord::Base
  belongs_to :user
  validates :username, presence: true
  validates_uniqueness_of :username,:scope=>[:user_id]
end
