# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'gmail.com',
    :user_name            => 'yisusplusone@gmail.com',
    :password             => '123qweasdzxc123qweasdzxc',
    :authentication       => 'plain',
    :enable_starttls_auto => true  }
