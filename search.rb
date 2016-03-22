require 'json'

json = File.read('search.json')

results = JSON.parse(json);
results['results'].each do |corpus_resultset|
   puts corpus_resultset['corpus']
end
