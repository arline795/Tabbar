class SimilarProductsController < PublicController
  def index
    @user = if request.referrer.present? && request.referrer.include?('pages/demo')
              User.find_by(slug: 'demo')
            else
              current_user
            end
  end
end
