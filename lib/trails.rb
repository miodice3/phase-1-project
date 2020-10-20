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

    def self.trails
        @trail_name_key
        binding.pry
    end

    def print_trail
        puts "******************************************************"
        puts "Name: #{@trail_name_key}"
        puts "This trail is #{@length_mi_key} miles long and located in #{@state_key.name}."
        puts "Description preview: #{@trail_desc_short_key}"
    end

    def self.print_all_trails
        #binding.pry
        @@all.each_with_index do |trail, index|
            #binding.pry
            trail.print_trail
            index = index += 1
            puts "Trail #{index} of #{Trails.all.length}."
            sleep 0.1
            puts ""
        end
    end


end


