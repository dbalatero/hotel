require_relative 'spec_helper'

describe "FrontDesk class" do

  describe "initialize" do

    it "is an instance of FrontDesk" do
      admin = Hotel::FrontDesk.new
      admin.must_be_kind_of Hotel::FrontDesk
    end

    it "loads a master list of all rooms" do
      admin = Hotel::FrontDesk.new

      admin.rooms.length.must_equal 20
      admin.rooms[0].number.must_equal 1
    end

  end

  describe "make_reservation method" do

    before do
      @front_desk_1 = Hotel::FrontDesk.new
    end

    it "stores new reservation" do
      dates = { start_date: Date.new(2018,6,7), end_date: Date.new(2018,6,10)}

      new_res = @front_desk_1.make_reservation(dates)

      @front_desk_1.find_reservations_for( Date.new(2018, 6, 8))
        .must_include new_res

      new_res.start_date.must_equal Date.new(2018, 6, 7)
    end


    it "adds the reservation to front desk's collection of reservations"

    it "adds the reserved date range to the room's collection of booked dates"

    it "stores start and end date as Date objects"

    it "raises an error if end_date is before start_date"

    it "returns nil if no rooms are available for given date range"

  end
  #
  describe "find_reservations_for(date) method" do

    before do
      @front_desk_2 = Hotel::FrontDesk.new
    end

    it "returns a list of reservations for given date" do

      dates = { start_date: Date.new(2018,6,7), end_date: Date.new(2018,6,10)}
      dates_2 = { start_date: Date.new(2018,6,5), end_date: Date.new(2018,6,15) }

      @front_desk_2.make_reservation(dates)
      @front_desk_2.make_reservation(dates_2)
      search_date = Date.new(2018,6,8)

      rezzies = @front_desk_2.find_reservations_for(search_date)

      rezzies.length.must_equal 2
    end

    it "returns empty array if no reservations exist for a given date" do
      front_desk = Hotel::FrontDesk.new
      search_date = Date.new(2018,7,11)

      reservations = front_desk.find_reservations_for(search_date)
      reservations.must_equal []
    end

    #
    #   it "gets list of all reservations for particular date"
    #
  end

  describe "#find_room" do
    it "finds the first available room" do
      front_desk = Hotel::FrontDesk.new
      room = front_desk.find_room( Date.new(2018, 4, 8), Date.new(2018, 4, 11))
      room.number.must_equal 1
    end
  end

  # describe "get_total_cost(reservation_id) method" do
  #
  #   it "returns the total cost of a given reservation"
  #
  # end

   # TODO: write test for: view a list of rooms that are not reserved for a given date range
end
