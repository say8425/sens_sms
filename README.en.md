# Ncloud Sens SMS Gem

[![gem version](https://img.shields.io/gem/v/sens_sms?color=cc342d&logo=ruby&logoColor=cc342d)](https://rubygems.org/gems/sens_sms)
[![GitHub Actions Test](https://github.com/say8425/sens_sms/workflows/Test/badge.svg)](https://github.com/say8425/sens_sms/actions?query=workflow%3ATest)
[![GitHub Actions Release](https://github.com/say8425/sens_sms/workflows/Release/badge.svg)](https://github.com/say8425/sens_sms/actions?query=workflow%3ARelease)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/say8425/sens_sms/blob/master/LICENSE)

Send your SMS with [Ncloud Sens](https://www.ncloud.com/product/applicationService/sens) in Ruby.

한국어 문서를 읽고싶다면, [여기](https://github.com/say8425/sens_sms/blob/master/README.ko.md)를 클릭하세요

## Installation

### Rails

Add this line to your application's Gemfile:

```ruby
gem 'sens_sms'
```

Then execute:

```shell script
$ bundle
```

Finally, run the generator:

```shell script
$ rails generate sens_sms:install
```

At this point, you can find a sens_sms configuration file located at `YOUR_PROJECT/config/initializers/sens_sms.rb`.

```ruby
require 'sens_sms'

SensSms::Client.configure do |config|
  config.access_key = ENV['NCLOUD_ACCESS_KEY']
  config.secret_key = ENV['NCLOUD_SECRET_KEY']
  config.service_id = ENV['NCLOUD_SERVICE_ID']
end
```

You can set your Ncloud access keys here, but we recommend to use Environment Values.
Generating access keys guide is [here](https://docs.ncloud.com/en/sens/sens-1-2.html).

### Sinatra or Plain ol' Ruby

Install the gem:

```shell script
$ gem install sens_sms
```

If you plan to use sens_sms gem in plain Ruby project,
then you should call `require 'sens_sms'` and `SensSms::Client.configure` block
to set access keys before calling `deliver` method like rails generator do it.

## Usage

```ruby
# SMS
SensSms::Client.new
               .deliver(type: :sms,
                        from_number: '01012345678',
                        to_numbers: '01098765432',
                        message: '전 세계에 알려진 펭귄의 종류는 17종 혹은 18종이다.')
```

```ruby
# LMS
SensSms::Client.new
               .deliver(type: :lms,
                        from_number: '01012345678',
                        to_numbers: '01098765432',
                        title: '펭귄',
                        message: '전 세계에 알려진 펭귄의 종류는 17종 혹은 18종이다. (쇠푸른펭귄과 흰날개펭귄이
                                  식별되는지 아닌지에 따라 달라진다.) 모든 펭귄 종의 고향이 남반구이기는 하지만,
                                  통념과 달리, 남극과 같이 추운 기후에서만 서식하지는 않는다. 실제로는 몇몇 종만이
                                  극지방에 산다. 3종은 열대 지방에 살며, 그 가운데 갈라파고스 제도에 사는 한 종은 먹이를
                                  찾다가 적도를 건너기도 한다. 가장 큰 종은 황제펭귄으로, 다 자라면 키가 약 1.1미터,
                                  무게가 약 35킬로그램 이상이다. 가장 작은 종은 쇠푸른펭귄으로, 키는 약 40센티미터에
                                  몸무게가 1킬로그램에 불과하다. 일반적으로 펭귄은 덩치가 클수록 열을 잘 보관해서
                                  추운 지방에 살고, 작은 펭귄들은 온대나 심지어 열대에서 발견된다.')
```

After calling configure method, use `SensSms::Client.new.deliver` with below arguments.

### From Number

You can use `from_number` key to set sender number [registered at Ncloud SENS console](https://docs.ncloud.com/en/sens/sens-1-3.html#register-view-caller-id).

### To Number

You can use `to_numbers` key to set receiver number.
Also `to_numbers` can be set multiple numbers with Array type. (eg. `['01012345678', '01009876543']` )

### Type

You can use `type` key to choose message type.

#### [SMS Type](https://docs.ncloud.com/en/sens/sens-1-3.html#send-sms-messages)

SMS can send short message with up to 80 bytes and this type cannot use title.
However, sending title key will do not raise any error, it'll be just ignored.

#### [LMS Type](https://docs.ncloud.com/en/sens/sens-1-3.html#send-lms-messages)

LMS type can send title and super long text message with up to 2,000 bytes.

### Title

Basically, This key is optional used by LMS message type for title.
Of course, this key can be used in SMS message type, but nothing will be happened.

### Message

Text message.

## Contributing

Bug reports and pull requests are welcome.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
