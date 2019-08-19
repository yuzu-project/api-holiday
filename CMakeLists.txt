cmake_minimum_required(VERSION 3.0)

project(cpprest-basic-sample)

# Include required libraries
find_package(Boost REQUIRED COMPONENTS system thread log program_options chrono)
find_package(Threads REQUIRED)

if(UNIX)
    find_package(OpenSSL 1.0.1 REQUIRED)
    set(OPENSSL_VERSION "1.0.1")
else()
    message(FATAL_ERROR "-- Unsupported platform")
endif()

# Configure compiler options ...
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    message("-- configuring clang options")
    set(CMAKE_CXX_FLAGS "-arch x86_64 -std=c++11 -stdlib=libc++ -DBOOST_LOG_DYN_LINK -Wno-deprecated-declarations")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    message("-- configuring gcc options")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11 -DBOOST_LOG_DYN_LINK")
endif()

# Project construction ...

# source files ...
add_executable(${PROJECT_NAME} ./src/main.cpp)


# headers search paths ...
set(CPPRESTSDK_INCLUDE_DIR "./libs/cpprestsdk/Release/include")
set(PROJECT_INCLUDE_DIR "./src/include")
message(PROJECT " ${PROJECT_INCLUDE_DIR}")
set(HEADER_SEARCH_PATHS ${CPPRESTSDK_INCLUDE_DIR} ${PROJECT_INCLUDE_DIR} ${Boost_INCLUDE_DIR} ${OPENSSL_INCLUDE_DIR})

# library search paths ...
set(OPENSSL_LIBS "${OPENSSL_LIBRARIES}")
set(CPPRESTSDK_LIBRARY "${PROJECT_SOURCE_DIR}/libs/cpprestsdk/build.release/Binaries/libcpprest.a")
set(LIBRARIES_SEARCH_PATHS ${CPPRESTSDK_LIBRARY} ${OPENSSL_LIBS} ${Boost_LIBRARIES})

message(BOOST_LIBS " ${Boost_LIBRARIES}")
message(OPENSSL_LIBS " ${OPENSSL_LIBRARIES}")
message(CPPRESTSDK_LIBRARY " ${CPPRESTSDK_LIBRARY}")
message(LIBRARIES_SEARCH_PATHS " ${LIBRARIES_SEARCH_PATHS}")

include_directories(${HEADER_SEARCH_PATHS})
if (APPLE)
    target_link_libraries(${PROJECT_NAME} "-framework CoreFoundation")
    target_link_libraries(${PROJECT_NAME} "-framework Security")
    target_link_libraries(${PROJECT_NAME} ${LIBRARIES_SEARCH_PATHS})
    set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-W1, -F/Library/Frameworks")
else()
    target_link_libraries(${PROJECT_NAME} ${LIBRARIES_SEARCH_PATHS})
endif()
