class ChangeDates < ActiveRecord::Migration
  def change
    change_column :cat_rental_requests, :start_date, :datetime
    change_column :cat_rental_requests, :end_date, :datetime
  end
end
