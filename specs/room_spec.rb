require_relative 'spec_helper'

describe "Room class" do

  describe "Initialize" do

    it "is an instance of Room" do
      admin = Hotel::Room.new
      admin.must_be_kind_of Hotel::Room
    end

  end

end
