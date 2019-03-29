module Proxys
  class OpenFile
    attr_reader :file_url

    def initialize(file_url)
      @file_url = file_url
    end

    def call
      proxy = Proxys::LuminatiProxy.call

      open(file_url,
           proxy_http_basic_authentication: [
             proxy[:ip],
             proxy[:username],
             proxy[:password]
           ])
    end
  end
end
