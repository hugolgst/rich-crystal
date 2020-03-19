# rich-crystal ![https://travis-ci.org/hugolgst/rich-crystal](https://api.travis-ci.org/hugolgst/rich-crystal.svg?branch=master)

Crystal extension for Discord Rich Presence

## Installation

Add this to your application's `shard.yml`:

```yml
dependencies:
  rich-crystal:
    github: hugolgst/rich-crystal
```

## Usage

You must create a Client with your Discord Rich Presence application id :
```crystal
client = RichCrystal::Client.new(174839413294239_u64)
```

Then by calling login you send the first handshake :
```crystal
client.login
```

And you can set the Rich Presence activity (parameters can be found [here](https://github.com/discordapp/discord-rpc/blob/master/documentation/hard-mode.md#new-rpc-command) :
```crystal
client.activity({
  state => "Running on Crystal",
  details => "Heyyyy",
})
```

## Contributing

1. Fork it (https://github.com/hugolgst/rich-crystal/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [hugolgst](https://github.com/hugolgst) - creator, maintainer
