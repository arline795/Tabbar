require 'rails_helper'

RSpec.describe ObjectDetectors::ImageOfInterest, type: :service do
  let!(:image_of_interest) { create(:image_of_interest) }

  before do
    allow_any_instance_of(CropImages::ImageOfInterest)
      .to receive(:image_url)
      .and_return(dress_url)
  end

  describe 'call!' do
    context 'when there are 3 products found in image' do
      let(:three_products_found) do
        "\nLower_body\t573,375,1109,636\nUpper_body\t235,327,602,682\nFull_body\t298,327,609,682"
      end

      before do
        expect_any_instance_of(ObjectDetectors::Base)
          .to receive(:fetch_category_coordinates)
          .and_return(three_products_found)
      end

      it 'creates cropped images with product coordinates for image of interest' do
        expect do
          described_class.new(image_of_interest).call!
        end.to change { DetectedProduct.count }.from(0).to(3)

        expect(DetectedProduct.all.map(&:image_of_interest).uniq).to eq([image_of_interest])

        expect(DetectedProduct.all[0].product_coordinate).to eq([505, 841])
        expect(DetectedProduct.all[1].product_coordinate).to eq([504, 418])
        expect(DetectedProduct.all[2].product_coordinate).to eq([504, 453])
      end
    end

    context 'when there is 1 product found in image' do
      let(:one_product_found) do
        'Full_body 50,91,915,630'
      end

      before do
        expect_any_instance_of(ObjectDetectors::Base)
          .to receive(:fetch_category_coordinates)
          .and_return(one_product_found)
      end

      it 'creates cropped images for image of interest' do
        expect do
          described_class.new(image_of_interest).call!
        end.to change { DetectedProduct.count }.from(0).to(1)

        expect(DetectedProduct.all.map(&:image_of_interest).uniq).to eq([image_of_interest])
      end
    end
  end
end
