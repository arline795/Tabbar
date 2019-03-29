class SearchController < ApplicationController
  def index
    return if params[:query].to_s.length < 3
    render json: {
      products_count: product_search.count,
      users_count: user_search.count
    }
  end

  def products
    respond_to do |format|
      format.html
      format.json do
        @products = product_search.paginate(page: params[:page], per_page: PER_PAGE)
      end
    end
  end

  def users
    respond_to do |format|
      format.html
      format.json do
        @users = user_search.paginate(page: params[:page], per_page: PER_PAGE)
      end
    end
  end

  private

  def user_search
    User.where('lower(username) LIKE lower(?)', "%#{params[:query].downcase}%")
  end

  def product_search
    Product.where('lower(title) LIKE lower(?)', "%#{params[:query].downcase}%")
  end
end
