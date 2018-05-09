defmodule KV.BucketGenServerTest do
  use ExUnit.Case, async: true

  setup do
    bucket = start_supervised!(KV.BucketGenServer)
    %{ bucket: bucket }
  end

  test "stores values by key", %{ bucket: bucket } do
    assert KV.BucketGenServer.get(bucket, "milk") == nil

    KV.BucketGenServer.put(bucket, "milk", 5)
    assert KV.BucketGenServer.get(bucket, "milk") == 5
  end

  test "deletes value by key", %{ bucket: bucket } do
    KV.BucketGenServer.put(bucket, "milk", 4)
    KV.BucketGenServer.put(bucket, "eggs", 2)
    assert KV.BucketGenServer.delete(bucket, "milk") == 4
    assert KV.BucketGenServer.get(bucket, "milk") == nil
    assert KV.BucketGenServer.get(bucket, "eggs") == 2
  end

  test "stops the agent", %{ bucket: bucket } do
    KV.BucketGenServer.stop(bucket)
    assert Process.alive?(bucket) == false
  end
end
