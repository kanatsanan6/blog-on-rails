# frozen_string_literal: true

class Article < ApplicationRecord
  validates :title, :body, presence: true
  validates :body, length: { minimum: 10 }

  has_many :comments
end
