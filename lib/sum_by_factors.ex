defmodule SumByFactors do
  @moduledoc """
  Documentation for `SumByFactors`.
  """

  def sum_of_divided(lst) do
    lst
    |> Enum.flat_map(&primes/1)
    |> Enum.uniq()
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

  def primes(upto) do
    for i <- 2..abs(upto), prime?(i), do: i
  end

  def prime?(2), do: 2

  def prime?(n) do
    Enum.all?(2..(trunc(:math.sqrt(n)) + 1), &(rem(n, &1) != 0))
  end
end
