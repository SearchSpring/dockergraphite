require "simple-graphite"
require 'pp'
module DockerGraphite
  class GraphitePush
    attr_accessor :hostname, :port

    def initialize(options={})
      self.hostname = options[:hostname] ||= "localhost"
      self.port = options[:port] ||= 2003
    end

    def push(msg)
      g = Graphite.new
      g.host = self.hostname
      g.port = self.port
      g.push_to_graphite do |graphite|
        begin
          graphite.puts(msg) 
        rescue => e
          $stderr.puts "Unable to contact Graphite: #{e}"
        end
      end
      puts msg
    end

  end
end