module Pages
  class ContactUsController < PublicController
    def index
    end

    def create
      UserMailer.contact_us(contact_us_params[:email],
                            contact_us_params[:message]).deliver_now

      redirect_to root_path, notice: 'Message successfully sent'
    end

    private

    def contact_us_params
      params.require(:contact_us).permit(:email, :message)
    end
  end
end
