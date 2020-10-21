class CLI
#good pattern to follow is to have as little code as possible.
    def initialize
        puts "CLI.initialize"
        puts "Calling Scraper.fisrt_scrape"

        trails_array = Scraper.new.first_scrape
#transformation to remove to scraper class ln 9-14 - should not be manipulating any data in cli class        
        trails_array.each do |trail|
            state_key = trail[:state_key]
            state_instance = State.find_or_create_by_name(state_key)
            #state class doing instance management for me. not always good. 
            #state & trails class should not know they're being used by CLI, cant format data in CLI the same way.  CLI limit only to input output
            trail[:state_key] = state_instance
            Trails.new(trail)
        end
        binding.pry
#16-17 ok
        puts "type 1 to see all #{Trails.all.length} of the best trails! This will take approx #{0.1*Trails.all.length} seconds to return all results."
        puts "type 2 to select trails by state"
        user_input = gets.chomp.to_i
        
        if user_input == 1
            Trails.print_all_trails
            puts "enter the trail number you'd like to see details on"
            trail_selection = gets.chomp
            trail_selection_formatted = trail_selection.to_i - 1
            in_depth = Scraper.new.second_scrape(Trails.all[trail_selection_formatted].trail_url_key)
            puts in_depth
            
        elsif user_input == 2
            State.print_all_states #calling non instance method (or static, review) method on the state class
            state_selection = gets.chomp
            state_selection_formatted = state_selection.to_i - 1
                trails_by_state = Trails.all.select do |trail|
                trail.state_key == State.all[state_selection_formatted] #looping through all of my trails, filtering out all trails that do not have the selected state object. equality test
                end

                #redundant logic as print all trails, also this should not be here for printing
                #for each item in trails.state, print out of state
            puts Trails.print_trails_by_state(trails_by_state)
            puts "enter the trail number you'd like to see details on"
            final_trail_selection = gets.chomp

            final_trail_selection_formatted = final_trail_selection.to_i - 1
            
            final_trail_instance = trails_by_state[final_trail_selection_formatted]

            in_depth = Scraper.new.second_scrape(final_trail_instance.trail_url_key)
            puts in_depth
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

