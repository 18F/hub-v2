module CachedApi

	def get_recent_hires
	  
	  Rails.cache.fetch("recent_hires", :expires_in => 60.minutes) do

	  	logger.info "refreshing cache" 
	  	recent_hires = Array.new;
	  	url = 'https://team-api.18f.gov/public/api/team/';
	  	response = HTTParty.get(url);
    	apidata = JSON.parse(response.body);
    	apidata['results'].each do |person|
    		if (person['start_date'] != nil)
    			hire_date = DateTime.parse(person['start_date']);
    			if (hire_date > Time.now - 40.days)
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
