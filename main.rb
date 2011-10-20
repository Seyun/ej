# encoding: utf-8
$: << File.dirname( __FILE__)
require 'csv'

class Item
  attr_accessor :name, :category, :month, :applied_amount
  def initialize(name, category, month, applied_amount)
    @name = name
    @category = category
    @month = month
    @applied_amount = applied_amount
  end
  
  def self.read_from_csv(path)
    items = []
    item_names = {}
    CSV.open(path, 'r').each do |row|
      item = Item.new(row[0], row[1], row[2], row[3].to_i)
      items.push(item)
      item_names[item.name] = item.name
    end
    return items, item_names
  end
end

class Category
  attr_accessor :name, :month, :max_ratio, :applied_sum
  def initialize(name, month, max_ratio, applied_sum)
    @name = name
    @month = month
    @max_ratio = max_ratio
    @applied_sum = applied_sum
  end
  
  def self.read_from_csv(path)
    categories = []

    CSV.open(path, 'r').each do |row|
      c = Category.new(row[0], row[1], row[2].to_i, row[3].to_i)
      categories.push(c)
    end
    return categories
  end
end

items, item_names = Item.read_from_csv(ARGV[0])
#categories = Category.read_from_csv(ARGV[1])
item_names.keys.each do |item_name|
  list = items.select {|i| i.name == item_name}
  list.each {|l| puts l.name }
end
#categories = Category.read_from_csv(ARGV[1])

