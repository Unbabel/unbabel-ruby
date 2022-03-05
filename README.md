# Unbabel Ruby SDK

[![Project Status: Abandoned – Initial development has started, but there has not yet been a stable, usable release; the project has been abandoned and the author(s) do not intend on continuing development.](https://www.repostatus.org/badges/latest/abandoned.svg)](https://www.repostatus.org/#abandoned)


Ruby SDK for the Unbabel REST API

## Documentation:
Please visit our documentation page at https://developers.unbabel.com/


## Installation
`gem install unbabel-ruby`


## Getting started:
```
require 'unbabel_sdk'

username = ENV['UNBABEL_TEST_USER']
apikey = ENV['UNBABEL_API_KEY']

api = Unbabel.new(username, apikey)
api.post_translations('This is a test translation', target_language: 'pt', source_language: 'en')
```
