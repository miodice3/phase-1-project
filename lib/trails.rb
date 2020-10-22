class Trails

    @@all = []

#    attr_accessor :second_scrape

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

    def self.print_all_trails(string)
        string.each_with_index do |trail, index|
            puts "******************************************************"
            puts "Name: #{trail.trail_name_key}"
            puts "This trail is #{trail.length_mi_key} miles long and located in #{trail.state_instance.name}."
            puts "Description preview: #{trail.trail_desc_short_key}"
            puts "Trail # #{index + 1} of #{string.length}."
            #puts "Trail key #{unique_id_key}"
            sleep 0.1
            puts ""
        end
    end

#     def self.find_from_state_array(val_array)
#         val_array.select |trail|
# #        Trails.all.select do |trail|
        
#             trail.unique_id_key == 
#         end
#     end

end