#include <cpprest/http_listener.h>
#include <pplx/pplxtasks.h>
#include <string>

namespace yuzup {
namespace calendar {
class rest_controller {
 public:
  rest_controller();
  ~rest_controller();
  rest_controller(const rest_controller&) = delete;

  pplx::task<void> start();
  pplx::task<void> stop();

 protected:
  web::http::experimental::listener::http_listener listener_;
  virtual void register_verbs() = 0;
};
}  // namespace calendar
}  // namespace yuzup
