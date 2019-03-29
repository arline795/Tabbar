module Users
  class ProductsController < ApplicationController
    before_action :set_user

    def show
      @products = @user.products.paginate(page: params[:page], per_page: PER_PAGE)
    end

    private

    def set_user
      @user = User.friendly.find(params[:id])
    end
  end
end
