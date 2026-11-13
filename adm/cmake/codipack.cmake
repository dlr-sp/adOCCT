# CoDiPack

find_package(CoDiPack CONFIG REQUIRED)

if (CoDiPack_FOUND)
    message(STATUS "Found CoDiPack installation")
    set(3RDPARTY_CODIPACK_DIR ${CoDiPack_DIR} CACHE PATH "The directory containing CoDiPack" FORCE)
    set(3RDPARTY_CODIPACK_INCLUDE_DIR ${CODIPACK_INCLUDE_DIR} CACHE PATH "The directory containing headers of CoDiPack" FORCE)
endif ()

# CoDiPack directory
if (NOT DEFINED 3RDPARTY_CODIPACK_DIR)
    set(3RDPARTY_CODIPACK_DIR "" CACHE PATH "The directory containing CoDiPack")
endif ()

# CoDiPack include directory
if (NOT DEFINED 3RDPARTY_CODIPACK_INCLUDE_DIR OR NOT EXISTS ${3RDPARTY_CODIPACK_INCLUDE_DIR})
    find_path(
            3RDPARTY_CODIPACK_INCLUDE_DIR
            NAMES "codi.hpp"
            PATHS "${3RDPARTY_CODIPACK_DIR}/include" NO_DEFAULT_PATH
            DOC "The directory containing headers of CoDiPack"
    )
endif ()

# include found paths to common variables
if (3RDPARTY_CODIPACK_INCLUDE_DIR AND EXISTS "${3RDPARTY_CODIPACK_INCLUDE_DIR}")
    message(STATUS "CoDiPack include dir added: ${3RDPARTY_CODIPACK_INCLUDE_DIR}")
    list(APPEND 3RDPARTY_INCLUDE_DIRS "${3RDPARTY_CODIPACK_INCLUDE_DIR}")
else ()
    list(APPEND 3RDPARTY_NOT_INCLUDED 3RDPARTY_CODIPACK_INCLUDE_DIR)
endif ()