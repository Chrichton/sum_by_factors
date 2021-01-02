defmodule SumByFactors do
  @moduledoc """
  Documentation for `SumByFactors`.
  """

  def sum_of_divided([]), do: []

  def sum_of_divided(lst) do
    lst
    |> Enum.map(&abs(&1))
    |> Enum.max()
    |> primes()
    |> produce_array(lst)
  end

  def produce_array(primes, lst) do
    Enum.reduce(lst, %{}, fn n, acc ->
      Map.put(acc, n, prime_factors(n, primes))
    end)
    |> produce_tuples()
  end

  def produce_tuples(%{} = map) do
    prime_factors =
      map
      |> Map.values()
      |> Enum.flat_map(& &1)
      |> Enum.uniq()
      |> Enum.sort()

    Enum.map(prime_factors, fn prime -> {prime, sum_of_numbers(map, prime)} end)
  end

  def sum_of_numbers(%{} = map, prime) do
    :maps.filter(fn _n, primes -> Enum.member?(primes, prime) end, map)
    |> Map.keys()
    |> Enum.sum()
  end

  def prime_factors(n, primes) do
    factors =
      primes
      |> Enum.filter(fn prime -> rem(n, prime) == 0 end)
      |> Enum.uniq()

    inverse_prime_factor = inverse_prime_factor(n, primes)

    if inverse_prime_factor == nil,
      do: factors,
      else: [inverse_prime_factor | factors]
  end

  def inverse_prime_factor(n, []) do
    if n > 1,
      do: n,
      else: nil
  end

  def inverse_prime_factor(n, [prime | primes]) do
    rest = inverse_prime_factor(n, prime)
    inverse_prime_factor(rest, primes)
  end

  def inverse_prime_factor(n, prime) do
    if rem(n, prime) == 0,
      do: inverse_prime_factor(div(n, prime), prime),
      else: n
  end

  # def produce_array(primes, lst) do
  #   Enum.reduce(primes, [], fn prime, acc ->
  #     produce_tuple(prime, lst, acc)
  #   end)
  #   |> Enum.reverse()
  # end

  # def produce_tuple(prime, lst, acc) do
  #   filtered = Enum.filter(lst, &(rem(&1, prime) == 0))

  #   if filtered == [],
  #     do: acc,
  #     else: [{prime, Enum.sum(filtered)} | acc]
  # end

  def primes(upto) do
    Enum.reduce(2..trunc(:math.sqrt(upto + 1)), [], fn n, acc ->
      if prime?(n, acc),
        do: [n | acc],
        else: acc
    end)
    |> Enum.reverse()
  end

  def prime?(n, primes), do: Enum.all?(primes, fn prime -> rem(n, prime) != 0 end)
end
