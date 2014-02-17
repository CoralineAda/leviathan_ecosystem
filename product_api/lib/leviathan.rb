module Leviathan

  def self.devour(payload)
    Jonah.feed(payload)
  end

  class Jonah

    require 'bunny'
    include PoroPlus

    attr_accessor :payload 

    def self.feed(data)
      new(payload: data).broadcast
    end

    def broadcast
      queue_connection.start
      response = queue.publish(payload.to_json)
      queue_connection.close
      Rails.logger.info("Message sent: #{payload.inspect}")
      self
    end

    private

    def queue_connection
      @queue_connection ||= Bunny.new(ENV['QUEUE_HOST'])
    end

    def channel
      @channel ||= queue_connection.create_channel
    end

    def queue
      @queue ||= channel.fanout('log')
    end

  end

end