class Validate

    attr_accessor :user_input, :range, :range2

    def initialize(user_input, range, range2)
        @user_input = user_input
        @range = range
        @range2 = range2
    end

    def check
        ok = (@range..@range2).to_a
        if ok.include?(@user_input)
            return @user_input
        else
            puts "Please try your input again"
            @user_input = gets.chomp.to_i
            check
        end
    end

    def check_array
        ok = (@range..@range2).to_a
        if ok.include?(@user_input)
            return @user_input
        else
            puts "Please try your input again"
            @user_input = (gets.chomp.to_i-1)
            check_array
        end
    end

end