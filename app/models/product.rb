class Product < ActiveRecord::Base
  validates_presence_of :name, :unit, :price
  validates_uniqueness_of :name, :message => "你的名稱重複了"
  validates_numericality_of :price, :only_integer => true

  has_many :order_product_ships
  has_many :orders, :through => :order_product_ships

  require 'roo'

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    Product.all.delete_all
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      row.to_hash[:id] = i
      product = new
      product.attributes = row.to_hash
      product.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, :ignore)
    when ".xls" then Roo::Excel.new(file.path, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end

  