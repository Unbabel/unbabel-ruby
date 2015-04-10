usage
-----

Add the following to your Gemfile:

```ruby
gem 'unbabel-ruby', github: 'Unbabel/unbabel-ruby', require: 'unbabel'
```

Then, you can make translation request like:

```ruby
unbabel_client = Unbabel.new(username, apikey)
response = unbabel_client.post_translations(
  Unbabel::Translation.new('This is some test.', 'nl')
)
```

or make bulk the translations:

```ruby
unbabel_client = Unbabel.new(username, apikey)
response = unbabel_client.bulk_translations(
  Unbabel::Translation.from_hash(
    text: 'This is some test.',
    target_language: 'nl'
  ),
  Unbabel::Translation.from_hash(
    text: 'Some more test.',
    target_language: 'nl'
  )
)
```

More info
---------

https://github.com/Unbabel/unbabel_api
http://developers.unbabel.com/v2/docs