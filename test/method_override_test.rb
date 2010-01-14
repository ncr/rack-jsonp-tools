require "test_helper"
require "rack/jsonp/method_override"
 
class CallbackTest < Test::Unit::TestCase
  
  test "doesn't change anything when method is missing" do
    env = Rack::MockRequest.env_for("/?_method=post", :method => "GET", "jsonp.callback" => true)
    app = Rack::JSONP::MethodOverride.new(lambda { |env| Rack::Request.new(env) })
    req = app.call(env)
 
    assert_equal "POST", req.env["REQUEST_METHOD"]
  end
end
