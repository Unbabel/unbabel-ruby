load "lib/unbabel.rb"

username = ENV['UNBABEL_TEST_USER']
apikey = ENV['UNBABEL_API_KEY']
ub = Unbabel.new(username, apikey)
response = ub.post_translations('This is some test.', 'pt', source_language: 'en')


