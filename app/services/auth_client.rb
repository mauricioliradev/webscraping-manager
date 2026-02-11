# frozen_string_literal: true

class AuthClient
  BASE_URL = ENV['AUTH_SERVICE_URL'] || 'http://auth-service:3000'

  def initialize
    @conn = Faraday.new(url: BASE_URL) do |f|
      f.request :json
      f.response :json
      f.adapter :net_http
    end
  end

  def login(email, password)
    response = @conn.post('/auth/login', { email: email, password: password })
    handle_response(response)
  rescue Faraday::ConnectionFailed
    { success: false, error: 'Serviço de Autenticação indisponível' }
  end

  def register(email, password, password_confirmation)
    response = @conn.post('/auth/register', {
                            email: email,
                            password: password,
                            password_confirmation: password_confirmation
                          })
    handle_response(response)
  rescue Faraday::ConnectionFailed
    { success: false, error: 'Serviço de Autenticação indisponível' }
  end

  private

  def handle_response(response)
    if response.status.between?(200, 299)
      { success: true, data: response.body }
    else
      error_msg = response.body['error'] || response.body['errors']&.join(', ') || 'Erro desconhecido'
      { success: false, error: error_msg }
    end
  end
end
