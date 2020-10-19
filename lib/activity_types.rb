class Activity
=begin
    @@all = []

    attr_accessor :name

    def initialize(name)
        @name = name
        @@all << self
    end

    def race_type
        Races.all.select{|race_type| race_type.? == self}
    end

    def find_or_create_by_name(name)
        found_type = self.all.find{|race_type| race_type.name == name}
        if found_type
            return found_type
        else
            return self.new(name)
        end
    end
=end
end
