module Proxys
  class LuminatiProxy
    def self.call
      session = Random.rand(100_000)

      {
        ip: ENV['LUMINAT_URL'],
        username: "#{ENV['LUMINAT_USERNAME']}-zone-static-session-#{session}",
        password: ENV['LUMINAT_PASSWORD']
      }
    end
  end
end
