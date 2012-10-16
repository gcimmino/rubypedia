Rubypedia
=========

Rubypedia extracts content like <tt>field=value</tt> from [Wikipedia](http://en.wikipedia.org/w/api.php) API.

At the moment it works only for [rvsection=0](https://github.com/gcimmino/rubypedia/blob/master/lib/rubypedia.rb#L13):

	http://#{lang}.wikipedia.org/w/api.php?action=query&prop=revisions&titles=#{title}&rvprop=content&format=json&rvsection=0


Installation
------------

Via command line:
```shell
$ gem install rubypedia --source https://github.com/gcimmino/rubypedia.git
$ gem install
```


Usage
-----
```ruby
opts = {
	:title  => 'poland',
	:fields => [ 'capital', 'currency', 'languages' ],
	:lang	=> 'en'
}

content = Rubypedia.get_content(opts)
puts content['capital'] #=> "Warsaw"
content.title = 'italy'
puts content['capital'] #=> "Rome"
```
