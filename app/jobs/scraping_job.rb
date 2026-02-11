# frozen_string_literal: true

class ScrapingJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    task = Task.find(task_id)

    # Atualiza para processando
    task.update(status: :processing)

    # Chama Scraping
    Rails.logger.debug { "Iniciando scraping para: #{task.url}" }
    scraper = WebmotorsScraper.new(task.url)
    data = scraper.scrape

    # Salva
    task.update(status: :completed, result: data, error_message: nil)

    send_notification(task, 'task_completed', data)
  rescue StandardError => e
    task.update(status: :failed, error_message: e.message)

    send_notification(task, 'task_failed', { error: e.message })
  end

  private

  def send_notification(task, event_type, data = {})
    user_info = { id: task.user_id }

    client = NotificationClient.new
    client.notify(task.id, event_type, user_info, data)
  end
end
