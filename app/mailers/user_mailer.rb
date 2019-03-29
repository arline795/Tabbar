class UserMailer < ApplicationMailer
  def contact_us(email, message)
    @email   = email
    @message = message

    mail to: 'admin@taddar.com', subject: 'CONTACT US'
  end
end
