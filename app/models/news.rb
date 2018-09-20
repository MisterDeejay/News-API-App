class News < ApplicationRecord
  validates :title, :body, presence: true
  validates :title, uniqueness: true
end
