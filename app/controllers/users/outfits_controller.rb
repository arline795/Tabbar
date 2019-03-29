module Users
  class OutfitsController < ApplicationController
    def show
      if params[:id]
        @user = User.friendly.find(params[:id])
      else
        authenticate_user!
        @user = current_user
      end
      @products = @user.products.paginate(page: params[:page], per_page: PER_PAGE)
    end
  end
end
