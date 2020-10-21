class CLI
#new class for input validation (gets chomp stuff should be a method, also checking if they put in valid entry)

    def initialize
        puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
        puts "Welcome to the CLI Trail Finder Application.  You are clicks away from finding your next adventure."
        puts ""
        puts "We are querying the internet for the most up to date information."
        puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
        
        Scraper.new.first_scrape

        puts "type 1 to see all #{Trails.all.length} of the best trails! This will take approx #{0.1*Trails.all.length} seconds to return all results."
        puts "type 2 to select trails by state.  This will take approx #{0.1*State.all.length} seconds to return all results."

        user_input = gets.chomp.to_i
        
        if user_input == 1
            Trails.print_all_trails((Trails.all))

            puts "Please enter the trail number you'd like to see details on"
            trail_selection = gets.chomp.to_i - 1

            selected_trail_url = Trails.all[trail_selection].trail_url_key
            Scraper.new.second_scrape(selected_trail_url)
            
        elsif user_input == 2
            State.print_all_states                                           #calling non instance method (or static, review) method on the state class
            puts "Please enter the state number you'd like to see trails for"
            state_selection = gets.chomp.to_i - 1
                trails_by_state = Trails.all.select do |trail|
                trail.state_key == State.all[state_selection]                   #looping through all of my trails, filtering out all trails that do not have the selected state object. equality test
                end
            Trails.print_all_trails(trails_by_state)
            puts "Please enter the trail number you'd like to see details on"

            trail_selection = gets.chomp.to_i - 1
            
            final_trail_instance = trails_by_state[trail_selection]

            Scraper.new.second_scrape(final_trail_instance.trail_url_key)
        end

    end
end