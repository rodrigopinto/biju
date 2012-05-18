require 'serialport'
require_relative 'sms'

module Biju
  class Modem
    def initialize(options={})
      raise Exception.new("Port is required") unless options[:port]
      @connection = connection(options)
      cmd("AT")
      cmd("AT+CMGF=1")
    end

    def connection(options)
      port = options.delete(:port)
      SerialPort.new(port, default_options.merge!(options))
    end

    def close
      @connection.close
    end

    def messages
      sms = cmd("AT+CMGL=\"ALL\"")
      msgs = sms.scan(/\+CMGL\:\s*?(\d+)\,.*?\,\"(.+?)\"\,.*?\,\"(.+?)\".*?\n(.*)/)
      return nil unless msgs
      msgs.collect!{ |msg| Biju::Sms.new(:id => msg[0], :phone_number => msg[1], :datetime => msg[2], :message => msg[3].chomp) }
    end

    private
    def default_options
      { :baud => 9600, :data_bits => 8, :stop_bits => 1, :parity => SerialPort::NONE }
    end

    def cmd(cmd)
      @connection.write(cmd + "\r")
      wait
    end

    def wait
      buffer = ''
      while IO.select([@connection], [], [], 0.25)
        chr = @connection.getc.chr;
        buffer += chr
      end
      buffer
    end
  end
end
