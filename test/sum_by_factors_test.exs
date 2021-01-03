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

  test "empty" do
    assert SumByFactors.sum_of_divided([]) == []
  end

  test "failed" do
    assert SumByFactors.sum_of_divided([-29804, -4209, -28265, -72769, -31744]) == [
      {2, -61548},
      {3, -4209},
      {5, -28265},
      {23, -4209},
      {31, -31744},
      {53, -72769},
      {61, -4209},
      {1373, -72769},
      {5653, -28265},
      {7451, -29804}
    ]
  end
end
