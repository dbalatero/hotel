require 'pry'

module Hotel

  class Room

    MAX_ROOMS_COUNT = 20

    attr_accessor :room_number
    attr_reader :reservations

    def initialize (input)

      @room_number = check_room_num(input[:room_number])
      # @room_number = input[:room_number]
      @reservations = input[:trips] == nil ? [] : input[:trips]
    end

    private

    def check_room_num(input)
      if input != nil
        if input <= 0 || input > MAX_ROOMS_COUNT
          raise ArgumentError.new("Invalid room. Must be between 1 and 20")
        else
          @room_number = input
        end
      end
    end

  end

end
