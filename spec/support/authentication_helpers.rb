def sign_in(user)
  @auth_headers = {
    # 'Content-Type'    => 'application/json',
    'HTTP_X_AUTH_TOKEN' => AuthToken.create(user)
  }
end

# rubocop:disable Style/TrivialAccessors
def auth_headers
  @auth_headers
end
# rubocop:enable Style/TrivialAccessors
