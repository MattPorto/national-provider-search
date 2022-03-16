class CreateCachedResults < ActiveRecord::Migration[6.1]
  def change
    create_table :cached_results do |t|
      t.string :npi, null: false

      t.timestamps
    end
  end
end
