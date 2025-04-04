include(FetchContent)

FetchContent_Declare(
    expected-lite
    URL https://github.com/martinmoene/expected-lite/archive/refs/tags/v0.8.0.tar.gz
    URL_HASH SHA256=27649f30bd9d4fe7b193ab3eb6f78c64d0f585c24c085f340b4722b3d0b5e701
)
FetchContent_MakeAvailable(expected-lite)

FetchContent_Declare(
    variant-lite
    URL https://github.com/martinmoene/variant-lite/archive/5015e841cf143487f2d7e2f619b618d455658fab.tar.gz
    URL_HASH SHA256=d343cfa347517a2ee318864f3e2a08af8e17e699de701c69c1cdbdab79d9331f
)
FetchContent_MakeAvailable(variant-lite)

FetchContent_Declare(
    optional-lite
    URL https://github.com/martinmoene/optional-lite/archive/refs/tags/v3.6.0.tar.gz
    URL_HASH SHA256=2be17fcfc764809612282c3e728cabc42afe703b9dc333cc87c48d882fcfc2c2
)
FetchContent_MakeAvailable(optional-lite)

FetchContent_Declare(
    string-view-lite
    URL https://github.com/martinmoene/string-view-lite/archive/refs/tags/v1.8.0.tar.gz
    URL_HASH SHA256=9b38c32621eb1a81a7fa59427144309225c414a7bae522ab3a2d9ae239dd35be
)
FetchContent_MakeAvailable(string-view-lite)

set (FMT_INSTALL ON CACHE BOOL "" FORCE)
FetchContent_Declare(
    fmt
    URL https://github.com/fmtlib/fmt/archive/refs/tags/10.2.1.tar.gz
    URL_HASH SHA256=1250e4cc58bf06ee631567523f48848dc4596133e163f02615c97f78bab6c811
)
FetchContent_MakeAvailable(fmt)

set (RAPIDJSON_BUILD_DOC OFF CACHE BOOL "" FORCE)
set (RAPIDJSON_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set (RAPIDJSON_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set (RAPIDJSON_BUILD_THIRDPARTY_GTEST OFF CACHE BOOL "" FORCE)
set (RAPIDJSON_ENABLE_INSTRUMENTATION_OPT OFF CACHE BOOL "" FORCE)

FetchContent_Declare(
    rapidjson
    #    GIT_TAG f9d53419e912910fd8fa57d5705fa41425428c35 - latest but broken revision
    URL https://github.com/Tencent/rapidjson/archive/973dc9c06dcd3d035ebd039cfb9ea457721ec213.tar.gz
    URL_HASH SHA256=d0c9e52823d493206eb721d38cb3a669ca0212360862bd15a3c2f7d35ea7c6f7
)
FetchContent_MakeAvailable(rapidjson)

find_package(RapidJSON REQUIRED
             PATHS "${rapidjson_BINARY_DIR}"
             NO_CMAKE_FIND_ROOT_PATH
             NO_DEFAULT_PATH)

add_library(RapidJson INTERFACE)
target_include_directories(RapidJson
    INTERFACE
        $<BUILD_INTERFACE:${RapidJSON_INCLUDE_DIR}>
        $<INSTALL_INTERFACE:include>
)

if (JINJA2CPP_BUILD_TESTS)
    set (JSON_BuildTests OFF CACHE BOOL "" FORCE)
    set (JSON_Install OFF CACHE BOOL "" FORCE)
    set (JSON_MultipleHeaders ON CACHE BOOL "" FORCE)

    FetchContent_Declare(
        nlohmann_json
        URL https://codeload.github.com/nlohmann/json/zip/11a835df85677002a8aadc5b4e945684c5b7f68b
        URL_HASH SHA256=8320fab51a221259d50f47911c05b90eb07d8e13b2e9388fd56372a7be30e702
    )
    FetchContent_MakeAvailable(nlohmann_json)
endif()

install (FILES
        thirdparty/nonstd/expected-lite/include/nonstd/expected.hpp
        thirdparty/nonstd/variant-lite/include/nonstd/variant.hpp
        thirdparty/nonstd/optional-lite/include/nonstd/optional.hpp
        thirdparty/nonstd/string-view-lite/include/nonstd/string_view.hpp
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/nonstd)

install (TARGETS RapidJson
    EXPORT InstallTargets
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/static
)
