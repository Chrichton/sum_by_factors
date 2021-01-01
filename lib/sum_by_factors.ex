defmodule SumByFactors do
  @moduledoc """
  Documentation for `SumByFactors`.
  """

  def sum_of_divided(lst) when length(lst) == 0, do: []

  def sum_of_divided(lst) do
    lst
    |> Enum.map(&abs(&1))
    |> Enum.max()
    |> primes()
    |> produce_array(lst)
  end

  def produce_array(primes, lst) do
    Enum.reduce(primes, [], fn prime, acc ->
      produce_tuple(prime, lst, acc)
    end)
    |> Enum.reverse()
  end

  def produce_tuple(prime, lst, acc) do
    filtered = Enum.filter(lst, &(rem(&1, prime) == 0))

    if filtered == [],
      do: acc,
      else: [{prime, Enum.sum(filtered)} | acc]
  end

  def prime_factors(num, next \\ 2)

  def prime_factors(num, 2) do
    num = abs(num)

    cond do
      rem(num, 2) == 0 -> [2 | prime_factors(div(num, 2))]
      4 > num -> [num]
      true -> prime_factors(num, 3)
    end
  end

  def prime_factors(num, next) do
    cond do
      rem(num, next) == 0 -> [next | prime_factors(div(num, next))]
      next + next > num -> [num]
      true -> prime_factors(num, next + 2)
    end
  end

  def primes(upto) do
    for i <- 2..upto, prime?(i), do: i
  end

  def prime?(2), do: true

  def prime?(n) do
    Enum.all?(2..(trunc(:math.sqrt(n)) + 1), &(rem(n, &1) != 0))
  end
end
