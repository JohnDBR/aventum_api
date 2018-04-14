require 'jwt'
require 'bcrypt'

class AuthenticationService
  include BCrypt

  def initialize hmac_secret
    @hmac_secret = hmac_secret
  end

  def password_hash pass
    Password.create pass
  end

  def get_password pass
    Password.new pass
  end

  def create_token id, exp
    payload = {
      id: id,
      iat: Time.now.to_i,
      exp: Time.now.to_i + exp
    }
    JWT.encode payload, @hmac_secret, 'HS256'
  end

  def decode_token token
    JWT.decode token, @hmac_secret, true, { :algorithm => 'HS256' }
  end

end