require 'jeff'

module Peddler
  # Service is an abstract wrapper around a Marketplace Web Services (MWS)
  # endpoint.
  class Service
    include Jeff

    attr_accessor :country, :seller_id

    # The initializer takes four arguments:
    #
    # country               - The String ISO 3166-1 two-letter country code of
    #                         the base marketplace of the seller.
    # aws_access_key_id     - The String AWS access key id.
    # aws_secret_access_key - The String AWS secret access key.
    # seller_id             - The String MWS merchant id.
    #
    # These arguments are optional and can be set individually later.
    def initialize(country = nil, aws_access_key_id = nil, aws_secret_access_key = nil, seller_id = nil)
      @country = country
      @aws_access_key_id = aws_access_key_id
      @aws_secret_access_key = aws_secret_access_key
      @seller_id = seller_id
    end

    # A list of MWS hosts.
    HOSTS = {
      'CA' => 'mws.amazonservices.ca',
      'CN' => 'mws.amazonservices.com.cn',
      'DE' => 'mws-eu.amazonservices.com',
      'ES' => 'mws-eu.amazonservices.com',
      'FR' => 'mws-eu.amazonservices.com',
      'GB' => 'mws-eu.amazonservices.com',
      'IN' => 'mws.amazonservices.in',
      'IT' => 'mws-eu.amazonservices.com',
      'JP' => 'mws.amazonservices.jp',
      'US' => 'mws.amazonservices.com'
    }

    # A list of marketplace ids.
    MARKETPLACE_IDS = {
      'CA' => 'A2EUQ1WTGCTBG2',
      'CN' => 'AAHKV2X7AFYLW',
      'DE' => 'A1PA6795UKMFR9',
      'ES' => 'A1RKKUPIHCS9HS',
      'FR' => 'A13V1IB3VIYZZH',
      'GB' => 'A1F83G8C2ARO7P',
      'IN' => 'A21TJRUUN4KGV',
      'IT' => 'APJ6JRA9NG5V4',
      'JP' => 'A1VC38T7YXB528',
      'US' => 'ATVPDKIKX0DER'
    }

    # Gets/Sets the path of the MWS endpoint.
    #
    # path - A String path (default: nil).
    def self.path(path = nil)
      path ? @path = path : @path
    end

    def self.inherited(base)
      base.params(params)
      base.path(path)
    end

    params('SellerId' => -> { seller_id })

    # Returns the String MWS endpoint.
    def endpoint
      "https://#{HOSTS.fetch(country)}/#{self.class.path}"
    end

    # Get the marketplace id for a given country.
    #
    # country - A String ISO 3166-1 two-letter country code.
    #
    # Returns a String marketplace id.
    def marketplace_id(country)
      MARKETPLACE_IDS.fetch(country)
    end
  end
end
