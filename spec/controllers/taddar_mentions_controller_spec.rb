require 'rails_helper'

RSpec.describe TaddarMentionsController, type: :controller do
  describe 'GET index' do
    let :params do
      {
        'hub.mode' => 'subscribe',
        'hub.challenge' => challenge,
        'hub.verify_token' => 'token'
      }
    end
    let(:challenge) { rand(10_000).to_s }

    it 'returns test facebook challenge to verify webhook' do
      get :index, params: params
      expect(response.body).to eq challenge
    end
  end

  describe 'POST create' do
    let!(:user) { create(:user, instagram_username: instagram_username) }
    let :params do
      {
        entry: [{
          changes: [{
            field: 'mentions',
            value: {
              comment_id: comment_id,
              media_id: media_id
            }
          }],
          id: '0',
          time: 1_536_586_839
        }],
        object: 'instagram'
      }
    end
    let(:comment_id) { rand(10_000).to_s }
    let(:media_id) { rand(10_000).to_s }
    let(:instagram_username) { 'thisisanigusername' }
    let(:comment_username) { instagram_username }
    let(:media_url) { dress_url }
    let(:valid_object_detector_response) { 'Full_body 50,91,915,630' }

    before do
      allow(HTTParty).to receive(:get).with(
        "#{InstagramMentionsService::GRAPH_API_BASE}/#{media_id}?" \
        "fields=mentioned_media.media_id(#{media_id}){media_url}",
        headers: InstagramMentionsService::GRAPH_API_HEADERS
      ).and_return({ 'mentioned_media' => { 'media_url' => media_url } })

      allow(HTTParty).to receive(:get).with(
        "#{InstagramMentionsService::GRAPH_API_BASE}/#{comment_id}?fields=username",
        headers: InstagramMentionsService::GRAPH_API_HEADERS
      ).and_return({ 'username' => comment_username })

      expect_any_instance_of(ObjectDetectors::Base).to receive(:fetch_category_coordinates)
        .and_return(valid_object_detector_response)

      expect_any_instance_of(CropImages::ImageOfInterest).to receive(:image_url)
        .and_return(media_url)
    end

    context 'username does not exist in taddar' do
      let(:comment_username) { 'doesnotexist' }
      let(:created_user) { User.find_by(instagram_username: comment_username) }

      it 'creates a new user with image of interests that has cropped images' do
        post :create, params: params

        expect(created_user.persisted?).to be_truthy
        expect(created_user.has_roles?([:regular])).to be_truthy
        expect(created_user.image_of_interests.count).to eq(1)
        expect(created_user.image_of_interests.first.detected_products.count).to eq(1)
      end
    end

    context 'username exists in taddar' do
      let(:comment_username) { 'userexists' }
      let!(:user) { create(:user, instagram_username: comment_username) }

      it 'does not create new user and creates image of interests that has cropped images' do
        expect do
          post :create, params: params
        end.to change { ImageOfInterest.count }.from(0).to(1)
          .and change { DetectedProduct.count }.from(0).to(1)

        expect(User.count).to eq(1)
        expect(user.image_of_interests.count).to eq(1)
        expect(user.image_of_interests.first.detected_products.count).to eq(1)
      end
    end
  end
end
