class State

    @@all = []

    attr_accessor :name

    def initialize(name)
        @name = name
        @@all << self
    end

    def self.all
        @@all = @@all.sort_by {|a| a.name}
        @@all
    end

    def trails_by_state 
        Trails.all.select {|trail| trail.state_instance == self}
    end

    

    def self.find_or_create_by_name(name)
        found_state = self.all.find{|state| state.name == name}
        
        if found_state
            return found_state
        else
            return self.new(name)
        end
    end

    def self.print_all_states
        @@all.each_with_index do |state, index|
            #binding.pry
            puts "******************************************************"
            #puts trails_by_state
            puts ""
            puts "State Name: #{state.name}" 
            #Formatting, possibly query # of instances of self in Trails class, as to print CT, 4 trails, MA, 3 trails
            puts "State # #{index+1} of #{State.all.length}"
            puts ""
            sleep 0.1
        end
    end

end