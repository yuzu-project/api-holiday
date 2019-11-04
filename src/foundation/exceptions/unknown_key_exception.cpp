#include "exceptions/unknown_key_exception.hpp"

namespace yce = yuzup::calendar::exceptions;

const char* yce::unknown_key_exception::what(void) const throw() {
  return "There is no such key in this dictionary.";
}
