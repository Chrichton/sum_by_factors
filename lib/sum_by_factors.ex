defmodule SumByFactors do
  @moduledoc """
  Documentation for `SumByFactors`.
  """

  def sum_of_divided([]), do: []

  def sum_of_divided(lst) do
    abs_lst = Enum.map(lst, &abs(&1))

    abs_lst
    |> Enum.map(&abs(&1))
    |> Enum.max()
    |> primes_upto_sqrt()
    |> add_complement_primes(abs_lst)
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

  def add_complement_primes(primes, lst) do
    Enum.reduce(lst, primes, fn number, acc ->
      complement_prime = complement_prime(number, primes)

      if complement_prime,
        do: [complement_prime | acc],
        else: acc
    end)
    |> Enum.uniq()
    |> Enum.sort()
  end

  def primes_upto_sqrt(upto) do
    for i <- 2..trunc(:math.sqrt(upto + 1)), prime?(i), do: i
  end

  def complement_prime(n, []) do
    if n > 1,
      do: n,
      else: nil
  end

  def complement_prime(n, [prime | primes]) do
    rest = complement_prime(n, prime)

    complement_prime(rest, primes)
  end

  def complement_prime(n, prime) do
    if rem(n, prime) == 0,
      do: complement_prime(div(n, prime), prime),
      else: n
  end

  def prime?(2), do: true

  def prime?(n) do
    Enum.all?(2..trunc(:math.sqrt(n + 1)), &(rem(n, &1) != 0))
  end
end
