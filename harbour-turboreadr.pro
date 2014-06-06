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

SOURCES += src/harbour-turboreadr.cpp

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
    qml/pages/images/icon.png

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-turboreadr-de.ts

