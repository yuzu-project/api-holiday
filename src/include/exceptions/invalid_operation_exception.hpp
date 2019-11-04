#include <exception>

namespace yuzup {
namespace calendar {
namespace exceptions {
class invalid_operation_exception : public std::exception {
 public:
  virtual const char* what(void) const throw();
};
}  // namespace exceptions
}  // namespace calendar
}  // namespace yuzup
