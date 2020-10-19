=begin

this is where run method goes

def run
    puts "hi welcome to CLI app, formatting welcome."
    'loading data, this will take a couple seconds!'

    Scraper.new.first_scrape
    puts "done!"
    ask question, what do you want to see, races by location, races by event?, then prompt form input at the end
    user_input= gets.chomp

    if user puts in option 1
        display data for option 1
    elsif user puts in option 2
        display data for option 2
    else
        prompt again for valid input.
    end
end

=end

class CLI

    def initialize
        puts "CLI.initialize"
        puts "Calling Scraper.fisrt_scrape"

        trails_array = Scraper.new.first_scrape
        
        trails_array.each do |trail|
            Trails.new(trail)
        end    

        Trails.all.each_with_index do |val, index|
             puts "trail number: #{index+1} for #{val}"
             #sleep 0.3
        end

        user_input = gets.chomp
        puts "please pick a trail number to see more informaiton"
        #the scrap has been updated to retrieve the individual URL, nd append to base_url_review.
        binding.pry
    end

end