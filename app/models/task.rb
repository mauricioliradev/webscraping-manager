class Task < ApplicationRecord
  enum :status, { pending: 0, processing: 1, completed: 2, failed: 3 }

  validates :url, presence: true
  validates :title, presence: true
end