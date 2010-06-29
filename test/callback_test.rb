require "test_helper"
require "rack/jsonp/callback"
 
class CallbackTest < Test::Unit::TestCase
  def setup
    @status  = 201
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

    assert_equal 200, status
    assert_equal @headers, { 
      "Content-Type"   => "application/javascript", 
      "Content-Length" => expected_body.size.to_s 
    }
    assert_equal expected_body, body
  end
  
  test "doesn't touch response if content type is not application/json" do
    env = Rack::MockRequest.env_for("/?_callback=callback")
    app = Rack::JSONP::Callback.new(lambda { |env| [301, {}, [""]] })

    status, headers, iterable = app.call(env)
    body = ""; iterable.each { |l| body << l }

    assert_equal 301, status
    assert_equal Hash.new, headers
    assert_equal "", body
  end
end
