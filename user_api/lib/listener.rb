module Listener

  require 'bunny'

  def self.start(klass)
    eval("#{klass.to_s.classify}Listener").new.listen!
  end

  def connection
    @connection ||= Bunny.new(:automatically_recover => true)
  end

  def channel
    @channel ||= connection.create_channel
  end

  def queue
    @queue ||= channel.queue(queue_name)
  end

  def queue_name
    raise "#{self.class.name} must implement a queue name!"
  end

  def listen!
    connection.start
    queue.subscribe(:block => false) do |delivery_info, properties, body|
      puts "((...)) Received from channel #{queue_name}: #{body}"
      process(JSON.parse(body))
    end
  end

end