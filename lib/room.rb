require 'pry'

module Hotel

  MAX_ROOMS_COUNT = 20

  class Room

    attr_accessor :room_number, :booked_dates

    def initialize(input)

      @room_number = input[:room_number]
      @booked_dates = input[:range] == nil ? [] : input[:range]
    end

    
  end

end
