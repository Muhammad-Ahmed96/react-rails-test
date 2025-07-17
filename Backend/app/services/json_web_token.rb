module JsonWebToken
  SECRET_KEY = Rails.application.credentials.dig(:secret_key_base)

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY).first
  rescue JWT::ExpiredSignature
    { error: "Auth Token has expired" }
  rescue JWT::DecodeError
    { error: "Invalid auth token" }
  end
end
