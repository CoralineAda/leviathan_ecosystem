module HandlesErrors

  def self.included(klass)
    return if Rails.env.test?
    klass.rescue_from Exception, :with => :render_server_error
    #klass.rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found_error
    #klass.rescue_from User::NotAuthorized, :with => :render_auth_error 
  end

  def render_auth_error(exception=nil)
    log_exception(exception)
    render :json => {:error => "Not Authorized Error", :details => exception.to_s}, :status => 401 and return
  end

  def render_server_error(exception=nil)
    log_exception(exception)   
    render :json => {:error => "Server Error", :details => exception.to_s}, :status => 500 and return
  end

  def render_not_found_error(exception=nil)
    log_exception(exception)
    render :json => {:error => "Record Not Found", :details => exception.to_s}, :status => 404 and return
  end

  def backtrace_from(exception)
    return unless exception.backtrace
    exception.backtrace * "\n"
  end

  def log_exception(exception=nil)
    return unless exception
    Rails.logger.error "!!! Error: #{exception.message}\n#{backtrace_from(exception)}"
  end

end