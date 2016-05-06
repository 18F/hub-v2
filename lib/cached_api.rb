module CachedApi

	def get_recent_hires

	  team_api_url = ENV['TEAM_API_URL']
	  cache_refresh = ENV['TEAM_API_CACHE_REFRESH_MINUTES'].to_i 
	  new_hire_window = ENV['TEAM_API_NEW_HIRE_WINDOW_DAYS'].to_i 

	  Rails.cache.fetch("recent_hires", :expires_in => cache_refresh.minutes) do

	  	recent_hires = Array.new;
	  	response = HTTParty.get(team_api_url);
    	apidata = JSON.parse(response.body);
    	apidata['results'].each do |person|
    		if (person['start_date'] != nil)
    			hire_date = DateTime.parse(person['start_date']);
    			if (hire_date > Time.now - new_hire_window.days)
    				person['has_photo'] = check_for_photo(person['name'])
    				recent_hires << person
    			end
			end
		end

		recent_hires
	  
	  end 
	
	end

	def check_for_photo(name)

	    response = HTTParty.get("https://pages.18f.gov/team-browser/assets/images/team/" + name + '.jpg');
	    return response.code == 200

	end

end
