class MessageService
  def initialize(message)
    @message = message
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end

  def call
    url = 'https://sentim-api.herokuapp.com/api/v1/'
    result = post(url)
    response(result)
  end

  def post(url)
    HTTParty.post(url,
                  body: { 'text' => @message }.to_json,
                  headers: { 'Content-type' => 'application/json',
                             'Accept' => 'application/json' })
  end

  def response(result)
    if result.code == 200
      JSON.parse(result.body)['result']['type']
    else
      'API failed, try again later'
    end
  end
end
