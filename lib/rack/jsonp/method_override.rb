module Rack
  module JSONP

    class MethodOverride
      def initialize(app, method_param = "_method")
        @app, @method_param = app, method_param
      end

      def call(env)
        if env["jsonp.callback"] && method = Rack::Request.new(env).params[@method_param]
          method.upcase!
          env["REQUEST_METHOD"] = %w(GET HEAD PUT POST DELETE OPTIONS).include?(method) ? method : "GET"
        end

        @app.call(env)
      end
    end

  end
end
