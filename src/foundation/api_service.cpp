#include "api_service.hpp"

namespace yc = yuzup::calendar;
namespace wh = web::http;
class yc::api_service::pimpl {
 public:
  /* Common verbs */
  void handle_get(wh::http_request request);
  void handle_put(wh::http_request request);
  void handle_post(wh::http_request request);
  void handle_patch(wh::http_request request);
  void handle_del(wh::http_request request);

  /* Less usual verbs */
  void handle_options(wh::http_request request);
  void handle_head(wh::http_request request);
  void handle_trace(wh::http_request request);
  void handle_connect(wh::http_request request);
  void handle_merge(wh::http_request request);

  void do_default_response(wh::http_request request);
};

yc::api_service::api_service() : pimpl_(*new pimpl()) {
  attach_default_verb_handlers();
}

yc::api_service::~api_service() {
  delete &pimpl_;
}

pplx::task<void> yc::api_service::start() {
  return listener_.open();
}

pplx::task<void> yc::api_service::stop() {
  return listener_.close();
}

void yc::api_service::attach_default_verb_handlers() {
  listener_.support(wh::methods::GET, std::bind(pimpl::handle_get, pimpl_, std::placeholders::_1));
  listener_.support(wh::methods::POST,
                    std::bind(pimpl::handle_post, pimpl_, std::placeholders::_1));
  listener_.support(wh::methods::PUT, std::bind(pimpl::handle_put, pimpl_, std::placeholders::_1));
  listener_.support(wh::methods::PATCH,
                    std::bind(pimpl::handle_patch, pimpl_, std::placeholders::_1));
  listener_.support(wh::methods::DEL, std::bind(pimpl::handle_del, pimpl_, std::placeholders::_1));
  listener_.support(wh::methods::OPTIONS,
                    std::bind(pimpl::handle_options, pimpl_, std::placeholders::_1));
  listener_.support(wh::methods::HEAD,
                    std::bind(pimpl::handle_head, pimpl_, std::placeholders::_1));
  listener_.support(wh::methods::TRCE,
                    std::bind(pimpl::handle_trace, pimpl_, std::placeholders::_1));
  listener_.support(wh::methods::CONNECT,
                    std::bind(pimpl::handle_connect, pimpl_, std::placeholders::_1));
  listener_.support(wh::methods::MERGE,
                    std::bind(pimpl::handle_merge, pimpl_, std::placeholders::_1));
}

void yc::api_service::pimpl::handle_get(wh::http_request request) {
  // TODO: code goes here
}
void yc::api_service::pimpl::handle_put(wh::http_request request) {
  // TODO: code goes here
}
void yc::api_service::pimpl::handle_post(wh::http_request request) {
  // TODO: code goes here
}
void yc::api_service::pimpl::handle_patch(wh::http_request request) {
  // TODO: code goes here
}
void yc::api_service::pimpl::handle_del(wh::http_request request) {
  // TODO: code goes here
}
void yc::api_service::pimpl::handle_options(wh::http_request request) {
  // TODO: code goes here
}
void yc::api_service::pimpl::handle_head(wh::http_request request) {
  // TODO: code goes here
}
void yc::api_service::pimpl::handle_trace(wh::http_request request) {
  // TODO: code goes here
}
void yc::api_service::pimpl::handle_connect(wh::http_request request) {
  // TODO: code goes here
}
void yc::api_service::pimpl::handle_merge(wh::http_request request) {
  // TODO: code goes here
}
void yc::api_service::pimpl::do_default_response(wh::http_request request) {
  // TODO: code goes here
}
