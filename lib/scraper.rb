class Scraper

    attr_accessor :base_url

    def initialize
        @base_url = "https://www.traillink.com/top-trails/"
    end
    
    def first_scrape
       puts "Scraper.first_scrape method test"
       html = open(@base_url)
       puts "html opened link"
       trails_parsed_to_html = Nokogiri::HTML(html)
       binding.pry
       #puts trails_parsed_to_html
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