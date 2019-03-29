class User < ActiveRecord::Base
  include PgSearch
  include RoleModel
  include DeviseTokenAuth::Concerns::User
  roles :admin, :brand, :influencer, :regular
  extend FriendlyId
  friendly_id :username, use: :slugged

  devise :omniauthable, :trackable, :masqueradable

  has_many :products, dependent: :destroy
  has_many :product_crawlers, dependent: :destroy
  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :image_of_interests, dependent: :destroy
  has_many :commission_factory_importers, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :roles_mask, presence: true
  validates :instagram_username, :slug, uniqueness: true, presence: true
  validates :instagram_token, uniqueness: true

  has_attached_file :avatar, styles: { large: '250x250', medium: '100x100', thumb: '30x30#' },
                             default_url: :default_avatar_url
  validates_attachment_content_type :avatar, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  pg_search_scope :search, against: :username

  after_create :create_uuid
  before_validation :set_slug

  def default_avatar_url
    if Rails.env.development? || Rails.env.test?
      ActionController::Base.helpers.asset_path('missing_avatar.png')
    else
      'https://s3.amazonaws.com/yorlook/users/avatars/default/avatar.png'
    end
  end

  def to_param
    slug
  end

  def create_uuid
    update(uuid: SecureRandom.uuid)
  end

  def as_json(*)
    super(
      only: %i(username email avatar slug uuid),
      methods: %i(avatar_url country_name)
    )
  end

  def country_name
    Country.new(country).name if country
  end

  def avatar_url
    return ActionController::Base.asset_host + avatar.url(:medium) if Rails.env.development?
    avatar.url(:medium)
  end

  def instagram?
    instagram_token.present?
  end

  def instagram_url
    unless instagram_username
      self.instagram_username = instagram_user_data['username']
      save
    end
    "http://instagram.com/#{instagram_username}"
  end

  def images_count
    instagram_user_data.present? ? instagram_user_data['counts']['media'] : 0
  end

  private

  def instagram_user_data
    InstagramService.new(user: self).fetch_user['data']
  end

  def set_slug
    self.slug = username.to_s.parameterize
  end
end
