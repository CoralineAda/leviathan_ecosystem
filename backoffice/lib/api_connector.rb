module ApiConnector

  def self.endpoints
    {
      :customers => ENV['CUSTOMER_API_ENDPOINT']
    }
  end

  def self.synchronous
    Connection.new(synchronous: true)
  end

  def self.asynchronous
    Connection.new(synchronous: false)
  end

  class Connection

    require 'bunny'
    include PoroPlus

    attr_accessor :klass, :object, :objects, :synchronous, :errors

    def endpoint
      ApiConnector.endpoints[self.klass.to_s.pluralize.to_sym]
    end

    def for(klass)
      self.klass = klass
      self
    end

    def with(data)
      self.object = data
      self
    end

    def all
      get_all
    end

    def save
      self.synchronous && post || broadcast
    end

    private

    def payload
      self.object.to_hash
    end

    def get_all
      response = HTTParty.get("#{endpoint}.json")
      body = JSON.parse(response.body)['response']
      response.code == 200 && body["#{klass.to_s.pluralize}"] || []
    end

    def post
      response = HTTParty.post("#{endpoint}.json", query: payload)
      self.errors = response.code != 200 && response.body
      self
    end

    def queue_connection
      @queue_connection ||= Bunny.new(ENV['QUEUE_HOST'])
    end

    def channel
      @channel ||= queue_connection.create_channel
    end

    def queue
      @queue ||= channel.queue(klass.to_s)
    end

    def broadcast
      queue_connection.start
      response = queue.publish(payload.to_json, :routing_key => queue.name)
      queue_connection.close
      Rails.logger.info("Message sent: #{payload.inspect}")
      self
    end

  end

end