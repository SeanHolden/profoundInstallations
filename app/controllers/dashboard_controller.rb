class DashboardController < ApplicationController
	before_filter :authenticate_admin!
  layout 'dashboard', :only => :index

  def index
  end

end
