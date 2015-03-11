class Receipt < ActiveRecord::Base
  belongs_to :order

  validates_presence_of :name, :tel, :address, :country, :city
end
