class CreateTableSignalpros < ActiveRecord::Base
  def self.down
      drop_table :signalpros
  end
end
