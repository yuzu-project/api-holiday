#include <boost/test/unit_test.hpp>

BOOST_AUTO_TEST_CASE(assert_int) {
  int i = 2;
  BOOST_CHECK(i * 2 == 4);
}