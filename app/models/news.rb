class News < ApplicationRecord
  validates :title, :body, presence: true
  validates :title, uniqueness: true

  scope :filter_by_language, lambda{ |language| where(language: language) }
end
