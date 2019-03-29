def dress_url
  'https://s3.amazonaws.com/public-joeyk/dress.png'
end

def stub_exteral_services_for_product_create_flow
  valid_object_detector_response = 'Full_body 50,91,915,630'
  create_res_taddar_vision_server = '<<PRODUCT CREATED>>'
  product_image_mock = open("#{Rails.root}/spec/fixtures/image.jpg")

  allow_any_instance_of(TaddarVision::ProductService)
    .to receive(:create).and_return(create_res_taddar_vision_server)

  allow_any_instance_of(ObjectDetectors::ProductImageService)
    .to receive(:fetch_category_coordinates).and_return(valid_object_detector_response)

  allow_any_instance_of(Proxys::OpenFile).to receive(:call).and_return(open(dress_url))

  allow_any_instance_of(CropImages::ProductImage).to receive(:call).and_return(product_image_mock)
end
