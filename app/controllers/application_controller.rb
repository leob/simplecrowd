class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception. For APIs, you may want to use :null_session instead.
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
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    (I18n.locale.to_sym.eql?(I18n.default_locale.to_sym) ? {} : {locale: I18n.locale})
  end

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

  # Customize the Devise after_sign_in_path_for() for redirect to previous page after login
  #
  # The customization was used to fix a problem with paths (URLs) starting with a locale prefix, for instance:
  # '/en/projects/new' where '/en' is the locale prefix (the 'standard URL' would be: /projects/new without a locale)
  #
  # The issue was that, when the user tried to access a path with a locale prefix and the path required authentication,
  # Devise will show the login page and then (after successful login) will redirect the user back to the 'stored' path.
  #
  # However, the stored path apparently does NOT contain the locale prefix - so, when trying to access /en/projects/new
  # the user is (after login) redirected back to '/projects/new' (without '/en').
  #
  # The code below fixes this problem.
  #
  # Note: only required for non-default locales because for the default locale we don't prefix the paths with a locale.
  #
  def after_sign_in_path_for(resource_or_scope)
    path = stored_location_for(resource_or_scope) || signed_in_root_path(resource_or_scope)

    # If the current locale is not the default locale
    if not I18n.locale.to_sym.eql?(I18n.default_locale.to_sym)
      # the locale prefix
      locale_prefix = "/" + I18n.locale.to_s

      # if the path doesn't start with the locale prefix, then add (prepend) it
      if not (path == locale_prefix || path.starts_with?(locale_prefix + "/"))
        path = locale_prefix + path
      end
    end

    path
  end

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
