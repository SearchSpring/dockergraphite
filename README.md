# Dockergraphite

This gem poll Docker for stats and push them to a graphite server.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dockergraphite'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dockergraphite

## Usage

```bash
Usage: dockergraphite [OPTIONS]
    -H, --host=HOSTNAME              Hostname of graphite server
    -p, --port=2003                  Port of graphite server
    -t, --period=60                  Number of seconds between polling stats
    -m, --metrics=m1,m2,m3           List of metrics you want to poll
    -e, --exclude=p1,p2,p3           List of patterns of container names to exclude
        --prefix=PREFIX              Prefix to prepend to graphite stats
```

A list of example stats that can be polled is in example_stats.txt

## Docker

setup Graphite
```bash
docker run -p 2003:2003 -p 8080:80 -d --name graphite sitespeedio/graphite
```
run DockerGraphite
```bash
docker run -v /var/run/docker.sock:/var/run/docker.sock:ro --link graphite searchspring/dockergraphite -t 10 --prefix docker -H graphite -m memory_stats.usage,cpu_stats.cpu_usage.total_usage,network.rx_bytes,network.tx_bytes
```

Checkout http://localhost:8080 , login with guest/guest.  Boom! stats.



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dockergraphite. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

