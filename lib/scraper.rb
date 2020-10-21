class Scraper

    attr_accessor :base_url, :base_url_review

    def initialize
        @base_url = "https://www.traillink.com"
    end
    
    def first_scrape
       html = open(@base_url + "/top-trails/")
       trails_parsed_to_html = Nokogiri::HTML(html)
       short=trails_parsed_to_html.css('#trail')        #make request to HTML webpage. short are the bundle of all trails
                                #html elements selector query, TR within TB, for ID trails.
       
        short.each do |each_trail|                                  #iterate over each of the all trails bundle
            trail_name = each_trail.css("h3").text
            state = each_trail.css(".states").text
            length_mi = each_trail.css(".length").text.split[0]
            trail_desc_short = each_trail.css("div")[2].text
            trail_url = each_trail.css(".info").css("a").attr('href').text

            state_instance = State.find_or_create_by_name(state)    #pass in state string, return instance of state
            
            trail_class_create_hash = {trail_name_key: trail_name, state_instance: state_instance, length_mi_key: length_mi, trail_desc_short_key: trail_desc_short, trail_url_key: trail_url}
            Trails.new(trail_class_create_hash)
        end
    end


    #notes with Chris, instead of passing in string of the second scrape URL, consider passing in the instance of the class and instead of printing out the second string information, assign it to the class instance variable & then return it.
    def second_scrape(string)  #Format output nd improvement
        comb_str = @base_url + string
        html = open(comb_str)
        trail_parsed_to_html = Nokogiri::HTML(html)
        #second_scrape asign return value 
        puts trail_parsed_to_html.css('p').text #returns summary & parking paragraphs

    end

end