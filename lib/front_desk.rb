require 'date'
require 'pry'
require_relative 'room'
require_relative 'reservation'

module Hotel

  class FrontDesk

    attr_reader :all_rooms, :reservations

    # this constant isn't being tested yet... consider it pseudocode. maybe use this in wave 2 when booking blocks of rooms, for it not to exceed 20?


    def initialize
      # all_rooms instance variable should invoke a private load rooms method that uses a 20 times loop to create 20 instances of Room, using the iteration variable + 1 to set the value of the room_number instance variable.
      @all_rooms = load_rooms
      @reservations = []
      #use a hash to store instance variable for blocked rooms?
    end

    # def get_list_of_all_rooms (use attr_reader: getter)

    def make_reservation(dates)
      reservation_data = {
        res_id: @reservations.length + 1,
        room: @all_rooms.first,
        # write helper method here to check for Date objects and to ensure that end_date is after the start_date
        start_date: check_date(dates[:start_date]),
        end_date: check_date(dates[:end_date])
        # write a helper method later to check for available rooms
      }
      new_res =  create_new_res_instance(reservation_data)

      # Hotel::Reservation.new(res_id: id, room: room, start_date: start_date, end_date: end_date)

      @reservations << new_res
      
      return new_res
    end

    # def get_list_of_res_for(date)

    # def get_total_cost(reservation_id)

    private

    def load_rooms
      rooms = []
      (1..20).each do |num|
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

  end


end
