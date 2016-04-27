require 'cached_api'

class HomeController < ApplicationController

  include CachedApi
  
  def index

  	@bodyClass = 'layout-homepage';
    @recentHires = get_recent_hires();

  end

end