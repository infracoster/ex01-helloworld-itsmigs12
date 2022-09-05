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
    api = CoinTracking::Api.new($config.cointracking_api_key, $config.cointracking_secret_key)
    data = api.trades.data
    File.write($config.cache_data_path, data.to_yaml) if $config.cache_data_path
  end

  puts "Saving trades to memory..."
  data.each_pair do |id, values|
    next unless id.to_i.to_s == id.to_s
    t = Trade.from_cointracking(id, values)
    t.save!
    print '.'
  end

  print "\n"
end


def order_fingerprint(ct_trade)
  Digest::SHA256.hexdigest "#{values['time']}-#{values['buy_currency']}-#{values['sell_currency']}-#{values['fee_currency']}"
end

def trading_line(trade)
  txn_type 