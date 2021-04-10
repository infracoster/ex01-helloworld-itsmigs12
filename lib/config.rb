
Config = Struct.new(:cointracking_api_key, :cointracking_secret_key, :output_path, :read_from_cache, :cache_data_path, :combine_trades) do
  def cache_data_path
    File.expand_path(self[:cache_data_path]) if self[:cache_data_path]
  end

  def output_path
    File.expand_path(self[:output_path]) if self[:output_path]
  end

  def combine_trades
    self[:combine_trades] == false ? false : true
  end
  alias combine_trades? combine_trades