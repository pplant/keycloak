class ApplicationController < ActionController::Base

  before_action :authorize

  def initialize
    Keycloak.proc_cookie_token = -> do
      cookies.permanent[:keycloak_token]
    end

    super
  end

  def logged_in?
    Keycloak::Client.user_signed_in?
  end

  def index
  end

  def current_user
    @uuid
  end

  helper_method :logged_in?

  private

  def authorize
    return if Keycloak::Client.user_signed_in?

    refreshed_token = Keycloak::Client.get_token_by_refresh_token rescue nil
    if refreshed_token.blank?
      @uuid = nil
      session.clear

      unless params[:code].nil?
        token = Keycloak::Client.get_token_by_code(params[:code], current_url) rescue nil
        if token
          cookies.permanent[:keycloak_token] = { value: token, httponly: true, secure: Rails.env.production? }
          @uuid = Keycloak::Client.get_attribute("sub")
        end
      else
        redirect_to Keycloak::Client.url_login_redirect(current_url, 'code')
      end
    else
      cookies.permanent[:keycloak_token] = { value: refreshed_token, httponly: true, secure: Rails.env.production? }
      @uuid = Keycloak::Client.get_attribute("sub")
    end

    false
  end


  def current_url
    cleaned_params = request.query_parameters.except("code", "session_state").to_query
    url = request.base_url + request.path
    url << "?" + cleaned_params unless cleaned_params.blank?

    url
  end

end
