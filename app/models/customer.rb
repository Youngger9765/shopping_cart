class Customer < ActiveRecord::Base
  validates_presence_of :name, :phone
  validates_numericality_of :company_tax_id, :only_integer => true

  has_many :orders


end
