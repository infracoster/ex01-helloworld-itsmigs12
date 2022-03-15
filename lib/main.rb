require 'bundler/setup'
require 'digest'

require File.join(ROOT_PATH, '/lib/object')
require File.join(ROOT_PATH, '/lib/mapping')
require File.join(ROOT_PATH, '/lib/config')
require File.join(ROOT_PATH, '/lib/utils')
require File.join(ROOT_PATH, '/lib/database')

include Utils

TRADING_FIELDS  = %w(DATE ACTION SOURCE SYMBOL VOLUME TOTAL CURRENCY FEE FEECURRENCY)
INCOME_FIELDS   = %w(DATE ACTION SOURCE SYMBOL VOLUME TOTAL CURRENCY)
SPENDING_FIELDS = %w(DATE ACTION SOURCE SYMBOL VOLUME)

def convert_type(ct_type)
  TYPE_MAPPING.each_key do |regexp|
    return TYPE_MAPPING[regexp] if ct_type =~ regexp
  end

  nil
end

def retrieve_trades_data
  puts "Retrievin