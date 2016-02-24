class CodechefId < ActiveRecord::Base
  belongs_to :user
  validates :username, presence: true, length: {maximum: 25}
  validates_uniqueness_of :username,:scope=>[:user_id]
end
