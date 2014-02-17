if ENV['WITH_LISTENERS']
  Rails.logger.info "Starting listeners..."
  Listener.start(:widget)
end
