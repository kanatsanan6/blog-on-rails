# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'valid factory' do
    subject { build(:comment) }

    it { is_expected.to be_valid }
  end
end
