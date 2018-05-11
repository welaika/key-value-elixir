defmodule KV.BucketGenServer do
  use GenServer

  # Client interface

  def start_link(options \\ []) do
    GenServer.start_link(__MODULE__, :ok, options)
  end

  def get(bucket, key) do
    GenServer.call(bucket, { :get, key })
  end

  def put(bucket, key, value) do
    GenServer.cast(bucket, { :put, key, value })
  end

  def delete(bucket, key) do
    GenServer.call(bucket, { :delete, key })
  end

  def stop(bucket, reason \\ :normal) do
    GenServer.stop(bucket, reason)
  end

  # Server interface (callbacks)

  def init(:ok) do
    { :ok, %{} }
  end

  def handle_call({ :get, key }, _from, state) do
    value = Map.get(state, key)
    { :reply, value, state }
  end

  def handle_call({ :delete, key }, _from, state) do
    { value, new_state } = Map.pop(state, key)
    { :reply, value, new_state }
  end

  def handle_cast({ :put, key, value}, state) do
    new_state = Map.put(state, key, value)
    { :noreply, new_state}
  end
end
