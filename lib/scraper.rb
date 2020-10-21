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
       short=trails_parsed_to_html.css('#trail')        #make request to HTML webpage.
                                #html elements selector query, TR within TB, for ID trails.

       trail_class_create_array = []
       
        short.each do |each_trail|
            trail_name = each_trail.css("h3").text
            state = each_trail.css(".states").text
            length_mi = each_trail.css(".length").text.split[0]
            trail_desc_short = each_trail.css("div")[2].text
            trail_url = each_trail.css(".info").css("a").attr('href').text

            state_instance = State.find_or_create_by_name(state)
            
            trail_class_create_array = {trail_name_key: trail_name, state_key: state_instance, length_mi_key: length_mi, trail_desc_short_key: trail_desc_short, trail_url_key: trail_url}
            Trails.new(trail_class_create_array)
        end
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