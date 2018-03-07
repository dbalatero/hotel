module Hotel

  class Reservation

    attr_reader :res_id, :room, :start_date, :end_date, :cost

    def initialize(input)
      @res_id = input[:res_id]
      @room = input[:room]
      @start_date = input[:start_date]
      @end_date = input[:end_date]
      @cost = cost
    end

    def cost
    end

    def duration
    end


  end

end
