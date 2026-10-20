QT       += core network
QT       -= gui

TARGET   = radeon-profile-daemon
TEMPLATE = app
CONFIG  += console c++17
CONFIG  -= app_bundle

CONFIG(release, debug|release) {
    DEFINES += QT_NO_DEBUG_OUTPUT
} else {
    CONFIG  += warn_on
    QMAKE_CXXFLAGS += -Wextra -Wpedantic
}


SOURCES += main.cpp \
    rpdthread.cpp

HEADERS += \
    rpdthread.h

DESTDIR = target

bin.path = /usr/bin
bin.files = target/radeon-profile-daemon

service.path = /usr/lib/systemd/system
service.files = ../radeon-profile-daemon.service

INSTALLS += \
    bin \
    service
