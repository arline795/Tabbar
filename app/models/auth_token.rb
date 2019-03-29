class AuthToken
  class << self
    def create(user)
      auth_hash = user.create_new_auth_token

      payload = {
        HTTP_UID: auth_hash['uid'],
        HTTP_ACCESS_TOKEN: auth_hash['access-token'],
        HTTP_CLIENT: auth_hash['client'],
        HTTP_EXPIRY: auth_hash['expiry']
      }

      JWT.encode payload, Rails.application.secrets.jwt_secret_key, 'none'
    end

    def for(user)
      @user = user
      latest_auth_hash

      payload = {
        HTTP_UID: user.email,
        HTTP_ACCESS_TOKEN: @auth_hash['token'],
        HTTP_CLIENT: @latest_key,
        HTTP_EXPIRY: @auth_hash['expiry']
      }

      JWT.encode payload, Rails.application.secrets.jwt_secret_key, 'none'
    end

    private

    def latest_auth_hash
      @latest_key = find_latest_or_create_token
      @auth_hash = @user.tokens[@latest_key]
    end

    def find_latest_or_create_token
      token = @user.tokens.keys.last
      return token if token.present?
      @user.create_new_auth_token
      @user.tokens.keys.last
    end
  end
end
