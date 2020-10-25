class CLI
    
    def initialize
        puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
        puts "Welcome to the CLI Trail Finder Application.  You are clicks away from finding your next adventure."
        puts ""
        puts "We are querying the internet for the most up to date information."
        puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
        Scraper.new.first_scrape
    end

    def self.run
        puts ""
        puts ""
        puts "type 1 to see all #{Trails.all.length} of the best trails! This will take approx #{0.1*Trails.all.length} seconds to return all results."
        puts "type 2 to select trails by state.  This will take approx #{0.1*State.all.length} seconds to return all results."
        puts "to exit, please hit CTRL + C"
        
        input_to_val = gets.chomp.to_i
        
        user_input = Validate.new(input_to_val, 1, 2).check #option 1 or 2, no array offset
        
        if user_input == 1
            Trails.print_all_trails((Trails.all))

            puts "Please enter the trail number you'd like to see details on"
            
            input_to_val = gets.chomp.to_i - 1
            trail_selection = Validate.new(input_to_val, 0, (Trails.all.length-1)).check_array #array offset

            Trails.unique_id_to_update_second_scrape(Trails.all[trail_selection].unique_id_key)
            
            self.run

            elsif user_input == 2
                State.print_all_states                                           #calling non instance method (or static, review) method on the state class
                puts "Please enter the state number you'd like to see trails for"
                
                input_to_val = gets.chomp.to_i - 1
                state_selection = Validate.new(input_to_val, 0, (State.all.length - 1)).check_array #array offset

                trails_by_state = State.all[state_selection].trails_by_state                   #looping through all of my trails, filtering out all trails that do not have the selected state object. equality test

                Trails.print_all_trails(trails_by_state)

                puts "Please enter the trail number you'd like to see details on"
            
                input_to_val = gets.chomp.to_i - 1
                trail_selection = Validate.new(input_to_val, 0, (trails_by_state.length - 1)).check_array #array offset

               Trails.unique_id_to_update_second_scrape(trails_by_state[trail_selection].unique_id_key)

               self.run
            end
 

    end
end