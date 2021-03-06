defmodule KV.BucketTest do
  use ExUnit.Case, async: true
  
  setup do
    {:ok, bucket} = KV.Bucket.start_link
    {:ok, bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes pairs", %{bucket: bucket} do
    KV.Bucket.put(bucket, "eggs", "green")
    assert KV.Bucket.delete(bucket, "eggs") == "green"
    assert KV.Bucket.get(bucket, "egges") == nil
  end
end
