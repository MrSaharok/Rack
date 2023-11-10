require './time'

class RunTime

  def call(env)
    response = Rack::Request.new(env)
    time = TimeService.new(response)
    if time.errors.empty?
      answer(time.parse, 200)
    else
      answer(time.errors, 400)
    end
  end

  private

  def answer(body, status)
    Rack::Response.new(body, status).finish
  end
end
