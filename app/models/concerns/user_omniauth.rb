module UserOmniauth
  extend ActiveSupport::Concern

  included do

    has_many :omniauths, dependent: :destroy

    def bind_omniauth_service(auth)
      self.omniauths.create(user_id: self.id, provider: auth.provider, uid: auth.uid, image: auth.info.image)
    end
  end

  class_methods do

    # 1. check omniauth is existed or not.
    # 2. check omniauth's email is registered or not.
    # 3. new a user by omniauth data.
    # 4. bind omniauth service
    def find_or_create_by_omniauth(auth)
      unless user = find_by_omniauth(auth)
        unless user = find_by_email(auth.info.email)
          user = create_by_omniauth(auth)
        end
        user.bind_omniauth_service(auth)
      end
      user
    end

    def find_by_omniauth(auth)
      includes(:omniauths).find_by(omniauths: { provider: auth.provider, uid: auth.uid })
    end

    def create_by_omniauth(auth)
      create(email: auth.info.email, password: Devise.friendly_token[0, 20], confirmed_at: Time.now)
    end
  end
end
