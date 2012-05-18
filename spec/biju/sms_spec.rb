require_relative '../spec_helper'

describe Biju::Sms do
  subject { Biju::Sms.new(:id => "1", :phone_number => "144", :datetime => "11/07/28,15:34:08-12", :message => "Some text here")}

  it { subject.id.must_equal "1" }

  it { subject.phone_number.must_equal "144" }

  it { subject.datetime.must_equal "2011-07-28 15:34:08" }

  it { subject.message.must_equal "Some text here" }

  it { subject.to_s.must_equal "1 - 144 - 2011-07-28 15:34:08 - Some text here"}
end