module Biju
  class Sms
    attr_accessor :id, :phone_number, :datetime, :message

    def initialize(params={})
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if params
    end

    def datetime
      @datetime.sub(/(\d+)\D+(\d+)\D+(\d+),(\d*\D)(\d*\D)(\d+)(.*)/, '20\1-\2-\3 \4\5\6')
    end

    def to_s
      "#{id} - #{phone_number} - #{datetime} - #{message}"
    end
  end
end
