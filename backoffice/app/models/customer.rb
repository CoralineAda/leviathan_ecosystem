class Customer

  include PoroPlus

  attr_accessor :first_name, :last_name, :email, :converted

  def self.all
    ApiConnector.synchronous.for(:customer).all.map{|h| new(h)}.sort_by{|r| r.last_name.to_s.downcase}
  end

end