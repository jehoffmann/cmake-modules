# - try to find intel tpm-tss library
#
# Cache Variables: (probably not for direct use in your scripts)
#  TSS_INCLUDE_DIR
#  TSS_SAPI_LIBRARY
#  TSS_TCTI_SOCKET_LIBRARY
#
# Non-cache variables you might use in your CMakeLists.txt:
#  TSS_FOUND
#  TSS_INCLUDE_DIRS
#  TSS_LIBRARIES
#
# Requires these CMake modules:
#  FindPackageHandleStandardArgs (known included with CMake >=2.6.2)
# Hints
# ^^^^^
#
# Set ``TSS_ROOT_DIR`` to the root directory of a tpm2-tss installation.
set(_TSS_ROOT_HINTS
    ${TSS_ROOT_DIR}
    ENV TSS_ROOT_DIR
    )

find_package(PkgConfig QUIET)
pkg_check_modules(PC_TSS_SAPI QUIET sapi)
pkg_check_modules(PC_TSS_TCTI_SOCKET QUIET tcti-socket)

find_path(TSS_INCLUDE_DIR NAMES sapi/tpm20.h
   HINTS ${PC_TSS_SAPI_INCLUDEDIR} ${_TSS_ROOT_HINTS})

find_library(TSS_SAPI_LIBRARY NAMES sapi
    HINTS ${_TSS_ROOT_HINTS} ${PC_TSS_SAPI_LIBDIR})

find_library(TSS_TCTI_SOCKET_LIBRARY NAMES tcti-socket
    HINTS ${_TSS_ROOT_HINTS} ${PC_TSS_TCTI_SOCKET})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Tpm2Tss
	DEFAULT_MSG
        TSS_INCLUDE_DIR
        TSS_SAPI_LIBRARY
        TSS_TCTI_SOCKET_LIBRARY)

mark_as_advanced(TSS_INCLUDE_DIR TSS_SAPI_LIBRARY TSS_TCTI_SOCKET_LIBRARY)

set(TSS_INCLUDE_DIRS ${TSS_INCLUDE_DIR})
set(TSS_LIBRARIES ${TSS_SAPI_LIBRARY} ${TSS_TCTI_SOCKET_LIBRARY})

