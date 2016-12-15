require 'docker-api'
require 'dockergraphite/utilities'

module DockerGraphite
  class DockerStats
  
    attr_accessor :metrics, :prefix, :exclude, :msg
  
    def initialize(options={})
        self.metrics = options[:metrics] ||= [ "memory_stats.usage" ]
        self.prefix = options[:prefix] 
        self.exclude = options[:exclude] ||= []
        self.msg = ""
    end
  
    def fetch()
      self.msg = ""
      Docker::Container.all.each do |container|
        name = container.info.dig("Names")[0].tr("/","")
        
        matched = false
        self.exclude.each do |pattern|
          matched = true if /#{pattern}/.match(name)
        end
        next if matched
        
        self.metrics.each do | metric |
          val = container.stats.dig(metric)
          self.msg += "#{self.prefix}." if self.prefix
          self.msg += "#{name}.#{metric} #{val} #{Time.now.to_i}\n"
        end

      end
    end
  end
end