module ApplicationHelper
  def user_instgram_info(user)
    InstagramService.new(user: user).fetch_user
  end

  def currency_code(user)
    Country.new(user).currency_code
  end

  def currency_symbol(user)
    Country.new(user).currency_symbol
  end
end
