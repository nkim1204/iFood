# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem
  
  def admin_required
    unless logged_in? && current_user.is_admin?
      flash[:error] = 'You Must be an admin to perform this action'
      redirect_to '/'
    end
  end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
