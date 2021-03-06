cmake_minimum_required(VERSION 3.10)

add_library(
  flashlight-app-lm
  ""
  )

target_sources(
  flashlight-app-lm
  PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/Trainer.cpp
  )

target_link_libraries(
  flashlight-app-lm
  PUBLIC
  ${GLOG_LIBRARIES}
  ${gflags_LIBRARIES}
  flashlight
  fl-libraries
  )

target_include_directories(
  flashlight-app-lm
  PUBLIC
  ${GLOG_INCLUDE_DIRS}
  ${gflags_INCLUDE_DIRS}
  )

# ------------------------ Components ------------------------

# Common
include(${CMAKE_CURRENT_LIST_DIR}/common/CMakeLists.txt)

# Data
include(${CMAKE_CURRENT_LIST_DIR}/data/CMakeLists.txt)

# ----------------------------- Binaries -----------------------------
add_executable(fl_lm_train ${CMAKE_CURRENT_LIST_DIR}/Train.cpp)
add_executable(fl_lm_test ${CMAKE_CURRENT_LIST_DIR}/Test.cpp)
add_executable(
  fl_lm_dictionary_builder
  ${CMAKE_CURRENT_LIST_DIR}/BuildDictionary.cpp
  )

target_link_libraries(fl_lm_train flashlight-app-lm)
target_link_libraries(fl_lm_test flashlight-app-lm)
target_link_libraries(fl_lm_dictionary_builder flashlight-app-lm)

set_executable_output_directory(fl_lm_train "${FL_BUILD_BINARY_OUTPUT_DIR}/lm")
set_executable_output_directory(fl_lm_test "${FL_BUILD_BINARY_OUTPUT_DIR}/lm")
set_executable_output_directory(
  fl_lm_dictionary_builder
  "${FL_BUILD_BINARY_OUTPUT_DIR}/lm"
  )

install(TARGETS fl_lm_train RUNTIME DESTINATION ${FL_INSTALL_BIN_DIR})
install(TARGETS fl_lm_test RUNTIME DESTINATION ${FL_INSTALL_BIN_DIR})
install(
  TARGETS
  fl_lm_dictionary_builder
  RUNTIME
  DESTINATION
  ${FL_INSTALL_BIN_DIR}
  )

# --------------------------- Tests ---------------------------
if (FL_BUILD_TESTS)
  add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/test)
endif ()
