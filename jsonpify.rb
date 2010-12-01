get '/' do
  if params['resource']
    content_type :json
    httparty_error = {"error" => "HTTParty Error!"}.to_json
    return {"error" => "You must specify a callback parameter for JSONP"}.to_json unless params['callback']
    resource = params.delete('resource')
    callback = params.delete('callback')
    response = HTTParty.get(resource, :query => params) rescue httparty_error
    response = response.parsed_response rescue httparty_error
    return "#{callback}(#{response.to_json})"
  else
    haml :index
  end
end

get '/html' do
  if params['resource']
    content_type 'text/html'
    httparty_error = "HTTParty Error!"
    resource = params.delete('resource')
    response = HTTParty.get(resource, :query => params) rescue httparty_error
    return response.parsed_response rescue httparty_error
  end
end