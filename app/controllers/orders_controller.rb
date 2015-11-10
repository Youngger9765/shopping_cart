class OrdersController < ApplicationController
  
  belongs_to :customer
  has_many :products

end
