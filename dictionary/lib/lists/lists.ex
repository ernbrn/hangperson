defmodule Lists do
  def len([]), do: 0
  def len([_ | t]), do: 1 + len(t)

  def sum([]), do: 0
  def sum([h | t]), do: h + sum(t)

  def double([]), do: []
  def double(list = [_ | _]), do: map(list, &(&1 * 2))

  def square([]), do: []
  def square(list = [_ | _]), do: map(list, &(&1 * &1))

  def map([], _func), do: []

  def map([h | t], func) do
    [func.(h) | map(t, func)]
  end
end
