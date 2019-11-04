#include <cpprest/http_listener.h>
#include <string>

namespace yuzup {
namespace calendar {
class api_request {
 public:
  api_request(web::http::http_request& request);
  ~api_request(void);

  void add_query_value(const std::string& key, const std::string& value);
  void remove_query_value(const std::string& key);
  void append_tag(const std::string& key, void const* value);
  void remove_tag(const std::string& key);
  void sink(void);

  bool has_sunk(void) const;
  web::http::http_request& request(void) const;
  void const* tag(const std::string& key) const;
  bool exists_tag(const std::string& key) const;
  std::string query(const std::string& key) const;
  bool exists_query_value(const std::string& key) const;

 private:
  class pimpl;
  pimpl& pimpl_;
};
}  // namespace calendar
}  // namespace yuzup