defmodule KV.BucketAgentTest do
  use ExUnit.Case, async: true

  setup do
    { :ok, bucket } = KV.BucketAgent.start_link()
    %{ bucket: bucket }
  end

  test "stores values by key", %{ bucket: bucket } do
    assert KV.BucketAgent.get(bucket, "milk") == nil

    KV.BucketAgent.put(bucket, "milk", 5)
    assert KV.BucketAgent.get(bucket, "milk") == 5
  end

  test "deletes value by key", %{ bucket: bucket } do
    KV.BucketAgent.put(bucket, "milk", 4)
    KV.BucketAgent.put(bucket, "eggs", 2)
    assert KV.BucketAgent.delete(bucket, "milk") == 4
    assert KV.BucketAgent.get(bucket, "milk") == nil
    assert KV.BucketAgent.get(bucket, "eggs") == 2
  end

  test "stops the agent", %{ bucket: bucket } do
    KV.BucketAgent.stop(bucket)
    assert Process.alive?(bucket) == false
  end
end
