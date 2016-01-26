class CompanyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def new(company)
    @company = company
    @user = company.user
    mail to: @user.email, subject: 'enregistrement de ' + @company.name
  end
  # def booking(booking)
  # end
end
