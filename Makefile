all: build

CFLAGS := $(CFLAGS)
CFLAGS += -target $(TARGET)

TARGET := x86_64-linux
# CC := zig cc $(CFLAGS)
CC := gcc
GODEBUG := -x -gcflags="all=-N -l"

build-native:
	make -C native TARGET=$(TARGET) build

build: build-native
	CGO_ENABLE=1 CC="$(CC)" go build main.go

debug:
	CGO_ENABLE=1 CC="$(CC)" go build $(GODEBUG) main.go

dmp: debug
	objdump -d main > dmp
	make -C native TARGET=$(TARGET) build-obj
	objdump -d native/build/$(TARGET)/libnative.o > dmp2

clean:
	make -C native clean
	rm -rf main dmp dmp2