class AccessToken < ActiveRecord::Base

  belongs_to :user

  serialize :property, JSON

  validates :property, presence: true

end
