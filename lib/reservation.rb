module Hotel

  class Reservation

    attr_reader :res_id, :room, :start_date, :end_date, :cost

    def initialize(input)
      @res_id = input[:id]
      @room = input[:room]
      @start_date = input[:start_date]
      @end_date = input[:end_time]
      # @cost
    end

  end

end
