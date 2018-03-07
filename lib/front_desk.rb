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

    def make_reservation(input)
      id = @reservations.length + 1
      room = @all_rooms.first
      # write helper method here for the conversion to Date object?
      start_date = input[:start_date]
      end_date = input[:end_date]
      # write a helper method later to check for available rooms

      reservation = Hotel::Reservation.new(res_id: id, room: room, start_date: start_date, end_date: end_date)

      @reservations << reservation

      return reservation
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

    # def check_start_date(date)
    #   Date.strptime(date, '%m/%d/%Y')
    # end
    #
    # def check_end_date(date)
    #   Date.strptime(date, '%m/%d/%Y')
    # end


  end


end
