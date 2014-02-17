if ENV['WITH_LISTENERS']
  Rails.logger.info "Starting listeners..."
  LoggerListener.start
end
