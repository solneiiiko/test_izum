require_relative 'party'
require 'test/unit'

class TestParty < Test::Unit::TestCase

  def test_example_big_limit
    inst = Party.new(limit: 100)
    res = [
      "Kellie Fletcher 3 'Espresso'",
      "Don Parsons 4 'Espresso'",
      "Geraldine Carpenter 7 'Espresso'",
      "Hilda Jimenez 8 'Espresso'",
      "Pauline Roberson 9 'Espresso'",
      "Mildred Carson 1 'Macchiato'",
      "Renee Reynolds 5 'Macchiato'",
      "Rudolph Bishop 6 'Macchiato'",
      "Vanessa Barrett 10 'Cappuccino'",
      "Clifford Brown 2 'Latte'"
    ]

    assert_equal(inst.guests, res)
  end

  def test_example_no_guests
    inst = Party.new(limit: 0.01)
    assert_equal(inst.guests, [])
  end

  def test_example_one_guest
    inst = Party.new(limit: 0.08)
    assert_equal(inst.guests, ["Kellie Fletcher 3 'Espresso'"])
  end

  def test_example_few_guests
    inst = Party.new(limit: 0.35)
    res = [
      "Kellie Fletcher 3 'Espresso'",
      "Don Parsons 4 'Espresso'",
      "Geraldine Carpenter 7 'Espresso'",
      "Hilda Jimenez 8 'Espresso'"
    ]
    assert_equal(inst.guests, res)
  end

  def test_one_guest_not_drink
    employees = File.open("data/employees.json").read.split(/^/).map{|str| JSON.parse(str) }
    inst = Party.new(limit: 0, employees: (employees + [{"id" => 11, "name" => "name_guest", "drinks" => []}]))
    assert_equal(inst.guests, ["name_guest 11"])
  end
end