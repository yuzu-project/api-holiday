#include <cpprest/http_listener.h>
#include <pplx/pplxtasks.h>
#include <string>

namespace yuzup
{
  namespace calendar
  {
    class api_service
    {
    public:
      api_service();
      ~api_service();
      api_service(const api_service&) = delete;

      pplx::task<void> start();
      pplx::task<void> stop();
    protected:
      web::http::experimental::listener::http_listener listener_;
    };
  } // namespace calendar  
} // namespace yuzup
