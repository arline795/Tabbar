module AuthenticateUser
  require 'jwt'

  def find_current_user
    @current_user = user if auth_hash.present? && valid_auth_hash? && valid_user?
  end

  private

  def auth_hash
    return if auth_token.blank?
    decode_token!
  rescue JWT::DecodeError
    nil
  end

  def decode_token!
    (JWT.decode auth_token, Rails.application.secrets.jwt_secret_key, false).first
  end

  def auth_token
    request.headers['HTTP_X_AUTH_TOKEN']
  end

  def valid_auth_hash?
    auth_hash['HTTP_UID'].present? &&
      auth_hash['HTTP_ACCESS_TOKEN'].present? &&
      auth_hash['HTTP_CLIENT'].present? &&
      auth_hash['HTTP_EXPIRY'].present?
  end

  def user
    User.find_by(uid: auth_hash['HTTP_UID'])
  end

  def valid_user?
    return if user.tokens[auth_hash['HTTP_CLIENT']].blank?
    validate_user_token && expiration_date > Time.zone.now
  end

  def validate_user_token
    user.tokens[auth_hash['HTTP_CLIENT']].present? ||
      (user.tokens[auth_hash['HTTP_CLIENT']]['token'] ==
      auth_hash['HTTP_ACCESS_TOKEN'])
  end

  def expiration_date
    Time.zone.at(auth_hash['HTTP_EXPIRY'].to_i).to_datetime
  end
end
