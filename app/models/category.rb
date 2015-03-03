class Category < ActiveRecord::Base
  include SoftDestroy
  has_many :products

  default_scope { where(is_deleted: false) }

end
