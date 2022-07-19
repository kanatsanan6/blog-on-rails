# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    commenter { 'test commenter' }
    body { 'test body' }
    article { build(:article) }
  end
end
