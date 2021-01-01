defmodule SumByFactorsTest do
  use ExUnit.Case
  doctest SumByFactors

  test "case1" do
    assert SumByFactors.sum_of_divided([12, 15]) == [{2, 12}, {3, 27}, {5, 15}]
  end

  test "case2" do
    assert SumByFactors.sum_of_divided([15, 21, 24, 30, 45]) == [
             {2, 54},
             {3, 135},
             {5, 90},
             {7, 21}
           ]
  end

  test "case3" do
    assert SumByFactors.sum_of_divided([15, 30, -45]) == [{2, 30}, {3, 0}, {5, 0}]
  end
end
