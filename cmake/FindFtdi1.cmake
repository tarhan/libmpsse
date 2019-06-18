#[==============================================[
FindFtdi1
-----------

Ищем библиотеку ftdi1 и создаем импортируемую
цель Ftdi1::Ftdi1

#]==============================================]

# Импортируем путь к заголовочным файлам ftdi1
if (MSVC OR MINGW)
    return()
endif()

find_path(FTDI1_INCLUDE_DIR
    NAMES libftdi1/ftdi.h
)

# Если библиотека еще не была объявлена проводим её поиск
if (NOT FTDI1_LIBRARY)
    find_library(FTDI1_LIBRARY
        NAMES ftdi1
    )
endif()

# Проверяем наличие библиотки по заголовочному файлу и файлу библиотеки
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Ftdi1
    REQUIRED_VARS FTDI1_LIBRARY FTDI1_INCLUDE_DIR
)

if (Ftdi1_FOUND)
    if (NOT TARGET Ftdi1::Ftdi1)
        add_library(Ftdi1::Ftdi1
            UNKNOWN IMPORTED
        )
        set_target_properties(Ftdi1::Ftdi1 PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES ${FTDI1_INCLUDE_DIR}
        )

        set_property(TARGET Ftdi1::Ftdi1
            APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE DEBUG
        )
        set_target_properties(Ftdi1::Ftdi1 PROPERTIES
            IMPORTED_LOCATION ${FTDI1_LIBRARY}
        )
    endif()
endif()

mark_as_advanced(FTDI1_INCLUDE_DIR)
mark_as_advanced(FTDI1_LIBRARY)

