class DashboardController < ApplicationController
  layout 'dashboard', :only => :index

  def index
    @message = "hello"
  end

end
