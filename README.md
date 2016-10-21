# mandarin-api-rb
mandarinpay.com api wrapper for ruby

**bold**mandarin-api**bold** provides necessary API to interact with **bold**Mandarin**bold**.
##**bold**Usage:**bold**
To use mandarin-api you will need to specify config file with merchant_id, secret, and request_url.
###**bold**Example of config:**bold**
```
MandarinApi.configure do |config|
  config.merchant_id = 123
  config.secret = 'secret'
  config.request_url = 'https://secure.mandarinpay.com'
end
```
###**bold**Example of assigning a card:**bold**
MandarinApi.assign_card user # user should be an instance or a Struct, and should respond to #email and #phone methods
#phone should be serialized, for example '+79091234567' is correctly serialized number.
#assign_card will return a hash.
###**bold**Example:**bold**
```
{
  'id' => '0eb51e74-e704-4c36-b5cb-8f0227621518',
  'userWebLink' => "https://secure.mandarinpay.com/CardBindings/New?' \
    'id=0eb51e74-e704-4c36-b5cb-8f0227621518"
}
```
**bold**Keep id, it will be used for pay/payouts requests. Use userWebLink to redirect user to Mandarin page for card data input.**bold**

###**bold**Example of performing payout:**bold**
```
# order_id - id of order/bill, etc. in your system.
# amount - sum of payout
# assigned_card_uuid - the id you received assigning the card
MandarinApi.payout(order_id, amount, assigned_card_uuid)
```
#payout will return a hash with transaction id.
###**bold**Example:**bold**
```
{ 'id' => '721a5185314740aaa304278fb1d8ee63' }
```
You will have to provide a link to receive callbacks from Mandarin.
MandarinApi.process_callback takes as arguments body of a callback serialized
to hash with symbolized keys and an instance with #success and #failure methods,
#success and #failure methods should take hash with symbolized keys as an argument.
###**bold**Example:**bold**
```
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
