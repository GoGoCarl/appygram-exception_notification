class ExceptionNotifier

  def call(env)
    @app.call(env)
  rescue Exception => exception
    options = (env['exception_notifier.options'] ||= Notifier.default_options)
    options.reverse_merge!(@options)
    
    unless ignored_exception(options[:ignore_exceptions], exception)       ||
      from_crawler(options[:ignore_crawlers], env['HTTP_USER_AGENT']) ||
      conditionally_ignored(options[:ignore_if], env, exception)
      
      #Notifier.exception_notification(env, exception).deliver
      #@campfire.exception_notification(exception)
      AppygramExceptionNotification.hi
      env['exception_notifier.delivered'] = true
    end

    raise exception
  end

end
