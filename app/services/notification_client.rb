# frozen_string_literal: true

class NotificationClient
  BASE_URL = ENV['NOTIFICATION_SERVICE_URL'] || 'http://notification-service:3000'

  def initialize
    @conn = Faraday.new(url: BASE_URL) do |f|
      f.request :json
      f.response :json
      f.adapter :net_http
    end
  end

  def notify(task_id, event_type, user_data = {}, collected_data = {})
    payload = {
      notification: {
        task_id: task_id,
        event_type: event_type,
        data: {
          user: user_data,
          result: collected_data
        }
      }
    }

    response = @conn.post('/notifications', payload)

    if response.success?
      Rails.logger.info "Notificação enviada: #{event_type} (Task #{task_id})"
    else
      Rails.logger.error "Falha ao notificar: #{response.body}"
    end
  rescue StandardError => e
    Rails.logger.error "Erro de conexão com Notification Service: #{e.message}"
  end
end
