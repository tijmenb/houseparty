class ListingFormatter
  attr_reader :source

  def initialize(source)
    @source = source
  end

  def payload
    {
      name: name,
      desc: description,
    }
  end

private

  def name
    address = source.fetch('displayable_address')
    price = source.fetch('rental_prices').fetch('per_month')
    "#{address} - £#{price}"
  end

  def description
    [
      source.fetch('description'),
      "### " + source.fetch('details_url'),
      "https://www.google.com/maps/dir/52+Wharf+Rd,+London+N1/#{safe_location}",
      "https://www.google.com/maps/dir/Holborn,+London,+UK/#{safe_location}",
    ].join("\n\n")
  end

  def safe_location
    source.fetch('displayable_address').gsub(' ', '+')
  end
end
