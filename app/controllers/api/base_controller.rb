class Api::BaseController < ApplicationController#ActionController::Base
  before_action :authenticate

  private

  def authenticate
        alter_on_login
    return unless api_key = request.headers[:authorization]
    @user = User.find_by(api_key: api_key)
  end
end
