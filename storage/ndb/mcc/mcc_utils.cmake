
MACRO(PY_INSTALL)

  MYBLOCKCHAIN_PARSE_ARGUMENTS(ARG
    "FILES;SRC_DIR;DESTINATION"
    ""
    ${ARGN}
  )

  SET(PY_FILES ${ARG_FILES})
  SET(PY_SRC_DIR "${ARG_SRC_DIR}")
  SET(PY_DEST_DIR "${ARG_DESTINATION}")

  FOREACH(sfile ${PY_FILES})
	INSTALL(FILES "${PY_SRC_DIR}/${sfile}"
		DESTINATION "${PY_DEST_DIR}"
		COMPONENT ClusterTools)
#	MESSAGE(STATUS "INSTALL: ${PY_SRC_DIR}/${sfile} -> ${PY_DEST_DIR}")
  ENDFOREACH()
  
ENDMACRO()

MACRO(ADD_ZIP_COMMAND ARCHIVE FILELIST)

SET(ZIP_EXECUTABLE "")
FIND_PROGRAM(ZIP_EXECUTABLE wzzip PATHS "$ENV{ProgramFiles}/WinZip")
IF(ZIP_EXECUTABLE)
    MESSAGE(STATUS "Using ${ZIP_EXECUTABLE}")
	ADD_CUSTOM_COMMAND(OUTPUT "${ARCHIVE}" 
	  COMMAND ${ZIP_EXECUTABLE} -P \"${ARCHIVE}\" ${FILELIST}
      WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
ENDIF(ZIP_EXECUTABLE)

IF(NOT ZIP_EXECUTABLE)
  FIND_PROGRAM(ZIP_EXECUTABLE 7z PATHS "$ENV{ProgramFiles}/7-Zip")
  IF(ZIP_EXECUTABLE)
    MESSAGE(STATUS "Using ${ZIP_EXECUTABLE}")
	ADD_CUSTOM_COMMAND(OUTPUT "${ARCHIVE}" 
	  COMMAND ${ZIP_EXECUTABLE} a -tzip \"${ARCHIVE}\" ${FILELIST}
      WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
  ENDIF(ZIP_EXECUTABLE)
ENDIF(NOT ZIP_EXECUTABLE)

IF(NOT ZIP_EXECUTABLE)
  FIND_PACKAGE(Cygwin)
  IF(CYGWIN_INSTALL_PATH)
  MESSAGE(STATUS "Using cygwin install path with ${ZIP_EXECUTABLE}")
    FIND_PROGRAM(ZIP_EXECUTABLE zip PATHS "${CYGWIN_INSTALL_PATH}/bin")
  ELSE()
  MESSAGE(STATUS "Using other install path ${ZIP_EXECUTABLE}")
    FIND_PROGRAM(ZIP_EXECUTABLE zip PATHS "$ENV{PATH}")
  ENDIF()
  IF(ZIP_EXECUTABLE)
    MESSAGE(STATUS "Using ${ZIP_EXECUTABLE}")
	ADD_CUSTOM_COMMAND(OUTPUT "${ARCHIVE}" 
	  COMMAND ${ZIP_EXECUTABLE} -r ${ARCHIVE} ${FILELIST}
      WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
  ENDIF(ZIP_EXECUTABLE)
ENDIF(NOT ZIP_EXECUTABLE)

IF(NOT ZIP_EXECUTABLE)
  IF(JAVA_ARCHIVE)
    SET(ZIP_EXECUTABLE ${JAVA_ARCHIVE})
    MESSAGE(STATUS "Using ${ZIP_EXECUTABLE}")
	ADD_CUSTOM_COMMAND(OUTPUT "${ARCHIVE}" 
	  COMMAND ${ZIP_EXECUTABLE} cf ${ARCHIVE} ${FILELIST}
      WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
  ENDIF()
ENDIF(NOT ZIP_EXECUTABLE)

ENDMACRO()

