# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :string(255)      not null
#  end_date   :string(255)      not null
#  status     :string(255)      default("PENDING")
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  before_validation do
    self.status ||= "PENDING"
  end  
  
  validates :status, inclusion: %w{PENDING APPROVED DENIED}
  validates :cat_id, :start_date, :end_date, presence: true
  belongs_to :cat
  
  def overlapping_requests
    CatRentalRequest.find_by_sql([<<-SQL, self.start_date, self.end_date, self.start_date, self.id, self.cat_id])
      SELECT
        *
      FROM
        cat_rental_requests
      WHERE (
        (start_date BETWEEN ? AND ?)
        OR (? BETWEEN start_date AND end_date)
        AND ? != id
        AND cat_id = ?      
      )
    SQL
  end
  
  def overlapping_approved_requests
    overlapping_requests.select{|request|request.status = "APPROVED"}
  end
    
    
  
end
