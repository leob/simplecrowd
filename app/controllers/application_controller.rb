class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :reject_locked!, if: :devise_controller?

  #
  # The stuff below ('set_locale' and 'default_url_options') is needed to get locales working by embedding a locale
  # prefix in the URLs, for instance: /en/projects/new for the "new project" URL for locale 'English'.
  #
  # For this to work we also need the "filter :locale" option in config/routes.rb (see explanation there).
  #
  # The technique was taken from:
  #
  # http://stackoverflow.com/questions/5261521/how-to-avoid-adding-the-default-locale-in-generated-urls
  #

  before_action :set_locale

  def set_locale
    #logger.debug "locale: " + I18n.locale.to_s + " default locale: " + I18n.default_locale.to_s + " params[:locale]"
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    (I18n.locale.to_sym.eql?(I18n.default_locale.to_sym) ? {} : {locale: I18n.locale})
  end

  # https://github.com/plataformatec/devise/wiki/How-To:--Redirect-with-locale-after-authentication-failure
  #def self.default_url_options(options={})
  #  options.merge((I18n.locale.to_sym.eql?(I18n.default_locale.to_sym) ? {} : {locale: I18n.locale}))
  #end

  # Devise permitted params
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :email,
      :password,
      :password_confirmation)
    }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
      :email,
      :password,
      :password_confirmation,
      :current_password
      )
    }
  end

  # Redirects on successful sign in
  #def after_sign_in_path_for(resource)
  #  inside_path
  #end

  # Customize the Devise after_sign_in_path_for() for redirect to previous page after login
  # def after_sign_in_path_for(resource_or_scope)
  # end

  # Redirects on successful sign in
  def after_sign_out_path_for(resource)
    signed_off_path
  end

  # Auto-sign out locked users
  def reject_locked!
    if current_user && current_user.locked?
      sign_out current_user
      user_session = nil
      current_user = nil
      flash[:alert] = "Your account is locked."
      flash[:notice] = nil
      redirect_to root_url
    end
  end
  helper_method :reject_locked!
  
  # Only permits admin users
  def require_admin!
    authenticate_user!

    if current_user && !current_user.admin?
      redirect_to root_path
    end
  end
  helper_method :require_admin!
  
end
