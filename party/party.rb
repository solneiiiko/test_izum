require 'json'

class Party

  def initialize(opts={})
    @limit = opts[:limit]
    @employees = opts[:employees] || File.open( opts[:employees_file] || "data/employees.json").read.split(/^/).map{|str| JSON.parse(str) }
    @prices = opts[:prices] || JSON.parse(File.open( opts[:prices_file] || "data/prices.json").read)
    @recipes = opts[:recipes] || JSON.parse(File.open( opts[:recipes_file] || "data/recipes.json").read)
  end

  def guests
    return @quests if defined? @quests

    drink_prices = (@recipes.map do |n, c|
      [ n, c.map{|cn, count| @prices[cn]*count}.inject(:+) ]
    end).to_h

    new_employees = (@employees.map do |e|
      drink = e["drinks"].min_by {|drink| drink_prices[drink] }
      e.merge( drink: drink, price: (drink_prices[drink] || 0))
    end).sort{|a, b| a[:price] == b[:price] ? a[:id]<=>b[:id] : a[:price]<=>b[:price] }

    @guests = []
    new_employees.each do |e|
      if e[:price] <= @limit
        @guests << [ e["name"], e["id"], e[:drink] ? "'#{e[:drink]}'" : nil ].compact.join(' ')
        @limit -= e[:price]
      else
        return @guests
      end
    end

    @guests
  end
end