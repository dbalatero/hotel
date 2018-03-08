module Hotel

  class Reservation

    attr_reader :res_id, :room, :start_date, :end_date, :cost

    def initialize(input)
      @res_id = input[:res_id]
      @room = input[:room]
      @start_date = input[:start_date]
      @end_date = input[:end_date]
      @cost = calculate_cost
    end

    def calculate_cost
      #end_date minus start_date, -1 (cuz last day isnt charged) * 200
    end

    def duration
      # end date minus start date?
    end


  end

end
