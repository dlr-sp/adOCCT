cmake_minimum_required(VERSION 3.14)

# Only proceed if tests are enabled
if (NOT BUILD_AD_TESTS)
    return()
endif ()

message(STATUS "CXX_STANDARD: ${CMAKE_CXX_STANDARD}")

include(FetchContent)
#v1.18.0
FetchContent_Declare(
        googletest
        URL https://github.com/google/googletest/archive/063de7e9578f82b369302001269680b4b1553359.zip
)

FetchContent_MakeAvailable(googletest)

enable_testing()

# Create the test executable once
add_executable(occt_ad_tests
        tests-ad/src/bspline_curve.cpp
)

# Link with Google Test
target_link_libraries(occt_ad_tests PRIVATE GTest::gtest_main pthread
        adolc TKernel TKMath TKG2d TKG3d TKGeomBase TKBRep
        TKGeomAlgo TKTopAlgo TKPrim TKBO TKBool TKHLR TKFillet TKOffset TKFeat TKMesh TKXMesh TKShHealing)

target_compile_definitions(occt_ad_tests PRIVATE GTEST_LINKED_AS_SHARED_LIBRARY=1)

include(GoogleTest)
gtest_discover_tests(occt_ad_tests)

# install (TARGETS ${occt_ad_tests} DESTINATION "${INSTALL_DIR_BIN}")







