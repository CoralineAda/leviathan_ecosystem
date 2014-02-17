module Leviathan

  def self.devour(event, payload)
    Jonah.feed(event, payload)
  end

  class Jonah

    require 'bunny'
    include PoroPlus

    attr_accessor :payload 

    def self.feed(event, payload)
      new(payload: payload.merge(event: event)).broadcast
    end

    def broadcast
      queue_connection.start
      response = queue.publish(payload.to_json, routing_key: "log")
      queue_connection.close
      Rails.logger.info("Leviathan fed with: #{payload.inspect}")
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
      @queue ||= channel.queue('log')
    end

  end

end