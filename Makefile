SHELL := /bin/bash

TARGET = mcp9808_read
LIBS = -lm -lwiringPi
CC = gcc
CFLAGS = -std=c11 -g -Wall

.PHONY: default all clean

default: $(TARGET)
all: default

OBJECTS = $(patsubst %.c, %.o, $(wildcard *.c))
HEADERS = $(wildcard *.h)

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): prerequisites $(OBJECTS)
	$(CC) $(OBJECTS) -Wall $(LIBS) -o $@
	sudo chown root:root $(TARGET)
	sudo chmod +s $(TARGET)

prerequisites:
	if [ ! -d mcp9808 ]; then git clone https://github.com/lexruee/mcp9808.git; fi
	if [ ! -e mcp9808.h ]; then ln -s mcp9808/src/mcp9808.h; fi
	if [ ! -e mcp9808.c ]; then ln -s mcp9808/src/mcp9808.c; fi

test: all
	./mcp9808_read

clean:
	rm -f *.o
	#rm -rf mcp9808 mcp9808.h mcp9808.c
	rm -f $(TARGET)
