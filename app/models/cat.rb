# == Schema Information
#
# Table name: cats
#
#  id         :integer          not null, primary key
#  age        :integer
#  birth_date :string(255)
#  color      :string(255)
#  name       :string(255)      not null
#  sex        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Cat < ActiveRecord::Base
  
  COLORS = %w{blue brown white black orange grey golden}
  
  validates :age, numericality: true
  validates :color, inclusion: COLORS
  validates :sex, inclusion: %w{M F}
  validates :name, presence: true
  
  has_many :cat_rental_requests, dependent: :destroy
  
end
