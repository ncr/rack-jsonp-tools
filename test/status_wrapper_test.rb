require "test_helper"
require "rack/jsonp/status_wrapper"
 
class StatusWrapperTest < Test::Unit::TestCase
  def setup
    @status  = 201
    @body    = "{ number: 666 }"
    @headers = { "Content-Type" => "application/json", "Content-Length" => @body.size }
  end
  
  def app
    app = Rack::Builder.new # instance_eval fail
    app.use Rack::JSONP::Callback
    app.use Rack::JSONP::StatusWrapper
    app.run lambda { |env| [@status, @headers, [@body]] }
    app
  end
  
  test "doesn't change anything when callback is missing" do
    env = Rack::MockRequest.env_for("/")

    status, headers, iterable = app.call(env)
    body = ""; iterable.each { |l| body << l }

    assert_equal @status, status
    assert_equal @headers, headers
    assert_equal @body, body
  end
  
  test "wraps response with status and updates headers" do
    env = Rack::MockRequest.env_for("/?_callback=callback")

    status, headers, iterable = app.call(env)
    body = ""; iterable.each { |l| body << l }

    expected_body = 'callback({"body":' + @body + ', "status":' + @status.to_s + '})'

    assert_equal 200, status
    assert_equal @headers, { 
      "Content-Type"   => "application/javascript", 
      "Content-Length" => expected_body.size.to_s 
    }
    assert_equal expected_body, body
  end
end
