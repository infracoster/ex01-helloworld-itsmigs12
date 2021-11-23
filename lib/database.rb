require 'active_record'
require 'attribute_normalizer'
require 'rounding'
require 'byebug'

ActiveRecord::Schema.verbose = false
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Base.send :include, AttributeNormalizer

ActiveRecord::Schema.define(version: 1) do
  create_table "trades" do |t|
    t.decimal  "buy_amount"
    t.string   "buy_currency"
    t.decimal  "sell_amount"
    t.string   "sell_currency"
    t.decimal  "fee_amount"
    t.string   "fee_currency"
    t.string   "txn_type"
    t.string   "exchange"
    t.string   "group"
    t.string   "comment"
    t.string   "imported_from"
    t.datetime "time"
    t.datetime "imported_time"
    t.string   "trade_id"
    t.string   "order_hash"
  end
end

class Trade < ActiveRecord::Base
  before_save :set_order_hash

  normalize_attribute :txn_type do |v|
    v.strip.downcase
  end

  n