defmodule KV.BucketPlainTest do
  use ExUnit.Case, async: true

  setup do
    { :ok, bucket } = KV.BucketPlain.start_link()
    %{ bucket: bucket }
  end

  test "stores values by key", %{ bucket: bucket } do
    assert KV.BucketPlain.get(bucket, "milk") == nil

    KV.BucketPlain.put(bucket, "milk", 5)
    assert KV.BucketPlain.get(bucket, "milk") == 5
  end

  test "deletes value by key", %{ bucket: bucket } do
    KV.BucketPlain.put(bucket, "milk", 4)
    KV.BucketPlain.put(bucket, "eggs", 2)
    assert KV.BucketPlain.delete(bucket, "milk") == 4
    assert KV.BucketPlain.get(bucket, "milk") == nil
    assert KV.BucketPlain.get(bucket, "eggs") == 2
  end

  test "stops the agent", %{ bucket: bucket } do
    KV.BucketPlain.stop(bucket)
    Process.sleep(500)
    assert Process.alive?(bucket) == false
  end
end
