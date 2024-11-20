# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_url, alert: t('alert.access_denied')
  end
end
