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
    end

    # def get_list_of_all_rooms (use attr_reader: getter)

    # def make_res(start_date, end_date)

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

  end


end
