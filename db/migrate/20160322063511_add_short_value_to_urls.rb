class AddShortValueToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :short_value, :string
  end
end
