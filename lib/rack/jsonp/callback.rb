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

          # Fix content length if present
          content_length = headers["Content-Length"].to_i

          if content_length > 0
            @pre, @post = "#{callback}(", ")" 
            headers["Content-Length"] = (@pre.size + content_length + @post.size).to_s
            headers["Content-Type"]   = "application/javascript" # Set proper content type as per RFC4329
            [200, headers, self] # Override status
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
