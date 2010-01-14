require "rack/jsonp/utils"

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
        
          # Remove callback param and value from query string
          Utils.remove_param(env, @callback_param)
          

          # Call original app
          status, headers, body = @app.call(env)

          # Wrap body with callback
          pre, post = "#{callback}(", ")" 
          body = Wrapper.new(pre, body, post)

          # Fix content length if present
          if content_length = headers["Content-Length"]
            headers["Content-Length"] = (pre.size + content_length.to_i + post.size).to_s
          end

          # Set proper content type as per RFC4329
          headers["Content-Type"] = "application/javascript"

          [status, headers, body]
        else
          @app.call(env)
        end
      end

      private

      class Wrapper
        def initialize(pre, body, post)
          @pre, @body, @post = pre, body, post
        end

        def each(&block)
          block.call(@pre)
          @body.each(&block)
          block.call(@post)
        end
      end
    
    end


  end
end
