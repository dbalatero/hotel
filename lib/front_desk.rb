require 'date'
require 'pry'
require_relative 'room'
require_relative 'reservation'

module Hotel

  class FrontDesk

    attr_reader :all_rooms, :reservations

    def initialize

      @all_rooms = load_rooms
      @reservations = []
      #use a hash to store instance variable for blocked rooms?
    end

    # def get_list_of_all_rooms (use attr_reader: getter)

    def make_reservation(dates)
      reservation_data = {
        res_id: @reservations.length + 1,
        # write a helper method later to check for available rooms
        room: @all_rooms.first,
        # write helper method here to check for Date objects and to ensure that end_date is after the start_date
        start_date: check_date(dates[:start_date]),
        end_date: check_date(dates[:end_date])
      }
      new_res =  create_new_res_instance(reservation_data)

      res_range = range(reservation_data[:start_date], reservation_data[:end_date])

      @reservations << new_res
      reservation_data[:room].booked_dates << res_range

      return new_res
    end

    # def find_list_of_res_for(date)

    # def get_total_cost(reservation_id) <= I should just be able to find a reservation and call .cost on it...

    private

    def load_rooms
      rooms = []
      MAX_ROOMS_COUNT.times do |num|
        rooms << Hotel::Room.new(room_number: num)
      end
      return rooms
    end

    def check_date(date)
      if date.class != Date
        raise ArgumentError.new("Date must be a Date object")
      else
        return date
      end
    end

    def create_new_res_instance(input)
      Hotel::Reservation.new(input)
    end

    def range(start_date, end_date)
      return (start_date..end_date)
    end

  end


end
