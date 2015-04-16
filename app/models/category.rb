class Category < ActiveRecord::Base
  include SoftDestroy
  has_many :products

  validates_presence_of :name

  default_scope { where(is_deleted: false) }

end

  # Eve's demo for after_commit of sending email
  # after_commit :send_email, on: %i(update)
  # def send_email
    #
  # end