require 'pp'
module DockerGraphite
  class Loop
    attr_accessor :hostname, :port, :metrics, :period, :prefix, :exclude
    
    def initialize(options={})
      self.hostname = options[:hostname]
      self.port = options[:port]
      self.metrics = options[:metrics]
      self.period = options[:period]
      self.prefix = options[:prefix]
      self.exclude = options[:exclude]
    end  

    def start
      puts "Starting main loop\n"
      stats = DockerGraphite::DockerStats.new(
        :metrics => self.metrics,
        :prefix => self.prefix,
        :exclude => self.exclude
      )
      graphite = DockerGraphite::GraphitePush.new(
        :hostname => self.hostname,
        :port => self.port
      )
      loop do
        stats.fetch
        graphite.push(stats.msg)
        puts "sleeping for #{self.period}\n"
        sleep(self.period) 
      end

    end
  end
end