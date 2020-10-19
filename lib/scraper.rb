class Scraper

    attr_accessor :base_url

    def initialize
        @base_url = "https://www.traillink.com/top-trails/"
        @base_url_review = "https://www.traillink.com"
    end
    
    def first_scrape
       html = open(@base_url)
       trails_parsed_to_html = Nokogiri::HTML(html)
       short=trails_parsed_to_html.css('#trail')

       trail_class_create_array = []
       
        short.each do |each_trail|
            
            trail_name = each_trail.css("h3").text
            state = each_trail.css(".states").text
            length_mi = each_trail.css(".length").text.split[0]
            trail_desc_short = each_trail.css("div")[2].text
            trail_url = each_trail.css(".info").css("a").attr('href').text
            trail_class_create_array << {trail_name_key: trail_name, state_key: state, length_mi_key: length_mi, trail_desc_short_key: trail_desc_short, trail_url_key: trail_url}
        end
       trail_class_create_array
       binding.pry
    end

end



=begin
this is where we will initialize the class Scraper
initialization funciton needs to be set equal to URL of the page you will be visiting to scrape your first set of informaiton.
https://usacycling.org/national-calendars/pro-road-tour
usa pro tours links to race websites, each one is different so not a good choice.
as an example though, this is what you'd do 
    def initialize
    @base_url = https://usacycling.org/national-calendars/
    end

    def first_scrape
        html = open(@base_url + "pro-road-tour")

        #go through and parse all of your information here, get say 4 or 5 different things you want for each class instance.
        


        review_elements.each do |review_element|
            example_1 = reveiw_element.css etc
            example_2 = review_elemeent.css etc
            etc

            **this is the way to do both scrapes at once. maybe not do this depeneding on how many items we're reviewing at once. decide after site selection
                second_level_scrape_hash = self.second_scrape(review_url)

            "RELATIONSHIOPS" equate to types of search functionality essentially. ie, for races by city, instead of instantiating the class with all its attributes, you can
            create teh relationship to search through instances of "location" with each one created, when initiating the origional class. reference the location class, find or create
            by new, and if it has a location with "boston" races, assign that instance of location to the new class you're instantating.
            CREATE YOUR RELATIONSHIPS (instantiate a new class, link that instance of the new class to the initialization of the race class)
                race_type = classRaceType.find_or_create_by_name(race_type_name)

            instantiate the new classes within this iteration
            (these will instantiate with the same name, but class ID's will be differe)
            race = Races.new(example_1, example_2, race_type, second_level_scrape_hash[:venue_details], second_level_scrape_hash[:venue_altitude])
        end

    end

    #you'll also need your second_scrape logic here
    def second_scrape(review_url)   <- small snippit only that gets tacked onto the initial URL
        review_html = open(@base_url + review_url)
        review_html_parsed_to_elements = Nokogiri::HTML(review_html)

        parse through, create a couple new variables worth of information here.
        
        venue_details = review_html_parsed_to_elements.css("some tags").text
        venue_altitude = review_html_parsed_to_elements.css("some other tags").text
        
        return data in a hash, as so 
        return {bike_race_venue_details: venue_details, venue_alt: venue_altitude}

    end

=end



       #short.css("#trail")[0].css(".activities")[0]  - bundle of activity types allowed.
       #these will require their own counter loop dependent on counting the types of activities allowed at each trail location
       #short.css("#trail")[0].css(".activities")[0].css("a").length    => 4 listed, without .length, this is what we'll need to iterate over to store activity types.
       #short.css("#trail")[0].css(".activities")[0].css("a")[0] => first activity bundle (horseback riding trails)
       #short.css("#trail")[0].css(".activities")[0].css("a")[1] => second activity bundle (mountain biking trails)
       #short.css("#trail")[0].css(".activities")[0].css("a")[2] => third activity bundle (walking-trails)
       #short.css("#trail")[0].css(".activities")[0].css("a")[2].attr('href').split('/')[2] => "walking-trails"
       #short.css("#trail")[0].css(".activities")[0].css("a")[3] => fourth activity bundle (cross-country-skiing-trails)
       #short.css("#trail")[0].css(".activities")[0].css("a")[3].attr('href').split('/')[2] => "cross-country-skiing-trails"
       #to strip formatting out for each actual item:
       #short.css("#trail")[0].css(".activities")[0].css("a").attr('href').text.split('/')[2]   < gives "horseback-riding-trails"
       #binding.pry
       #puts trails_parsed_to_html
