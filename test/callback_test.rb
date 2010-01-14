require "test_helper"
require "rack/jsonp/callback"
 
class CallbackTest < Test::Unit::TestCase
  def setup
    @status  = 200
    @headers = { "Content-Type" => "application/json", "Content-Length" => "2" }
    @body    = "{}"
  end
  
  test "doesn't change anything when callback is missing" do
    env = Rack::MockRequest.env_for("/")
    app = Rack::JSONP::Callback.new(lambda { |env| [@status, @headers, [@body]] })

    status, headers, iterable = app.call(env)
    body = ""; iterable.each { |l| body << l }

    assert_equal @status, status
    assert_equal @headers, headers
    assert_equal @body, body
  end
  
  test "wraps response with callback and updates headers" do
    env = Rack::MockRequest.env_for("/?_callback=callback")
    app = Rack::JSONP::Callback.new(lambda { |env| [@status, @headers, [@body]] })

    status, headers, iterable = app.call(env)
    body = ""; iterable.each { |l| body << l }

    expected_body = "callback(#{@body})"

    assert_equal @status, status
    assert_equal @headers, { 
      "Content-Type"   => "application/javascript", 
      "Content-Length" => expected_body.size.to_s 
    }
    assert_equal expected_body, body
  end
end
