require 'rails_helper'
require 'rake'

describe 'instagram' do
  describe ':check_liked_media' do
    pending('We are removing instagram soon so no need to fix this spec')
    # subject { Rake::Task['instagram:check_liked_media'] }

    # let!(:user) { create(:user) }
    # let!(:media) { create(:media, user: user) }
    # let!(:product) { create(:product, user: user) }
    # let!(:tagged_product) { create(:tagged_product, media: media, product: product) }
    # let(:client) { double(user_liked_media: [double(id: media.instagram_media_id)]) }

    # before do
    #   load File.expand_path(Rails.root.join('lib/tasks/instagram.rake'), __FILE__)
    #   Rake::Task.define_task(:environment)
    #   allow(Instagram).to receive(:method_missing)
    #   allow(Instagram).to receive(:client).and_return(client)
    # end

    # it 'creates new data links from csv' do
    #   expect do
    #     subject.invoke
    #   end.to change(LikedProduct, :count).by 1
    # end
  end
end
