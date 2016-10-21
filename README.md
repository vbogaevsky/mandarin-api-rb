# mandarin-api-rb
[![CodeClimate](https://codeclimate.com/github/vbogaevsky/mandarin-api-rb/badges/gpa.svg)](https://codeclimate.com/github/vbogaevsky/mandarin-api-rb)

mandarinpay.com api wrapper for ruby
**mandarin-api** provides necessary API to interact with **Mandarin**.
##**Usage:**
To use mandarin-api you will need to specify config file with `merchant_id`, `secret`, and `request_url`.
###**Example of config:**
```ruby
MandarinApi.configure do |config|
  config.merchant_id = 123
  config.secret = 'secret'
  config.request_url = 'https://secure.mandarinpay.com'
end
```
###**Example of assigning a card:**
```ruby
MandarinApi.assign_card user
```
`user` should be an instance or a Struct, and should respond to `#email` and `#phone` methods
`#phone` should be serialized, for example '+79091234567' is correctly serialized number.
`#assign_card` will return a hash.
###**Example:**
```ruby
{
  'id' => '0eb51e74-e704-4c36-b5cb-8f0227621518',
  'userWebLink' => "https://secure.mandarinpay.com/CardBindings/New?' \
    'id=0eb51e74-e704-4c36-b5cb-8f0227621518"
}
```
Keep id, it will be used for pay/payouts requests. Use userWebLink to redirect user to Mandarin page for card data input.

###**Example of performing payout:**
```ruby
# order_id - id of order/bill, etc. in your system.
# amount - sum of payout
# assigned_card_uuid - the id you received assigning the card
MandarinApi.payout(order_id, amount, assigned_card_uuid)
```
#payout will return a hash with transaction id.
###**Example:**
```ruby
{ 'id' => '721a5185314740aaa304278fb1d8ee63' }
```
You will have to provide a link to receive callbacks from Mandarin.
MandarinApi.process_callback takes as arguments body of a callback serialized
to hash with symbolized keys and an instance with `#success` and `#failure` methods,
`#success` and `#failure` methods should take hash with symbolized keys as an argument.
###**Example:**
```ruby
class Application
  def assign_card(user)
    MandarinApi.assign_card(user)
  end
  def transit(request)
    MandarinApi.process_callback(request, ResponseHandler.new)
  end
end
class ResponseHandler
  def success(result)
    # your code here
  end
  def failure(result)
    # your code here
  end
end
```
