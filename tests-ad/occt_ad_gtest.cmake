cmake_minimum_required(VERSION 3.14)

# Only proceed if tests are enabled
if (NOT BUILD_AD_TESTS)
    set(GOOGLETEST_FOUND FALSE)
    return()
endif ()

message(STATUS "CXX_STANDARD: ${CMAKE_CXX_STANDARD}")

find_package(GTest REQUIRED)

if (GTest_FOUND)
    message(STATUS "Found Googletest installation")
    set(GOOGLETEST_FOUND TRUE)
endif ()

# Enable CTest if Google Test is available
if (GOOGLETEST_FOUND)
    include(GoogleTest)
endif ()

# Create the test executable once
add_executable(occt_ad_tests
        tests-ad/src/bspline_curve.cpp
)

# Link with Google Test
if (USE_ADOLC)
target_link_libraries(occt_ad_tests PRIVATE GTest::gtest_main pthread
        adolc TKernel TKMath TKG2d TKG3d TKGeomBase TKBRep
        TKGeomAlgo TKTopAlgo TKPrim TKBO TKBool TKHLR TKFillet TKOffset TKFeat TKMesh TKXMesh TKShHealing)
elseif (USE_CODIPACK)
    target_link_libraries(occt_ad_tests PRIVATE GTest::gtest_main pthread
            CoDiPack TKernel TKMath TKG2d TKG3d TKGeomBase TKBRep
            TKGeomAlgo TKTopAlgo TKPrim TKBO TKBool TKHLR TKFillet TKOffset TKFeat TKMesh TKXMesh TKShHealing)
endif ()
target_compile_definitions(occt_ad_tests PRIVATE GTEST_LINKED_AS_SHARED_LIBRARY=1)

gtest_discover_tests(occt_ad_tests)

# install (TARGETS ${occt_ad_tests} DESTINATION "${INSTALL_DIR_BIN}")