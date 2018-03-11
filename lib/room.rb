require 'pry'

module Hotel
  MAX_ROOMS_COUNT = 20
  class Room
    attr_reader :number

    def initialize(number:)
      @number = number
      @reservations = []
    end

    def available?(start_date, end_date)
      @reservations.none? do |reservation|
        reservation.booked?(start_date) || reservation.booked?(end_date)
      end
    end

    def book(reservation)
      @reservations << reservation
    end

    def find_reservations_for(date)
      @reservations.find_all { |reservation| reservation.booked?(date) }
    end
  end
end
