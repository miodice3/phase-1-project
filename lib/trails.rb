class Trails

    @@all = []

    def initialize(attributes)          
        attributes.each do |key, value| 
        self.class.attr_accessor(key)
        self.send(("#{key}="), value)   
        end
        @@all << self
    end

    def self.all
        @@all
    end

    def self.unique_id_to_update_second_scrape(selection) #accepts unique id, calls for scrape

        selected_instance = Trails.all.select do |trail|
            trail.unique_id_key == selection
            end

        selected_instance = selected_instance[0]

                if selected_instance.second_scrape_key == ""
                    second_scrape_return = Scraper.new.second_scrape(selected_instance.trail_url_key)

                    selected_instance.second_scrape_key = second_scrape_return.split(". ")
                   
                    selected_instance.second_scrape_key.each do |sentence|
                        sentence << "."
                    end
                end

        i = 0
        user_input = 1
        while i <= selected_instance.second_scrape_key.length && user_input == 1
            n = 0
            while n <= 5
                puts selected_instance.second_scrape_key[i]
                i += 1
                n += 1
            end
            puts ""
            puts "Please enter 1 to keep reading, or enter any other key to return to the main menu"
            user_input = gets.chomp.to_i
        end
    end

    def self.trails
        @trail_name_key
    end

    def self.print_all_trails(string)
        string.each_with_index do |trail, index|
            puts "******************************************************"
            puts "Name: #{trail.trail_name_key}"
            puts "This trail is #{trail.length_mi_key} miles long and located in #{trail.state_instance.name}."
            puts "Description preview: #{trail.trail_desc_short_key}"
            puts "Trail # #{index + 1} of #{string.length}."
            sleep 0.1
            puts ""
        end
    end

end