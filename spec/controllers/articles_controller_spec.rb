# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let!(:article1) { create(:article, title: 'Test article1') }
  let!(:article2) { create(:article, title: 'Test article2') }

  describe 'GET #index' do
    subject { get :index }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to render_template('index') }

    it 'returns articles' do
      subject
      expect(assigns(:articles)).to match_array [article1, article2]
    end
  end

  describe 'GET #show' do
    let(:params) { { id: article1.id } }
    subject { get :show, params: params }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to render_template('show') }

    it 'returns article' do
      subject
      expect(assigns(:article)).to eq article1
    end
  end

  describe 'GET #new' do
    subject { get :new }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to render_template('new') }

    it 'creates new instance' do
      subject
      expect(assigns(:article).title).to eq nil
      expect(assigns(:article).body).to eq nil
    end
  end

  describe 'POST #create' do
    context 'creates a new article successfully' do
      let(:params) { { article: { title: 'Title', body: 'This is a body' } } }
      subject { post :create, params: params }

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to article_path(assigns(:article)) }

      it 'creates a new article' do
        subject
        expect(assigns(:article).title).to eq 'Title'
        expect(assigns(:article).body).to eq 'This is a body'
      end
    end

    context 'connot create a new article' do
      let(:params) { { article: { title: '', body: '' } } }
      subject { post :create, params: params }

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it { is_expected.to render_template('new') }
    end
  end

  describe 'GET #edit' do
    context 'found the article which needs to update' do
      let(:params) { { id: article1.id } }
      subject { get :edit, params: params }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template('edit') }

      it 'returns the article' do
        subject
        expect(assigns(:article)).to eq article1
      end
    end

    context 'connot find the article which needs to update' do
      let(:params) { { id: 999_999 } }
      subject { get :edit, params: params }

      it 'returns an error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PATCH #update' do
    context 'update the article successfully' do
      let(:params) { { id: article2.id, article: { title: 'updated Title', body: 'This is updated body' } } }
      subject { post :update, params: params }

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to article_path(assigns(:article)) }

      it 'updates the article' do
        subject
        expect(assigns(:article).title).to eq 'updated Title'
        expect(assigns(:article).body).to eq 'This is updated body'
      end
    end

    context 'connot update the article' do
      let(:params) { { id: article2.id, article: { title: 'updated Title', body: '' } } }
      subject { post :update, params: params }

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it { is_expected.to render_template('edit') }
    end
  end

  describe 'DELETE #destroy' do
    let(:params) { { id: article1.id } }
    subject { delete :destroy, params: params }

    it { is_expected.to have_http_status(302) }
    it { is_expected.to redirect_to root_url }

    it 'deletes the article' do
      expect { subject }.to change(Article, :count).by(-1)
    end
  end
end
