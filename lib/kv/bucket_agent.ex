defmodule KV.BucketAgent do
  use Agent

  def start_link(options \\ []) do
    Agent.start_link(fn -> %{} end, options)
  end

  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

  def put(bucket, key, value) do
    Agent.update(bucket, &Map.put(&1, key, value))
  end

  def delete(bucket, key) do
    Agent.get_and_update(bucket, &Map.pop(&1, key))
  end

  def stop(bucket, reason \\ :normal) do
    Agent.stop(bucket, reason)
  end
end
