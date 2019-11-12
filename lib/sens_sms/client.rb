module SensSms
  class Client
    attr_reader :status, :errors, :request_time

    def initialize(opts = {})
      @access_key = opts[:access_key]
      @secret_key = opts[:secret_key]
      @service_id = opts[:service_id]
    end

    def send_sms(sender_number:, receiver_number:, message:)
      @timestamp = DateTime.current.strftime('%Q')
      response = HTTP.headers(ncloud_sens_api_header)
                     .post(ncloud_sens_api_url,
                           json: { type: 'SMS',
                                   contentType: 'COMM',
                                   countryCode: '82',
                                   from: sender_number,
                                   content: message,
                                   messages: [{ to: receiver_number }] })
      @status = response.status
      if response.status.success?
        @request_time = Time.zone.parse(response.parse['requestTime'])
        true
      else
        @errors = response.parse['errors'] if response.parse['errors'].present?
        @errors = [response.parse['error']['message']] if response.parse['error'].present?
        false
      end
    end

    private

    def ncloud_sens_api_url
      @ncloud_sens_api_url ||= "https://sens.apigw.ntruss.com/sms/v2/services/#{@service_id}/messages"
    end

    def ncloud_sens_api_header
      { 'Content-Type': 'application/json; charset=utf-8',
        'x-ncp-apigw-timestamp': @timestamp,
        'x-ncp-apigw-signature-v2': signature,
        'x-ncp-iam-access-key': @access_key }
    end

    def signature
      sms_uri = "/sms/v2/services/#{@service_id}/messages".freeze
      data = "POST #{sms_uri}\n#{@timestamp}\n#{@access_key}".freeze

      Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), @secret_key, data)).strip
    end
  end
end
