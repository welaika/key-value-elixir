defmodule KV.BucketPlainTest do
  use ExUnit.Case, async: true

  setup do
    bucket = KV.BucketPlain.start_link([])
    %{ bucket: bucket }
  end

  test "stores values by key", %{ bucket: bucket } do
    send bucket, { :get, "milk", self() }
    assert_receive { :ok, nil }

    send bucket, { :put, "milk", 5 }
    send bucket, { :get, "milk", self() }
    assert_receive { :ok, 5 }
  end

  test "deletes value by key", %{ bucket: bucket } do
    send bucket, { :put, "milk", 5 }
    send bucket, { :delete, "milk", self() }
    assert_receive { :ok, 5 }

    send bucket, { :get, "milk", self() }
    assert_receive { :ok, nil }
  end

  test "stops the agent", %{ bucket: bucket } do
    assert Process.alive?(bucket) == true
    send bucket, { :stop }
    Process.sleep(500)
    assert Process.alive?(bucket) == false
  end
end
