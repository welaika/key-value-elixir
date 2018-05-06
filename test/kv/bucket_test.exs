defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    { :ok, bucket } = KV.Bucket.start_link()
    %{ bucket: bucket }
  end

  test "stores values by key", %{ bucket: bucket } do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 5)
    assert KV.Bucket.get(bucket, "milk") == 5
  end

  test "deletes value by key", %{ bucket: bucket } do
    KV.Bucket.put(bucket, "milk", 4)
    KV.Bucket.put(bucket, "eggs", 2)
    KV.Bucket.delete(bucket, "milk") == 4
    assert KV.Bucket.get(bucket, "milk") == nil
    assert KV.Bucket.get(bucket, "eggs") == 2
  end
end
