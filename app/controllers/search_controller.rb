require 'httparty'
require 'json'
require 'team_api'

class SearchController < ApplicationController
  include TeamApi
  
  def index

    @bodyClass = 'layout-homepage';

  end

  def results

    @recentHires = get_recent_hires();
    @bodyClass = 'layout-search-results';
    url = 'https://jb-lunr-server.apps.cloud.gov/?q=' + params[:q]
    response = HTTParty.get(url)
    @query = params[:q]
    @searchResults = JSON.parse(response);
  end
end

