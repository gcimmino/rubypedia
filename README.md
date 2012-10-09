#rubypedia

title   = "warsaw"
lang    = "en"
request = [:capital, :gdp, :km2]

content = Rubypedia.get_content(title, lang, request)
puts content[:capital]
