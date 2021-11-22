class CreateMetrics < ActiveRecord::Migration[6.0]
  def change
    create_table :metrics do |t|
      t.string :identifier, null: false
      t.string :url, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index(
      :metrics,
      [:user_id, :start_time, :end_time],
      name: :idx_user_start_end_time
    )
  end
end
