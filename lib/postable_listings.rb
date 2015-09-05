class PostableListings
  REDIS_KEY = "troopla-posted-listings-#{ENV['RACK_ENV']}"

  attr_reader :zoopla_search
  delegate :redis, to: :class

  def initialize(zoopla_search = ZooplaSearch.new)
    @zoopla_search = zoopla_search
  end

  def self.exclude(listing_id)
    redis.sadd(REDIS_KEY, listing_id)
  end

  def self.clear
    redis.del(REDIS_KEY)
  end

  def listings
    zoopla_search.listings.reject do |listing|
      posted_listings.include?(listing['listing_id'])
    end
  end

private

  def posted_listings
    @posted_listings ||= redis.smembers(REDIS_KEY)
  end

  def self.redis
    @redis ||= begin
      uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/" )
      Redis.new(host: uri.host, port: uri.port, password: uri.password)
    end
  end
end
