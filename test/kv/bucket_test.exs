defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  test "stores values by key" do
    { :ok, bucket } = KV.Bucket.start_link()
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 5)
    assert KV.Bucket.get(bucket, "milk") == 5
  end
end
