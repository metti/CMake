project(compile_depends_no_lib)
set(test_source ${CMAKE_CURRENT_BINARY_DIR}/test.c)
execute_process(COMMAND ${CMAKE_COMMAND} -E remove ${test_source}
                COMMAND ${CMAKE_COMMAND} -E touch  ${test_source})

add_library(lib ${test_source})

# test case 1 : default off
add_library(dependent1 ${test_source})
target_link_libraries(dependent1 lib)

# test case 2 : default off, turned on per target
add_library(dependent2 ${test_source})
target_link_libraries(dependent2 lib)
set_property(TARGET dependent2 PROPERTY COMPILE_DEPENDS_NO_LIB ON)

set(CMAKE_COMPILE_DEPENDS_NO_LIB ON)

# test case 3 : default on
add_library(dependent3 ${test_source})
target_link_libraries(dependent3 lib)

# test case 4 : default on, turned off per target
add_library(dependent4 ${test_source})
target_link_libraries(dependent4 lib)
set_property(TARGET dependent4 PROPERTY COMPILE_DEPENDS_NO_LIB OFF)

# persist the object file extension
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/ext ${CMAKE_C_OUTPUT_EXTENSION})
