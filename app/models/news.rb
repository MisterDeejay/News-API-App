class News < ApplicationRecord
  validates_presence_of :title, :body

  scope :filter_by_language, lambda{ |language| where(language: language) }
end
