if ENV['WITH_LISTENERS']
  Listener.start(:customer)
end
