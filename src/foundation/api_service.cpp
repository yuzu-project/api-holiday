#include "api_service.hpp"

namespace yc = yuzup::calendar;

yc::api_service::api_service()
{

}

yc::api_service::~api_service()
{
  
}

pplx::task<void> yc::api_service::start()
{
  return listener_.open();
}

pplx::task<void> yc::api_service::stop()
{
  return listener_.close();
}
