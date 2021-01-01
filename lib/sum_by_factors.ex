defmodule SumByFactors do
  @moduledoc """
  Documentation for `SumByFactors`.
  """

  def sum_of_divided(lst) do
    lst
    |> Enum.flat_map(&prime_factors/1)
    |> Enum.uniq()
    |> Enum.sort()
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

  def prime_factors(n) do
    n = abs(n)
    first_divisor =
      div(n, 2)..1
      |> Enum.find(&(rem(n, &1) == 0))

    case first_divisor do
      1 -> [n]
      _ -> prime_factors(div(n, first_divisor)) ++ prime_factors(first_divisor)
    end
  end

  def primes(upto) do
    for i <- 2..abs(upto), prime?(i), do: i
  end

  def prime?(2), do: 2

  def prime?(n) do
    Enum.all?(2..(trunc(:math.sqrt(n)) + 1), &(rem(n, &1) != 0))
  end
end
