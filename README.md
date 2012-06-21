# Biju

[WIP] Biju is an easy way to mount a GSM modem to send, to receive and to delete messages through a ruby interface.
This is project is based on this [code snippet](http://dzone.com/snippets/send-and-receive-sms-text).

## Installation

Add this line to your application's Gemfile:

    gem 'biju'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install biju

## Usage

```
@modem = Biju::Modem.new(:port => "/dev/tty.HUAWEIMobile-Modem")

# method to list all messages
@modem.messages.each do |sms|
  puts sms
end

# method to send sms
sms = Biju::Sms.new(:phone_number => '+3312345678', :message => 'hello world')
@modem.send(sms)

@modem.close
```
## TODO

1. Write missing test for modem module.
2. Write a documentation.
3. Test with different kinds of modem and OS.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
