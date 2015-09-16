require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:    'sqlite3',
  database:   'hr.sqlite3'
)

class ProjectMigration < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer   :department_id
      t.string    :name
      t.string    :email
      t.string    :phone
      t.integer   :salary
      t.timestamps
    end

    create_table :departments do |t|
      t.string :name
      t.timestamps
    end

    create_table :reviews do |t|
      t.integer :employee_id
      t.string  :review
      t.timestamps
    end
  end
end
