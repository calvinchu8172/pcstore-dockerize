class WelcomeController < ApplicationController
  before_action :set_cart

  layout "welcome"

  def index
  end
end
