
defmodule Day01 do
  def calib_value(entry) do
    chars = String.graphemes(entry)
    nums = Enum.filter(chars, fn c -> Integer.parse(c) != :error end)

    elem(Integer.parse(hd(nums) <> List.last(nums)), 0)
  end

  def get_this_number(entry) do
    case Integer.parse(String.first(entry)) do
      :error -> 
        cond do
          entry =~ ~r/^one/ -> 1
          entry =~ ~r/^two/ -> 2
          entry =~ ~r/^three/ -> 3
          entry =~ ~r/^four/ -> 4
          entry =~ ~r/^five/ -> 5
          entry =~ ~r/^six/ -> 6
          entry =~ ~r/^seven/ -> 7
          entry =~ ~r/^eight/ -> 8
          entry =~ ~r/^nine/ -> 9
          true -> :none
        end
      {i, _} -> i
    end
  end

  def get_forward("") do
    :error #invalid input
  end

  def get_forward(entry) do
    case Day01.get_this_number(entry) do
      :none -> get_forward(String.slice(entry, 1..-1))
      value -> value
    end
  end

  def get_backward(entry, start \\ -1) do 
    if abs(start) > String.length(entry), do: :error # invalid input
    case Day01.get_this_number(String.slice(entry, start..-1)) do
      :none -> get_backward(entry, start-1)
      value -> value
    end
    
  end

  def calib_value_2(entry) do
    fore = Day01.get_forward(entry)
    rear = Day01.get_backward(entry)
    fore*10+rear
  end

  def read do
    {:ok, input} = File.read("day01_input.txt")
    String.split(input)
  end

  def run do
    entries = Day01.read()
    values = Enum.map(entries, fn e -> Day01.calib_value_2(e) end)
    Enum.sum(values) |> IO.puts()
  end
    
end


