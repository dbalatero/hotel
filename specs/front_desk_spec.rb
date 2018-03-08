require_relative 'spec_helper'

describe "FrontDesk class" do

  describe "initialize" do

    it "is an instance of FrontDesk" do
      admin = Hotel::FrontDesk.new
      admin.must_be_kind_of Hotel::FrontDesk
    end

    it "loads a master list of all rooms" do
      admin = Hotel::FrontDesk.new

      admin.all_rooms.length.must_equal 20
      admin.all_rooms[0].must_be_instance_of Hotel::Room
      admin.all_rooms.must_be_kind_of Array
    end

    it "creates empty array to hold future reservations" do
      admin = Hotel::FrontDesk.new

      admin.reservations.length.must_equal 0
      admin.all_rooms.must_be_kind_of Array
    end

  end

  describe "make_reservation method" do

    it "creates a new instance of reservation" do
      front_desk = Hotel::FrontDesk.new
      dates = { start_date: Date.new(2018,6,7), end_date: Date.new(2018,6,10)}

      new_res = front_desk.make_reservation(dates)

      new_res.must_be_instance_of Hotel::Reservation
      new_res.res_id.must_equal 1
      front_desk.reservations.must_include new_res
      new_res.start_date.must_be_instance_of Date
    end

    it "selects the first available room"
    #this method still needs to be written

    it "adds the reservation to front desk's collection of reservations"

    it "adds the reserved date range to the room's collection of booked dates"

    it "stores start and end date as Date objects"

    it "raises an error if end_date is before start_date"

    it "returns nil if no rooms are available for given date range"

  end
  #
  describe "get_list_of_res_for(date) method" do

    before do
      @front_desk = Hotel::FrontDesk.new
    end

    it "returns a list of reservations for given date" do

      dates = { start_date: Date.new(2018,6,7), end_date: Date.new(2018,6,10)}
      dates_2 = { start_date: Date.new(2018,6,5), end_date: Date.new(2018,6,15) }

      @front_desk.make_reservation(dates)
      @front_desk.make_reservation(dates_2)
      search_date = Date.new(2018,6,8)

      rezzies = @front_desk.find_reservations_for(search_date)

      rezzies.must_be_kind_of Array
      rezzies.length.must_equal 2
    end

    it "returns empty array if no reservations exist for a given date" do
      front_desk = Hotel::FrontDesk.new
      search_date = Date.new(2018,7,11)

      reservations = front_desk.find_reservations_for(search_date)
      # binding.pry
      reservations.must_be_kind_of Array
      reservations.length.must_equal 0
    end

    #
    #   it "gets list of all reservations for particular date"
    #
  end

  # describe "get_total_cost(reservation_id) method" do
  #
  #   it "returns the total cost of a given reservation"
  #
  # end

end
