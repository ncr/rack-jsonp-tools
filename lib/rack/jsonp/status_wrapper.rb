module Rack
  module JSONP
  
    class StatusWrapper
      def initialize(app)
        @app = app
      end
      
      def call(env)
        if env["jsonp.callback"]
          # Call original app
          status, headers, @body = @app.call(env)

          if headers["Content-Type"] == "application/json"
            @pre, @post = '{"body": ', ', "status": ' + status.to_s + '}'
            headers["Content-Length"] = (@pre.size + headers["Content-Length"].to_i + @post.size).to_s
            [status, headers, self]
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
