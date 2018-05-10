defmodule KV.BucketPlain do

  def start_link(_options \\ []) do
    spawn_link(__MODULE__, :loop, [%{}])
  end

  def loop(map) do
    receive do
      { :get, key, caller } ->
        value = Map.get(map, key)
        send caller, { :ok, value }
        loop(map)
      { :put, key, value } ->
        new_map = Map.put(map, key, value)
        loop(new_map)
      { :delete, key, caller } ->
        { value, new_map } = Map.pop(map, key)
        send caller, { :ok, value }
        loop(new_map)
      { :stop } ->
        IO.puts "Bye!"
      _ ->
        IO.puts "Da fuck?"
        loop(map)
    end
  end
end
