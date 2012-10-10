Rubypedia
=========

Rubypedia extracts content from [Wikipedia](http://en.wikipedia.org/w/api.php) API.

Now just for [rvsection=0](https://github.com/gcimmino/rubypedia/blob/master/lib/rubypedia.rb#L13):
	
	http://#{lang}.wikipedia.org/w/api.php?action=query&prop=revisions&titles=#{title}&rvprop=content&format=json&rvsection=0


Installation
------------

By command line:


	$ gem install rubypedia --source https://github.com/gcimmino/rubypedia.git
	$ gem install

Usage
-----

	title   = 'poland'
    fields = [ 'capital', 'currency', 'languages' ]
	
	content = Rubypedia.get_content(title, lang, fields)
	puts content['capital'] => "Warsaw"
	

