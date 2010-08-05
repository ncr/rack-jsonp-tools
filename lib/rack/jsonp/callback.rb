module Rack
  module JSONP
  
    class Callback
      def initialize(app, callback_param = "_callback")
        @app, @callback_param = app, callback_param
      end

      def call(env)
        request = Rack::Request.new(env)
      
        if callback = request.params[@callback_param]
          # Save for underlying middlewares
          env["jsonp.callback"] = callback

          # Call original app
          status, headers, @body = @app.call(env)
          if headers["Content-Type"].to_s.start_with?("application/json")
            @pre, @post = "#{callback}(", ")"
            headers["Content-Length"] = (@pre.size + headers["Content-Length"].to_i + @post.size).to_s if headers["Content-Length"]
            headers["Content-Type"]   = "application/javascript" # Set proper content type as per RFC4329
            [200, headers, self]
          else
            [status, headers, @body]
          end
        else
          @app.call(env)
        end
      end
      
      def each(&block)
        block.call(@pre)
        @body.each(&block)
        block.call(@post)
      end
    end
  end
end
