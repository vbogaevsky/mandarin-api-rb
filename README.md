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
MandarinApi.assign_card user, urls
```
`user` should be an instance or a Struct, and should respond to `#email` and `#phone` methods
`#phone` should be serialized, for example '+79091234567' is correctly serialized number.
`urls` is a hash that passes callback and redirect URLs:
```ruby
  {
    return: 'https://www.your-page-to-return-user-to.com',
    callback: 'https:/www.your-endpoint-for-callbacks.com'
  }
```
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



###**Example of oneway card binding:**
```ruby
MandarinApi.oneway_assign_card user, card_number
```
`user` should be an instance or a Struct, and should respond to `#email` and `#phone` methods
`#phone` should be serialized, for example '+79091234567' is correctly serialized number.
`#assign_card` will return a hash.
###**Example:**
```ruby
{
  'id' => '0eb51e74-e704-4c36-b5cb-8f0227621518',
}
```
Keep id, it will be used for pay/payouts requests. Use userWebLink to redirect user to Mandarin page for card data input.
Oneway binded card can only be used for payouts.



###**Example of performing payment:**
```ruby
# order_id - id of order/bill, etc. in your system.
# amount - sum of payout
# assigned_card_uuid - the id you received assigning the card
# extra - an array of hashes to keep your additional data
MandarinApi.payment(order_id, amount, assigned_card_uuid, extra)
```
`#payment` will return a hash with transaction id.
###**Example:**
```ruby
{ 'id' => '721a5185314740aaa304278fb1d8ee63' }
```



###**Example of performing payout:**
```ruby
# order_id - id of order/bill, etc. in your system.
# amount - sum of payout
# assigned_card_uuid - the id you received assigning the card
# extra - an array of hashes to keep your additional data
MandarinApi.payout(order_id, amount, assigned_card_uuid, extra)
```
`#payout` will return a hash with transaction id.
###**Example:**
```ruby
{ 'id' => '721a5185314740aaa304278fb1d8ee63' }
```



###**Example of charging user without card binding**
```ruby
# order_id - id of order/bill, etc. in your system.
# amount - sum of payout
MandarinApi.charge(order_id, amount, user, optional)
```
`user` should be an instance or a Struct, and should respond to `#email` and `#phone` methods
`#phone` should be serialized, for example '+79091234567' is correctly serialized number.
`optional` is an hash to keep URLs, data visible on Mandarin page, and your technical data:
```ruby
{
  urls: {
    return: 'https://www.your-page-to-return-user-to.com',
    callback: 'https:/www.your-endpoint-for-callbacks.com'
  },
  custom_values: [
    { name: 'A name for value', value: 'This value will be visible during payment process on Mandarin page and return in callback' },
    { name: 'Another value name', value: 'another value' }
  ]
}
```
`#charge` will return a hash.
###**Example:**
```ruby
{
  "id": "43913ddc000c4d3990fddbd3980c1725",
  "userWebLink": "https://secure.mandarinpay.com/Pay' \
    '?transaction=0eb51e74-e704-4c36-b5cb-8f0227621518"
}
```



###**Example of performing refund:**
```ruby
# order_id - id of order/bill, etc. in your system.
# transaction_uuid - the uuid you received performing transaction
MandarinApi.refund(order_id, transaction_uuid)
```
`#refund` will return a hash with transaction id.
###**Example:**
```ruby
{ 'id' => '721a5185314740aaa304278fb1d8ee63' }
```



###**Example of performing rebill:**
```ruby
# order_id - id of order/bill, etc. in your system.
# amount - sum of payment
# transaction_uuid - the uuid you received performing transaction
MandarinApi.rebill(order_id, amount, transaction_uuid)
```
`#rebill` will return a hash with transaction id.
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
