class Handle < ActiveRecord::Base
  has_and_belongs_to_many :users, :uniq => true
  validates :username, presence: true, length: {maximum: 25}
end
