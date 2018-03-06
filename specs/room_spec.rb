require_relative 'spec_helper'

describe "Room class" do

  describe "initialize" do

    it "is an instance of Room" do

      input = {}
      room = Hotel::Room.new(input)
      room.must_be_kind_of Hotel::Room
      room.reservations.must_be_kind_of Array
    end

    it "raises an error for an invalid room number" do
      proc { Hotel::Room.new(room_number: -3) }.must_raise ArgumentError
      proc { Hotel::Room.new(room_number: 0) }.must_raise ArgumentError
      proc { Hotel::Room.new(room_number: 22) }.must_raise ArgumentError
    end

  end

end
