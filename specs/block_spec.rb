require_relative 'spec_helper'

describe "Block class" do
  let(:block) { Hotel::Block.new(start_date: Date.new(2018, 10, 10), end_date: Date.new(2018, 10, 15)) }

  describe "initialize" do
    it "sets the appropriate rate given optional input" do
      new_block = Hotel::Block.new(start_date: Date.new(2018, 3, 15), end_date: Date.new(2018, 3, 18), rate: 99, name: "Peters Wedding")
      new_block.rate.must_equal 99
      new_block.name.must_equal "Peters Wedding"
    end

    it "sets the default per room rate if none is given" do
       block.rate.must_equal 125
     end
  end

  describe "#booked_for?(date)" do
    it "returns true if the Block is booked on a given date" do
      block.booked_for?(Date.new(2018, 10, 12)).must_equal true
    end

    it "returns false if the Block is not booked on a given date" do
      block.booked_for?(Date.new(2018, 4, 1)).must_equal false
    end
  end
end
