#-------------------------------------------------
#
# Project created by QtCreator 2016-09-03T20:26:45
#
#-------------------------------------------------

QT       += core

QT       -= gui

TARGET = PNGE
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app

PKGCONFIG += zlib
LIBS += -lz

SOURCES += main.cpp
