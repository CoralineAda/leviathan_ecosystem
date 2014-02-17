class LoggerListener

  require 'bunny'

  def self.start
    new.listen!
  end

  def connection
    @connection ||= Bunny.new
  end

  def channel
    @channel ||= connection.create_channel
  end

  def fanout
    channel.fanout("log")
  end

  def queue
    @queue ||= channel.queue("log")
  end

  def process(json)
    Event.from(json)
  end

  def listen!
    connection.start
    queue.subscribe(:block => false) do |delivery_info, properties, body|
      puts "((...)) Received from channel log: #{body}"
      process(body)
    end
  end

end