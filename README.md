# Key-Value store evolution in Elixir

This repo contains a key-value store implemented in:

* bare metal elixir (`send`, `receive`) -> `bucket_plain.ex`
* using Agent -> `bucket_agent.ex`
* using GenServer -> `bucket_gen_server.ex`



## Disclaimer

This examples have been used for our [in office hands-on session about Elixir](https://torinocodingsociety.it/events/tcs-handson-elixir-10-maggio/). This is not a production ready code!



## Examples

### Bare metal

```elixir
$ iex -S mix
iex(1)> { :ok, bucket } = KV.BucketPlain.start_link()
{:ok, #PID<0.157.0>}
iex(2)> KV.BucketPlain.put(bucket, "eggs", 6)
:ok
iex(3)> KV.BucketPlain.get(bucket, "eggs")
6
```

### Agent

```elixir
$ iex -S mix
iex(1)> {:ok, bucket} = KV.BucketAgent.start_link()
{:ok, #PID<0.164.0>}
iex(2)> KV.BucketAgent.put(bucket, "eggs", 6)
:ok
iex(3)> KV.BucketAgent.get(bucket, "eggs")
6
```

### GenServer

[Cheat Sheet](https://raw.githubusercontent.com/benjamintanweihao/elixir-cheatsheets/master/GenServer_CheatSheet.pdf)

```elixir
$ iex -S mix
iex(1)> {:ok, bucket} = KV.BucketGenServer.start_link()
{:ok, #PID<0.168.0>}
iex(2)> KV.BucketGenServer.put(bucket, "eggs", 6)
:ok
iex(3)> KV.BucketGenServer.get(bucket, "eggs")
6
```



## Test

To run tests:

```bash
$ mix test
```



## Author

made with ❤️ and ☕️ by [weLaika](https://dev.welaika.com)



## License

(The MIT License)

Copyright © 2013-2018 weLaika

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.