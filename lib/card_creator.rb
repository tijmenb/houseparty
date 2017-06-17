class CardCreator
  attr_reader :listing, :trello_list

  def initialize(listing, trello_list)
    @listing = listing
    @trello_list = trello_list
  end

  def create
    if listing['image_url'].to_s != ""
      puts "Creating card: #{card_attributes}"
      unless ENV['DRY_RUN']
        card = Trello::Card.create(card_attributes)
        card.add_attachment(listing['image_url'])
      end
    end

    unless ENV['DRY_RUN']
      PostableListings.exclude(listing['listing_id'])
    end
  end

private

  def card_attributes
    formatter = ListingFormatter.new(listing)
    formatter.payload.merge(list_id: trello_list.id)
  end
end
