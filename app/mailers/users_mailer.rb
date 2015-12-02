class UsersMailer < ActionMailer::Base
default from: 'noreply@yisusplusone.com'
layout 'mailer'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.users_mailer.signup.subject
  #
  def signup(user_id)
    @user = User.find(user_id)
    mail to: @user.email, subject: 'Valida tu cuenta', from: 'noreply@yisusplusone.com'
  end
end
