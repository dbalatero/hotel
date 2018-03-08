require_relative 'spec_helper'

describe "Room class" do

  describe "initialize" do

    it "is an instance of Room" do

      input = {}
      room = Hotel::Room.new(input)
      room.must_be_kind_of Hotel::Room
      room.booked_dates.must_be_kind_of Array
    end

  end

end
