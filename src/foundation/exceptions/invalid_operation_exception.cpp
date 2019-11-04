#include "exceptions/invalid_operation_exception.hpp"

namespace yce = yuzup::calendar::exceptions;

const char* yce::invalid_operation_exception::what(void) const throw() {
  return "Cannot run such operation in the current context.";
}
