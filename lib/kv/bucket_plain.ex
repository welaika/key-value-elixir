defmodule KV.BucketPlain do

  # Client Interface

  def start_link(_options \\ []) do
    { :ok, spawn_link(__MODULE__, :init, [:ok]) }
  end

  def get(bucket, key) do
    send bucket, { :get, key, self() }
    receive do
      { :ok, value } ->
        value
    end
  end

  def put(bucket, key, value) do
    send bucket, { :put, key, value }
    :ok
  end

  def delete(bucket, key) do
    send bucket, { :delete, key, self() }
    receive do
      { :ok, value } ->
        value
    end
  end

  def stop(bucket, reason \\ :normal) do
    send bucket, { :stop, reason }
    :ok
  end

  # Server interface (callbacks)

  def init(:ok) do
    state = %{}
    loop(state)
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
      { :stop, reason } ->
        IO.puts "Bye! reason: #{reason}"
      _ ->
        IO.puts "Da fuck?"
        loop(map)
    end
  end
end
