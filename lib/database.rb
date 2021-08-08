require 'active_record'
require 'attribute_normalizer'
require 'rounding'
require 'byebug'

ActiveRecord::Schema.verbose = false
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Base.send :include, AttributeN