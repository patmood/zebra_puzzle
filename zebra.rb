# assume the houses are in a row

class House
  attr_accessor :number, :color, :nation, :drink, :smoke, :pet
  def initialize(position)
    @number = position
    @color = ["yellow","blue","red","ivory","green"]
    @nation = ["norway","ukranine","england","spain","japan"]
    @drink = ["water","tea","milk","oj","coffee"]
    @smoke = ["kools","chesterfield","oldgold","luckystrike","parliament"]
    @pet = ["fox","horse","snails","dog","zebra"]
  end

  def print
  p "===== HOUSE: #{number} ====="
  p color
  p nation
  p drink
  p smoke
  p pet
  end
end

# CONDITIONS
def check_conditions(houses)
  houses.each do |house|

    # conditions for testing
    # house.color = ["blue"] if house.number == 1

    # Simple conditions
    house.nation = ["norway"] if house.number == 0
    house.drink = ["milk"] if house.number == 2
    house.color = ["red"] if house.nation == ["england"]
    house.pet = ["dog"] if house.nation == ["spain"]
    house.color = ["green"] if house.drink == ["coffee"]
    house.drink = ["tea"] if house.nation == ["ukranine"]
    house.pet = ["snails"] if house.smoke == ["oldgold"]
    house.smoke = ["kools"] if house.color == ["yellow"]
    house.smoke = ["luckystrike"] if house.drink == ["oj"]
    house.nation = ["japan"] if house.smoke == ["parliament"]

    # Reverse simple conditions
    house.nation = ["england"] if house.color == ["red"]
    house.nation = ["spain"] if house.pet == ["dog"]
    house.drink = ["coffee"] if house.color == ["green"]
    house.nation = ["ukranine"] if house.drink == ["tea"]
    house.smoke = ["oldgold"] if house.pet == ["snails"]
    house.color = ["yellow"] if house.smoke == ["kools"]
    house.drink = ["oj"] if house.smoke == ["luckystrike"]
    house.smoke = ["parliament"] if house.nation == ["japan"]


    # Complex conditions:

    # 6 - The green house is immediately to the right of the ivory house.
    if houses[house.number-1].color == ["ivory"]
      house.color = ["green"]
    end
    if house.color == ["green"]
      houses[house.number+1].color = ["ivory"]
    end

    # 11 - The man who smokes chesterfields lives in the house next to the man with the fox.
    if house.pet == ["fox"]
      chesterfields_house = [house.number+1,house.number-1]
      houses.each do |elim_house|
        if !chesterfields_house.include?(elim_house.number)
          elim_house.smoke.delete("chesterfield")
        end
      end
    end
    if house.smoke == ["chesterfield"]
      fox_house = [house.number+1,house.number-1]
      houses.each do |elim_house|
        if !fox_house.include?(elim_house.number)
          elim_house.pet.delete("fox")
        end
      end
    end

    # 12 - kools are smoked in a house next to the house where the horse is kept
    if house.pet == ["horse"]
      kools_house = [house.number+1,house.number-1]
      houses.each do |elim_house|
        if !kools_house.include?(elim_house.number)
          elim_house.smoke.delete("kools")
        end
      end
    end
    if house.smoke == ["kools"]
      horse_house = [house.number+1,house.number-1]
      houses.each do |elim_house|
        if !horse_house.include?(elim_house.number)
          elim_house.pet.delete("horse")
        end
      end
    end

    # 15 - norway lives next to the blue house
    if house.color == ["blue"]
      norway_house = [house.number+1,house.number-1]
      houses.each do |elim_house|
        if !norway_house.include?(elim_house.number)
          elim_house.nation.delete("norway")
        end
      end
    end
    if house.nation == ["norway"]
      blue_house = [house.number+1,house.number-1]
      houses.each do |elim_house|
        if !blue_house.include?(elim_house.number)
          elim_house.color.delete("blue")
        end
      end
    end

  end
end

# NEEDS REFACTORING!
# If a house had a known property, delete that possibility from the others
def eliminate_known(houses)
  houses.each do |house|
    if house.color.length == 1
      houses.each do |elim_house|
        elim_house.color.delete(house.color[0]) unless elim_house.number == house.number
      end
    end

    if house.nation.length == 1
      houses.each do |elim_house|
        elim_house.nation.delete(house.nation[0]) unless elim_house.number == house.number
      end
    end

    if house.drink.length == 1
      houses.each do |elim_house|
        elim_house.drink.delete(house.drink[0]) unless elim_house.number == house.number
      end
    end

    if house.smoke.length == 1
      houses.each do |elim_house|
        elim_house.smoke.delete(house.smoke[0]) unless elim_house.number == house.number
      end
    end

    if house.pet.length == 1
      houses.each do |elim_house|
        elim_house.pet.delete(house.pet[0]) unless elim_house.number == house.number
      end
    end
  end
end

def check_uniqueness(houses)
  houses.each do
    # For each property (color, pet, etc) posibilities, subtract the posibilities from all the other houses
    # If you are left with 1 possibility, that means it's the only option and this property is now known
    # This is the case for houses[1], as it is the only house with the possibility of being blue
  end
end



# DRIVER CODE

houses = []
5.times do |i|
  houses << House.new(i)
end

10.times do
  check_conditions(houses)
  eliminate_known(houses)
end

houses.each {|house| house.print}


