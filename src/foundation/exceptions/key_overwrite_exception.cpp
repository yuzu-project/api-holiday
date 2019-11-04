#include "exceptions/key_overwrite_exception.hpp"

namespace yce = yuzup::calendar::exceptions;

const char* yce::key_overwrite_exception::what(void) const throw() {
  return "Cannot reassign a value to an existing key.";
}
