module Users
  class ImagesController < ApplicationController
    def show
      @products = current_user.image_of_interests
    end
  end
end
