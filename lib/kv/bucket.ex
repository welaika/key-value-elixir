defmodule KV.Bucket do
  use Agent

  def start_link(_options \\ []) do
    Agent.start_link(fn -> %{} end)
  end

  def get(bucket, key) do
    Agent.get(bucket, fn (mappa) -> Map.get(mappa, key) end)
  end

  def put(bucket, key, value) do
    Agent.update(bucket, fn (mappa) -> Map.put(mappa, key, value) end)
  end
end
