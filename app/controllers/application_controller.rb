# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :recently_viewed
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

  def recently_viewed
	@viewed = Array.new()
    if session[:recentlyViewed]
        ordered = Array.new(session[:recentlyViewed]) 
        ordered = ordered.reverse
        len = ordered.size - 1
        if len > 5
            len = 5
        end
        # only show 6 recipes and we want them ordered most recent first
        for i in (0..len)
            @viewed << Recipe.find( ordered[i] )
        end
    end
  end	

end
