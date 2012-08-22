require 'appygram-exception_notification/exception_notifier'
require 'appygram-exception_notification/config'

require 'net/http'

class AppygramExceptionNotification

  def self.exception_notification(env, exception, message)
    puts "hello, world"
    
    config = AppygramExceptionNotification::Config
    endpoint = '/appygrams'
    url = config.host || 'http://localhost:3000'
    url << endpoint
    uri = URI.parse url
    client = Net::HTTP.new uri.host, uri.port
    #client = optional_proxy.new(config.remote_host, config.remote_port)
    
    #client.open_timeout = config.http_open_timeout
    #client.read_timeout = config.http_read_timeout
    #client.use_ssl = config.ssl?
    #client.verify_mode = OpenSSL::SSL::VERIFY_NONE if config.ssl?
    
    hash = {
      'api_key' => config.api_key,
      'appygram[topic]' => 'Exception',
      'appygram[message]' => message
    }

    begin
      request = Net::HTTP::Post.new uri.path
      request.set_form_data hash
    
      response = client.request request
      case response
        when Net::HTTPSuccess
          puts ( "#{url} - #{response.message}")
          return true
        else
          puts ("#{url} - #{response.code} - #{response.message}")
        end
    rescue Exception => e
      puts ('Problem notifying Appygram about the error')
    end
  end

end
