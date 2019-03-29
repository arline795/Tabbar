class CloseAccountService
  attr_reader :user, :errors

  def initialize(user)
    @user = user
    @errors = []
  end

  def close!
    close_account
  end

  private

  def close_account
    user.destroy!
  rescue ActiveRecord::RecordInvalid => exception
    @errors << exception.message
  end
end
