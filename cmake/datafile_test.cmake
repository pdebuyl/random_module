execute_process(COMMAND ${prog} OUTPUT_FILE ${testfile})
execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files ${testfile} ${reffile} RESULT_VARIABLE res)

if (NOT ${res} EQUAL 0)
  message(FATAL_ERROR datafile_test file comparison failed)
endif()