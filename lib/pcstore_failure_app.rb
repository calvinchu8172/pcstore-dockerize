class PcstoreFailureApp < Devise::FailureApp
  def route(scope)
    :products_url
  end
end