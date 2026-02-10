class ScrapingJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    task = Task.find(task_id)
    
    # Atualiza para processando
    task.update(status: :processing)

    # Chama Scraping
    puts "Iniciando scraping para: #{task.url}"
    scraper = WebmotorsScraper.new(task.url)
    data = scraper.scrape

    # Salva
    task.update(status: :completed, result: data, error_message: nil)
    puts "Scraping concluído: #{data}"

  rescue StandardError => e
    task.update(status: :failed, error_message: e.message)
    puts "Erro no scraping: #{e.message}"    
  end
end