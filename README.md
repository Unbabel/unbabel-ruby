# Unbabel Ruby bindings

## Installation
```shell
gem install unbabel-ruby
```

## Requirements
- ruby 2.2 or later
- rake, faraday, json

## Configuration

```ruby
Unbabel.configure do |config|
  config.api_key = ENV['UNBABEL_API_KEY']
  config.username = ENV['UNBABEL_USERNAME']
  config.sandbox = false
end
```

Or when you call method:

```ruby
Unbabel::Language.new(api_key: 'your api key', username: 'your username', sandbox: false)
```

## Usage

```ruby
Unbabel::Language.new.language_pair
#=> return JSON object
```
