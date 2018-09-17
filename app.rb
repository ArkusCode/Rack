require_relative 'format'

class App

  def call(env)
    @request = Rack::Request.new(env)

    if (@request.path_info == '/time') && (!@request.params['format'].nil?)
      time_response(@request.params)
    else
      response(404, headers, "Time format not found\n")
    end
  end

  private

  def time_response(params)
    format = Format.new(params)

    if format.success?
      response(200, headers, format.time)
    else
      response(400, headers, "Unknown time format #{format.unknown.join(', ')}\n")
    end
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def response(status, headers, body)
    [status, headers, [body]]
  end
end
