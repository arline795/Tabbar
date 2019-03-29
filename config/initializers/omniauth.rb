# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :instagram, ENV['INSTAGRAM_CLIENT_ID'], ENV['INSTAGRAM_CLIENT_SECRET']
# end

if Rails.env == 'test'
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:instagram] = OmniAuth::AuthHash.new(
    'provider' => 'instagram',
    'uid' => '196908719',
    'info' => {
      'nickname' => 'joey_knp',
      'name' => 'Foo Bar',
      'email' => nil,
      'image' => nil,
      'bio' => "Founder of www.taddar.com.\nFitness. Health. Wellbeing. Entrepreneurship. Business. Adventures. Software Engineer.",
      'website' => 'http://www.taddar.com/'
    },
    'credentials' => { 'token' => '196908719.0d259f9.700374632234472fa2e3657cf99e745d', 'expires' => false },
    'extra' => {
      'raw_info' => {
        'profile_picture' => nil,
        'website' => 'http://www.taddar.com/',
        'full_name' => 'Foo Bar',
        'bio' => "Founder of www.taddar.com.\nFitness. Health. Wellbeing. Entrepreneurship. Business. Adventures. Software Engineer.",
        'username' => 'joey_knp',
        'id' => '196908719'
      }
    }
  )
end
