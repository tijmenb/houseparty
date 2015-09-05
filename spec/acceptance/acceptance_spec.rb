require 'spec_helper'

describe "Houseparty" do
  it "sends Zoopla house listings to Trello" do
    stub_const('ZooplaSearch::SEARCHES', [{ area: 'London' }])

    stub_request(:get, %r[http://api.zoopla.co.uk/api/v1/property_listings.json*]).
      to_return(body: read_fixture('zoopla-listings'))

    stub_request(:get, "https://api.trello.com/1/boards/MY-TRELLO-BOARD-ID?key=MY-TRELLO-API-KEY&token=MY-MEMBER-TOKEN").
      to_return(body: read_fixture('trello-board'))

    stub_request(:get, "https://api.trello.com/1/boards/MY-TRELLO-BOARD-ID/lists?filter=open&key=MY-TRELLO-API-KEY&token=MY-MEMBER-TOKEN").
      to_return(body: read_fixture('trello-board-lists'))

    card_create = stub_request(:post, "https://api.trello.com/1/cards?key=MY-TRELLO-API-KEY&token=MY-MEMBER-TOKEN").
      to_return(body: read_fixture('trello-card'))

    image_attach = stub_request(:post, "https://api.trello.com/1/cards/A-CARD-ID/attachments?key=MY-TRELLO-API-KEY&token=MY-MEMBER-TOKEN").
      to_return(body: read_fixture('trello-card'))

    Runner.new.run

    expect(card_create).to have_been_requested.times(10)
    expect(image_attach).to have_been_requested.times(10)

    Runner.new.run

    expect(card_create).to have_been_requested.times(10)
    expect(image_attach).to have_been_requested.times(10)
  end
end
