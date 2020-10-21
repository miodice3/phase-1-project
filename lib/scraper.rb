class Scraper

    attr_accessor :base_url, :base_url_review

    def initialize
        @base_url = "https://www.traillink.com/top-trails/"
        @base_url_review = "https://www.traillink.com"
        #base_url just traillink.com/ >> add top trails where you need it.
        #url to query, 2nd function to parse information.
    end
    
    def first_scrape
       html = open(@base_url)
       trails_parsed_to_html = Nokogiri::HTML(html)
       short=trails_parsed_to_html.css('#trail')
#make request to HTML webpage.
       #html elements selector query, TR within TB, for ID trails.

       #scraper would return states & trails

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
       #returning a list of hashes
        #ok to create here, also less code. OK to instantiate this simplifies, not objecting to asking trails or other classes for information it isnt concerned with.
    end

    def second_scrape(string)
        comb_str = @base_url_review + string
        html = open(comb_str)
        trail_parsed_to_html = Nokogiri::HTML(html)
        short = trail_parsed_to_html
        trail_review_parking_info = short.css('p').text
        trail_review_parking_info
    end

end


=begin
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
