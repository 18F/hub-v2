require 'httparty'
require 'json'

class SearchController < ApplicationController
  
  def index

    @bodyClass = 'layout-homepage';

  end

  def results

    @bodyClass = 'layout-search-results';
    url = 'https://jb-lunr-server.apps.cloud.gov/?q=' + params[:q]
    response = HTTParty.get(url)
    @query = params[:q]
    @searchResults = JSON.parse(response);

  end
end

