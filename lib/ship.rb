class Ship
    attr_reader :name, :length, :health
    # binding.pry
    def initialize(name, length)
        @name = name
        @length = length
        @health = length
    end
    def sunk?
        if @health == 0
            return true
        else false
        end
    end
end
