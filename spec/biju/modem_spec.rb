require_relative '../spec_helper'

# TODO: Fix missing tests SOON
describe Biju::Modem do
  describe ".new" do
    it "should raise an Exception without port option" do
      lambda { Biju::Modem.new }.must_raise Exception
    end
  end
end