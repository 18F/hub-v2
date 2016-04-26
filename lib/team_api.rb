require 'httparty'

module TeamApi
	
	@@apidata = nil;
	@@recent_hires = nil;

	def get_api_data

		if (@@apidata == nil) 
			logger.debug "creating api data ";

			url = 'https://team-api.18f.gov/public/api/team/';
    		response = HTTParty.get(url);
    		@@apidata = JSON.parse(response.body);
		end

		return @@apidata 
	end

	def get_recent_hires

		if (@@recent_hires == nil)  
			update_recent_hires();
		end

		return @@recent_hires

	end

	def update_recent_hires

		@@recent_hires = Array.new;
 		apidata = get_api_data();

		apidata['results'].each do |person|
			if (person['start_date'] != nil)
				hire_date = DateTime.parse(person['start_date']);
				if (hire_date > Time.now - 40.days)
					person['has_photo'] = check_for_photo(person['name'])
					@@recent_hires << person
				end
			end
		end
	
	end

	def check_for_photo(name)

	    response = HTTParty.get("https://pages.18f.gov/team-browser/assets/images/team/" + name + '.jpg');
	    return response.code == 200

	end

end