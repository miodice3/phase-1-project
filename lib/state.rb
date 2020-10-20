class State

    @@all = []

    attr_accessor :name

    def initialize(name)
        @name = name
        @@all << self
    end

    def self.all
        @@all
    end

    def trails_by_state
        #binding.pry
        Trails.all.select {|trail| trail.state_key == self}
    end

    def self.find_or_create_by_name(name)
        found_state = self.all.find{|state| state.name == name}
        
        if found_state
            return found_state
        else
            #binding.pry
            return self.new(name)
        end
    end

    def print_state
        puts "******************************************************"
        puts "State Name: #{name}"
    end

    def self.print_all_states
        @@all.each_with_index do |state, index|
            #binding.pry
            state.print_state
            puts "State Index #: #{index+1}"
        end
    end
    # def print_trail
    #     puts "******************************************************"
    #     puts "Name: #{@trail_name_key}"
    #     puts "This trail is #{@length_mi_key} miles long and located in #{@state_key.name}."
    #     puts "Description preview: #{@trail_desc_short_key}"
    # end

    # def self.print_all_trails
    #     #binding.pry
    #     @@all.each_with_index do |trail, index|
    #         #binding.pry
    #         trail.print_trail
    #         index = index += 1
    #         puts "Trail #{index} of #{Trails.all.length}."
    #         sleep 0.1
    #     end
    # end

end