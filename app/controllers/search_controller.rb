require 'httparty'
require 'json'

class SearchController < ApplicationController
  
  def index
  	@bodyClass = 'layout-homepage';

  end

  def results

  	@bodyClass = 'layout-homepage';

	url = 'http://localhost:8080/?q=' + params[:q]
	response = HTTParty.get(url)
	@query = params[:q]
	@searchResults = JSON.parse(response);

  end
end
