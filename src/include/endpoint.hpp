#include <string>
#include "http_handler.hpp"
#include "middleware.hpp"

namespace yuzup {
namespace calendar {
class endpoint {
 public:
  endpoint(void);
  ~endpoint(void);
  void register_service(const std::string& path, http_handler& handler);
  void add_middleware(const std::string& path, const middleware& middleware);

 private:
  class pimpl;
  pimpl& pimpl_;
};
}  // namespace calendar
}  // namespace yuzup
