class CLI
    #update priority:
    #reconfigure scraper class to recieve instance of Trail class, update instance variable with return second scrape information so its actually a property of the Trail class
    #watch CLI output tricks, give viewer additional text to read upon request, etc.
    #clickable link for final trail selection through terminal is possible
    #open & "exit" graphics - ASCII generators, color changing, music apparently works too.  gem, colorize. 
    #rotating / while loading
    #you can input commands from within cli back to internet, this may have been done through an API & not scraping
    #this was done via scraper method, but link allowed easy manipulation for city & state, not actually entering data through the page.

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
        validation = Validate.new(input_to_val, 1, 2) #option 1 or 2, no array offset
        user_input = validation.check

        if user_input == 1
            Trails.print_all_trails((Trails.all))

            puts "Please enter the trail number you'd like to see details on"
            input_to_val = gets.chomp.to_i - 1

            validation = Validate.new(input_to_val, 0, (Trails.all.length-1)) #array offset
            trail_selection = validation.check_array

            selected_trail_url = Trails.all[trail_selection].trail_url_key
            
                if Trails.all[trail_selection].second_scrape_key == ""           
                    Trails.all[trail_selection].second_scrape_key=(Scraper.new.second_scrape(selected_trail_url).to_s)
                end

            puts Trails.all[trail_selection].second_scrape_key

            self.run

            elsif user_input == 2
                State.print_all_states                                           #calling non instance method (or static, review) method on the state class
                puts "Please enter the state number you'd like to see trails for"
                input_to_val = gets.chomp.to_i - 1
            
                validation = Validate.new(input_to_val, 0, (State.all.length - 1)) #array offset
                state_selection = validation.check_array
            
                trails_by_state = Trails.all.select do |trail|
                    trail.state_instance == State.all[state_selection]                   #looping through all of my trails, filtering out all trails that do not have the selected state object. equality test
                end
                #binding.pry
                Trails.print_all_trails(trails_by_state)
                puts "Please enter the trail number you'd like to see details on"
            
                input_to_val = gets.chomp.to_i - 1
                validation = Validate.new(input_to_val, 0, (trails_by_state.length - 1)) #array offset
                trail_selection = validation.check_array
                
                final_trail_instance = trails_by_state[trail_selection]
                #binding.pry

                if final_trail_instance.second_scrape_key == ""
                    binding.pry
                    result = Scraper.new.second_scrape(final_trail_instance.trail_url_key)
                    Trails.all[final_trail_instance.unique_id_key].second_scrape_key = result
                end
            
                binding.pry
                puts Trails.all[final_trail_instance.unique_id_key].second_scrape_key
                self.run
            end
 

    end
end

=begin
elsif user_input == 2
    State.print_all_states                                           #calling non instance method (or static, review) method on the state class
    puts "Please enter the state number you'd like to see trails for"
    input_to_val = gets.chomp.to_i - 1

    validation = Validate.new(input_to_val, 0, (State.all.length - 1)) #array offset
    state_selection = validation.check_array

    trails_by_state = Trails.all.select do |trail|
        trail.state_instance == State.all[state_selection]                   #looping through all of my trails, filtering out all trails that do not have the selected state object. equality test
    end
    binding.pry
    Trails.print_all_trails(trails_by_state)
    puts "Please enter the trail number you'd like to see details on"

    input_to_val = gets.chomp.to_i - 1
    validation = Validate.new(input_to_val, 0, (trails_by_state.length - 1)) #array offset
    trail_selection = validation.check_array
    binding.pry
    final_trail_instance = trails_by_state[trail_selection]

    Scraper.new.second_scrape(final_trail_instance.trail_url_key)
    self.run
end
=end

=begin
elsif user_input == 2
    State.print_all_states                                           #calling non instance method (or static, review) method on the state class
    puts "Please enter the state number you'd like to see trails for"
    input_to_val = gets.chomp.to_i - 1

    validation = Validate.new(input_to_val, 0, (State.all.length - 1)) #array offset
    state_selection = validation.check_array
#store array of unique trail numbers during print process, use that array in validation initialization
    #binding.pry            

    val_array = []
        trails_by_state = Trails.all.select do |trail|
                if trail.state_instance == State.all[state_selection]                   #looping through all of my trails, filtering out all trails that do not have the selected state object. equality test
                val_array << trail.unique_id_key
                #binding.pry
                #Trails.print_all_trails(trail)
                end
            #binding.pry
        end
    Trails.find_from_state_array(val_array)
    
    binding.pry

#            Trails.print_all_trails(trails_by_state)
    # PICKUP HERE AND BUILD TRAILS METHOD trails_by_state = Trails.return_instances(val_array)
    Trails.print_all_trails(trails_by_state)
    puts "Please enter the trail number you'd like to see details on"

    input_to_val = gets.chomp.to_i - 1
    validation = Validate.new(input_to_val, 0, (trails_by_state.length - 1)) #array offset
    trail_selection = validation.check_array
    binding.pry
    final_trail_instance = trails_by_state[trail_selection]

    Scraper.new.second_scrape(final_trail_instance.trail_url_key)
    self.run
end
=end