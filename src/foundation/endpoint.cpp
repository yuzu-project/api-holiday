#include "endpoint.hpp"
#include <boost/property_tree/ptree.hpp>

namespace yc = yuzup::calendar;

class yc::endpoint::pimpl {
 public:
  boost::property_tree::ptree endpoints_;

  pimpl(void);
  ~pimpl(void);
};

yc::endpoint::endpoint(void) : pimpl_(*new pimpl()) {
  // nothing to do here
}

yc::endpoint::~endpoint(void) {
  delete &pimpl_;
}

void yc::endpoint::register_service(const std::string& path, http_handler& handler) {}
