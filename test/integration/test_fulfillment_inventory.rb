# frozen_string_literal: true

require 'integration_helper'
require 'mws/fulfillment_inventory'

class TestFulfillmentInventory < IntegrationTest
  def test_listing_inventory_supply
    clients.each do |client|
      res = client.list_inventory_supply(query_start_date_time: Date.today - 30)
      refute_empty res.parse
    end
  end

  def test_getting_service_status
    clients.each do |client|
      res = client.get_service_status
      refute_empty res.parse
    end
  end
end
