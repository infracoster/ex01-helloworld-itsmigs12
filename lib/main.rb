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
  puts "Retrieving trades from CoinTracking..."
  if $config.read_from_cache && File.exists?($config.cache_data_path)
    data = YAML.load_file($config.cache_data_path)
  else
    api = Co