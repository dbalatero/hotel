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
      sd = dates[:start_date]
      ed = dates[:end_date]

      if check_dates(sd, ed)

        reservation_data = {
          res_id: @reservations.length + 1,
          # write a helper method later to check for available rooms
          # room: @all_rooms.find do |room|
          #   room.available?(sd, ed)
          # end
          room: @all_rooms.first,
          # write helper method here to check for Date objects and to ensure that end_date is after the start_date
          start_date: sd,
          end_date: ed
        }
        new_res =  create_new_res_instance(reservation_data)

        reservation_data[:room].booked_dates << range(sd, ed)

        @reservations << new_res
      end

      return new_res
    end

    def find_reservations_for(date)
      @reservations.find_all { |res| (res.start_date..res.end_date).include?(date) }
    end

    # def get_total_cost(reservation_id) <= I should just be able to find a reservation and call .cost on it...

    private


    def load_rooms
      rooms = []
      MAX_ROOMS_COUNT.times do |num|
        rooms << Hotel::Room.new(room_number: num + 1)
      end
      return rooms
    end

    def check_dates(s_date, e_date)
      if s_date.class != Date || e_date.class != Date
        raise ArgumentError.new("Date must be a Date object")
      elsif e_date < s_date
        return false
      else
        return true
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
