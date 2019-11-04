#include "api_request.hpp"
#include <map>
#include "exceptions/invalid_operation_exception.hpp"
#include "exceptions/key_overwrite_exception.hpp"
#include "exceptions/unknown_key_exception.hpp"

namespace yc = yuzup::calendar;
using namespace yc::exceptions;

class yc::api_request::pimpl {
 public:
  typedef std::map<std::string, void const*> dictionary;
  typedef std::map<std::string, std::string> query_values;

  bool has_sunk;
  bool is_navigating;
  dictionary dict;
  query_values query;
  web::http::http_request& request;

  pimpl(web::http::http_request& req) : has_sunk(false), is_navigating(true), request(req) {}
};

yc::api_request::api_request(web::http::http_request& request) : pimpl_(*new pimpl(request)) {}

yc::api_request::~api_request(void) {
  delete &pimpl_;
}

void yc::api_request::append_tag(const std::string& key, void const* value) {
  if (!pimpl_.is_navigating) {
    throw invalid_operation_exception();
  }
  if (pimpl_.dict.count(key)) {
    throw key_overwrite_exception();
  }
  pimpl_.dict[key] = value;
}

void yc::api_request::remove_tag(const std::string& key) {
  if (!pimpl_.is_navigating) {
    throw invalid_operation_exception();
  }
  if (!pimpl_.dict.count(key)) {
    throw unknown_key_exception();
  }
  pimpl_.dict.erase(key);
}

void yc::api_request::add_query_value(const std::string& key, const std::string& value) {
  if (!pimpl_.is_navigating) {
    throw invalid_operation_exception();
  }
  if (pimpl_.query.count(key)) {
    throw key_overwrite_exception();
  }
  pimpl_.query[key] = value;
}

void yc::api_request::remove_query_value(const std::string& key) {
  if (!pimpl_.is_navigating) {
    throw invalid_operation_exception();
  }
  if (!pimpl_.query.count(key)) {
    throw unknown_key_exception();
  }
  pimpl_.query.erase(key);
}

void yc::api_request::sink(void) {
  if (!pimpl_.is_navigating) {
    throw invalid_operation_exception();
  }
  pimpl_.has_sunk = true;
  pimpl_.is_navigating = false;
}

bool yc::api_request::has_sunk(void) const {
  return pimpl_.has_sunk;
}

web::http::http_request& yc::api_request::request(void) const {
  if (!pimpl_.is_navigating) {
    throw invalid_operation_exception();
  }
  return pimpl_.request;
}

void const* yc::api_request::tag(const std::string& key) const {
  if (!pimpl_.is_navigating) {
    throw invalid_operation_exception();
  }
  if (!pimpl_.dict.count(key)) {
    throw unknown_key_exception();
  }
  return pimpl_.dict.at(key);
}

bool yc::api_request::exists_tag(const std::string& key) const {
  if (!pimpl_.is_navigating) {
    throw invalid_operation_exception();
  }
  return pimpl_.dict.count(key);
}

std::string yc::api_request::query(const std::string& key) const {
  if (!pimpl_.is_navigating) {
    throw invalid_operation_exception();
  }
  if (!pimpl_.query.count(key)) {
    throw unknown_key_exception();
  }
  return pimpl_.query.at(key);
}

bool yc::api_request::exists_query_value(const std::string& key) const {
  if (!pimpl_.is_navigating) {
    throw invalid_operation_exception();
  }
  return pimpl_.query.count(key);
}
