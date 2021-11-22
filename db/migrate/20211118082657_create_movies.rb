# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :status, default: 1
      t.integer :priority, default: 0
      t.datetime :schedule_date

      t.timestamps
    end

    add_index(:movies, :priority)
    add_index(:movies, :schedule_date)
  end
end
