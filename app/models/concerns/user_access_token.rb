module UserAccessToken
  extend ActiveSupport::Concern

  included do

    has_one :access_token, dependent: :destroy

    def update_access_token(property)
      if self.access_token
        self.access_token.update!(property: property)
      else
        self.create_access_token!(property: property)
      end
    end
  end
end
