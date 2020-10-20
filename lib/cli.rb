class CLI

    def initialize
        puts "CLI.initialize"
        puts "Calling Scraper.fisrt_scrape"

        trails_array = Scraper.new.first_scrape
        
        trails_array.each do |trail|
            state_key = trail[:state_key]
            state_instance = State.find_or_create_by_name(state_key)
            trail[:state_key] = state_instance
            Trails.new(trail)
        end

        #State.all does return all instances of state class, complete with @name
        #Trails.all does return all instances of trails, complete with instance of state class

        puts "type 1 to see all #{Trails.all.length} of the best trails! This will take approx #{0.1*Trails.all.length} seconds to return all results."
        puts "type 2 to select trails by state"
        #binding.pry
        user_input = gets.chomp.to_i
        
#        ct_trails = State.all[0].trails_by_state
#        puts ct_trails
#        binding.pry
        if user_input == 1
            Trails.print_all_trails
        elsif user_input == 2
            State.print_all_states
            #write code to list states to pick trails from
        end

#        trail_review_parking_info = Scraper.new.second_scrape("/trail/air-line-state-park-trail/")


    end
end
=begin

        user_input = gets.chomp.to_i
        org_array = []
        if user_input == 1
            Trails.all.each_with_index do |val, index|
                #binding.pry
                puts "trail number: #{index+1} for #{val.trail_name_key}, #{val.state_key}"
                holder = index + 1
                org_array << {holder: val}
                binding.pry
                #sleep 0.3
                puts ""
                puts "select individual trail please to see full descriptions & parking tips!"
                user_input = gets.chomp.to_1
            end
                puts ""
                puts "select individual trail please to see full descriptions & parking tips!"

            #elsif user_input == 2
                #sort by state
        end

        #puts "please pick a trail number to see more informaiton"
        #the scrap has been updated to retrieve the individual URL, nd append to base_url_review.
        #binding.pry
    end
=end

