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

end