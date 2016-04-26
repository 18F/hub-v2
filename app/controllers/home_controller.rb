require 'team_api'

class HomeController < ApplicationController

  include TeamApi
  
  def index

  	@bodyClass = 'layout-homepage';
    @recentHires = get_recent_hires();

  end

end