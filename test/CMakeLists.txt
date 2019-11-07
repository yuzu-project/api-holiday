cmake_minimum_required(VERSION 3.0)
set(CMAKE_CXX_STANDARD 11)

project(test-runner)
enable_testing()

# Include required libraries
find_package(Boost)

# Configure compiler options ...
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    message("-- configuring clang options")
    set(CMAKE_CXX_FLAGS "-arch x86_64 -std=c++11 -stdlib=libc++ -DBOOST_LOG_DYN_LINK -Wno-deprecated-declarations")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    message("-- configuring gcc options")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11 -DBOOST_LOG_DYN_LINK")
endif()

# Project construction ...
add_executable(${PROJECT_NAME})

# headers search paths ...
set(PROJECT_BASE_DIR "${PROJECT_SOURCE_DIR}/..")
set(PROJECT_INCLUDE_DIR "${PROJECT_BASE_DIR}/src/include")
message(PROJECT_INCLUDE_DIR " ${PROJECT_INCLUDE_DIR}")
set(HEADER_SEARCH_PATHS ${PROJECT_INCLUDE_DIR} ${Boost_INCLUDE_DIR})

# We will use this single variable to point dependencies for our executable
set(LIBRARIES_SEARCH_PATHS 
    ${Boost_LIBRARIES}
)

message(BOOST_LIBS " ${Boost_LIBRARIES}")
message(LIBRARIES_SEARCH_PATHS " ${LIBRARIES_SEARCH_PATHS}")

# Set project depedencies
include_directories(${HEADER_SEARCH_PATHS})
if (APPLE)
    target_link_libraries(${PROJECT_NAME} "-framework CoreFoundation")
    target_link_libraries(${PROJECT_NAME} "-framework Security")
    target_link_libraries(${PROJECT_NAME} ${LIBRARIES_SEARCH_PATHS})
    set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-W1, -F/Library/Frameworks")
else()
    target_link_libraries(${PROJECT_NAME} ${LIBRARIES_SEARCH_PATHS})
endif()


# Add source files required to build our binary...
target_sources(${PROJECT_NAME} 
    PRIVATE
        main.cpp
)
add_subdirectory(unit)
add_test(NAME sample_test COMMAND ${PROJECT_NAME} --show_progress)