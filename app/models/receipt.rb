class Receipt < ActiveRecord::Base
  belongs_to :order

  validates_presence_of :name, :tel, :address, :country, :city


  def country_name
    if self.country == "TW"
      "Taiwan"
    else
      country = ISO3166::Country[self.country]
      country.name
    end
  end

end
