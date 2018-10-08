# frozen_string_literal: true

require 'spec_helper'

describe Unbabel do
  let(:username) { 'john doe' }
  let(:apikey) { 'fakekey' }
  let(:headers) do
    {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization' => "ApiKey #{username}:#{apikey}",
      'Content-Type' => 'application/json',
      'User-Agent' => 'Faraday v0.15.3'
    }
  end

  subject(:api) { described_class.new(username, apikey, sandbox) }

  describe '#post_translations' do
    let(:expected_post_body) do
      {
        "text": 'This is a test translation',
        "target_language": 'pt',
        "source_language": 'en',
        "type": nil,
        "tone": nil,
        "visibility": nil,
        "public_url": nil,
        "callback_url": nil,
        "topics": [],
        "instructions": nil,
        "uid": nil,
        "text_format": 'text',
        "target_text": nil,
        "origin": nil
      }
    end

    context 'When request sandbox api' do
      let(:sandbox) { true }

      it 'creates a new translation order' do
        stub_request(:post, 'https://sandbox.unbabel.com/tapi/v2/translation/')
          .with(body: expected_post_body, headers: headers)
          .to_return(status: 200, body: '', headers: {})

        api.post_translations('This is a test translation',
                              target_language: 'pt', source_language: 'en')
      end
    end

    context 'When request production api' do
      let(:sandbox) { false }

      it 'creates a new translation order' do
        stub_request(:post, 'https://unbabel.com/tapi/v2/translation/')
          .with(body: expected_post_body, headers: headers)
          .to_return(status: 200, body: '', headers: {})

        api.post_translations('This is a test translation',
                              target_language: 'pt', source_language: 'en')
      end
    end
  end

  describe '#query_translation' do
    let(:uuid) { '1234' }

    context 'When request sandbox api' do
      let(:sandbox) { true }

      it 'gets translation order' do
        url = "https://sandbox.unbabel.com/tapi/v2/translation/#{uuid}/"
        stub_request(:get, url)
          .with(headers: headers).to_return(status: 200, body: '', headers: {})

        api.query_translation(uuid)
      end
    end

    context 'When request production api' do
      let(:sandbox) { false }

      it 'gets translation order' do
        stub_request(:get, "https://unbabel.com/tapi/v2/translation/#{uuid}/")
          .with(headers: headers).to_return(status: 200, body: '', headers: {})

        api.query_translation(uuid)
      end
    end
  end

  describe '#api_call' do
    context 'When request sandbox api' do
      let(:sandbox) { true }

      it 'gets a list of machine translations' do
        stub_request(:get, 'https://sandbox.unbabel.com/tapi/v2/mt_translation/')
          .with(headers: headers).to_return(status: 200, body: '', headers: {})

        api.api_call('mt_translation/')
      end
    end

    context 'When request production api' do
      let(:sandbox) { false }

      it 'gets a list of machine translations' do
        stub_request(:get, 'https://unbabel.com/tapi/v2/mt_translation/')
          .with(headers: headers).to_return(status: 200, body: '', headers: {})

        api.api_call('mt_translation/')
      end
    end

    context 'when method not allowed' do
      let(:sandbox) { false }

      it 'raises an error' do
        expect { api.api_call('mt_translation/', method: 'put') }
          .to raise_error(RuntimeError, 'Method: put not allowed')
      end
    end
  end
end
