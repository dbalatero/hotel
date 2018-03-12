require_relative 'spec_helper'

describe "FrontDesk class" do
  let(:admin) { Hotel::FrontDesk.new }
  let(:admin2) { Hotel::FrontDesk.new }
  let(:admin3) { Hotel::FrontDesk.new }

  describe "initialize" do
    it "is an instance of FrontDesk" do
      admin.must_be_kind_of Hotel::FrontDesk
    end

    it "loads a master list of all rooms" do
      admin.rooms.length.must_equal 20
      admin.rooms[0].number.must_equal 1
      admin.rooms[19].number.must_equal 20
    end
  end

  describe "#make_reservation(start_date:, end_date:)" do
    it "creates and stores a new Reservation" do
      dates = { start_date: Date.new(2018,6,7), end_date: Date.new(2018,6,10)}
      new_res = admin.make_reservation(dates)
      new_res.must_be_instance_of Hotel::Reservation
      admin.find_reservations_for( Date.new(2018, 6, 8))
        .must_include new_res
      new_res.start_date.must_equal Date.new(2018, 6, 7)
    end

    it "books a requested room, if available" do
      reservation = admin.make_reservation(start_date: Date.new(2018,8,20), end_date: Date.new(2018,8,27), room: 3)
      # binding.pry
      admin.rooms[2].reservations.must_include reservation
    end

    it "allows a reservation to start on the same day that another reservation for the same room ends"

    it "raises an error if the start or end date are not Date objects" do
      proc { admin2.make_reservation(start_date: 201897, end_date: 2018910) }
      .must_raise ArgumentError
    end

    it "raises an error if end_date is before start_date" do
      proc { admin2.make_reservation(start_date: Date.new(2018, 9, 15), end_date: Date.new(2018, 9, 10)) }
      .must_raise ArgumentError
    end

    it "raises an error if no rooms are available for given date range" do
      20.times do
        admin3.make_reservation(start_date: Date.new(2018, 9, 10), end_date: Date.new(2018, 9, 20))
      end
      proc { admin3.make_reservation(start_date: Date.new(2018, 9, 11), end_date: Date.new(2018, 9, 15)) }.must_raise ArgumentError
    end

    it
  end

  describe "#find_reservations_for(date)" do
    it "returns a list of reservations for given date" do
      admin.make_reservation({ start_date: Date.new(2018, 6, 7),
      end_date: Date.new(2018, 6, 10) })
      admin.make_reservation({ start_date: Date.new(2018, 6, 5),
      end_date: Date.new(2018, 6, 15) })
      search_date = Date.new(2018,6,8)
      rezzies = admin.find_reservations_for(search_date)
      rezzies.length.must_equal 2
      rezzies[0].start_date.must_equal Date.new(2018, 6, 7)
    end

    it "returns empty array if no reservations exist for a given date" do
      front_desk = Hotel::FrontDesk.new
      search_date = Date.new(2018,7,11)
      reservations = front_desk.find_reservations_for(search_date)
      reservations.must_equal []
    end
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

   #write test for: view a list of rooms that are not reserved for a given date range
end
