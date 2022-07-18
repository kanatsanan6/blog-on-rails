# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:article) { create(:article, title: 'Test title') }
  let!(:comment) { create(:comment, commenter: 'Test commenter', body: 'Test body') }

  describe 'POST #create' do
    let(:params) { { article_id: article.id, comment: { commenter: 'Test commenter', body: 'Test body' } } }
    subject { post :create, params: params }

    it { is_expected.to have_http_status(302) }
    it { is_expected.to redirect_to article_path(assigns(:article)) }

    it 'creates a new comment' do
      subject
      expect(assigns(:article)).to eq article
      expect(assigns(:comment).commenter).to eq 'Test commenter'
      expect(assigns(:comment).body).to eq 'Test body'
    end
  end
end
