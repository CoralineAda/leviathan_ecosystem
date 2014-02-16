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

    def save
      self.synchronous && post || broadcast
    end

    private

    def payload
      payload = {customer: self.object.to_hash}
      p payload
      payload
    end

    def post

      response = HTTParty.post("#{endpoint}.json", query: payload)
      self.errors = response.code != 200 && response.body
      self
    end

    def broadcast
      raise "not yet implemented"
    end

  end

end