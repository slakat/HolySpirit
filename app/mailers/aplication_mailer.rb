class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@initiatiweb.com'
  layout 'mailer'
  before_action :set_locale

  private

  def set_locale
    default_url_options[:locale] = I18n.locale || I18n.default_locale
  end
end
