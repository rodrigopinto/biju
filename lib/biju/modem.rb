require 'serialport'
require_relative 'sms'

module Biju
  class Modem

    # @param [Hash] Options to serial connection.
    # @option options [String] :port The modem port to connect
    #
    #   Biju::Modem.new(:port => '/dev/ttyUSB0')
    #
    def initialize(options={}, &block)
      raise Exception.new("Port is required") unless options[:port]
      pin = options.delete(:pin)
      @connection = connection(options)
      cmd("AT")
      # initialize modem
      cmd("ATZ")
      # unlock pin code
      cmd("AT+CPIN=\"#{pin}\"") if pin
      # set SMS text mode
      cmd("AT+CMGF=1")
      # set extended error reports
      cmd('AT+CMEE=1')
      #instance_eval &block if block_given?
    end

    # Close the serial connection.
    def close
      @connection.close
    end

    # Return an Array of Sms if there is messages nad return nil if not.
    def messages(which = "ALL")
      # read message from all storage in the mobile phone (sim+mem)
      cmd('AT+CPMS="MT"')
      # get message list
      sms = cmd('AT+CMGL="%s"' % which )
      # collect messages
      msgs = sms.scan(/\+CMGL\:\s*?(\d+)\,.*?\,\"(.+?)\"\,.*?\,\"(.+?)\".*?\n(.*)/)
      return nil unless msgs
      msgs.collect!{ |msg| Biju::Sms.new(:id => msg[0], :phone_number => msg[1], :datetime => msg[2], :message => msg[3].chomp) }
    end

    # Delete a sms message by id.
    # @param [Fixnum] Id of sms message on modem.
    def delete(id)
      cmd("AT+CMGD=#{id}")
    end

    def send_sms(sms, options = {})
      # initiate the sms, and wait for either
      # the text prompt or an error message
      cmd("AT+CMGS=\"#{sms.phone_number}\"")

      # send the sms, and wait until
      # it is accepted or rejected
      cmd("#{sms.message}#{26.chr}")
      # ... check reception
    end

    private
    def connection(options)
      port = options.delete(:port)
      SerialPort.new(port, default_options.merge!(options))
    end

    def default_options
      { :baud => 9600, :data_bits => 8, :stop_bits => 1, :parity => SerialPort::NONE }
    end

    def cmd(cmd)
      @connection.write(cmd + "\r")
      wait_str = wait
      #p "#{cmd} --> #{wait_str}"
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
