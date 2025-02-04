module SensSms
  class Client
    attr_reader :response, :status, :errors, :request_time, :timestamp

    def initialize
      raise 'Configure is not valid.' unless validate_configure
    end

    def deliver(type:, from_number:, to_numbers:, subject: nil, message:)
      raise "Invalid message type: #{type}" unless %i[sms lms].include? type.to_sym

      @timestamp = current_timestamp
      @response = HTTP.headers(ncloud_sens_api_header)
                      .post(ncloud_sens_api_url,
                            json: { type: type.to_sym,
                                    contentType: :COMM,
                                    countryCode: '82',
                                    from: from_number,
                                    subject: subject,
                                    content: message,
                                    messages: parsed_messages(to_numbers) })
      @status = response.status
      parse_response
    end

    def self.configure
      yield configuration
      @@access_key = @configuration.access_key
      @@service_id = @configuration.service_id
      @@secret_key = @configuration.secret_key
    end

    def self.configuration
      @configuration ||= SensSms::Configure.new
    end

    private

    include Configuration
    include Configuration::Validate

    def parse_response
      if status.success?
        @request_time = Time.parse(response.parse['requestTime'])
      else
        parse_errors
      end
      status.success?
    end

    def parse_errors
      @errors = response.parse['errors'] if response.parse.key? 'errors'
      @errors = [response.parse['error']['message']] if response.parse.key? 'error'
    end

    def current_timestamp
      (Time.now.to_f.round(3) * 1000).to_i
    end

    def ncloud_sens_api_url
      @ncloud_sens_api_url ||= "https://sens.apigw.ntruss.com/sms/v2/services/#{service_id}/messages"
    end

    def ncloud_sens_api_header
      { 'Content-Type': 'application/json; charset=utf-8',
        'x-ncp-apigw-timestamp': @timestamp,
        'x-ncp-apigw-signature-v2': signature,
        'x-ncp-iam-access-key': access_key }
    end

    def signature
      sms_uri = "/sms/v2/services/#{service_id}/messages".freeze
      data = "POST #{sms_uri}\n#{@timestamp}\n#{access_key}".freeze

      Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), secret_key, data)).strip
    end

    def parsed_messages(to_numbers)
      Array(to_numbers).map { |to_number| { to: to_number } }
    end
  end
end
