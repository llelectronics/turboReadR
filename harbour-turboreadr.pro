# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-turboreadr

CONFIG += sailfishapp

SOURCES += src/harbour-turboreadr.cpp \
    src/folderlistmodel/qquickfolderlistmodel.cpp \
    src/folderlistmodel/fileinfothread.cpp

OTHER_FILES += qml/harbour-turboreadr.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/harbour-turboreadr.spec \
    rpm/harbour-turboreadr.yaml \
    translations/*.ts \
    harbour-turboreadr.desktop \
    qml/pages/AboutPage.qml \
    qml/pages/CreditsModel.qml \
    qml/pages/SettingsPage.qml \
    rpm/harbour-turboreadr.changes \
    qml/pages/images/icon.png \
    qml/pages/db.js \
    qml/pages/fileman/qmldir \
    qml/pages/fileman/Main.qml \
    qml/pages/fileman/DirView.qml \
    qml/pages/fileman/DirStack.qml \
    qml/pages/fileman/DirList.qml \
    qml/pages/fileman/DirEntryMenu.qml \
    qml/pages/fileman/DirEntry.qml \
    qml/pages/Notification.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-turboreadr-de.ts

HEADERS += \
    src/folderlistmodel/qquickfolderlistmodel.h \
    src/folderlistmodel/fileproperty_p.h \
    src/folderlistmodel/fileinfothread_p.h \
    src/fmhelper.hpp \
    src/textfile.hpp

