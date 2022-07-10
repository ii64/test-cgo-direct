all: build

ifndef GOOS
GOOS := linux
endif
ifndef GOARCH
GOARCH := amd64
endif

CFLAGS := $(CFLAGS)
CFLAGS += -target $(TARGET)

ARCH_TARGETS := \
	x86_64-linux \
	aarch64-linux

ifndef TARGET
TARGET := x86_64-linux
endif

# CC := zig cc $(CFLAGS)
# CC := gcc
CC := zig cc -target $(TARGET)
GODEBUG := -gcflags="all=-N -l"

build: build-native-multi
	echo "GOOS: $(GOOS)"; echo "GOARCH: $(GOARCH)"
	GOOS=$(GOOS) GOARCH=$(GOARCH) CGO_ENABLED=1 CC="$(CC)" go build -x main.go

debug: 
	GOOS=$(GOOS) GOARCH=$(GOARCH) CGO_ENABLED=1 CC="$(CC)" go build $(GODEBUG) main.go


dmp2:
	go tool objdump -S main > dmpgo
	aarch64-linux-gnu-objdump -d main > dmp
dmp:
	go tool objdump -S main > dmpgo
	objdump -d main > dmp
#	make -C native TARGET=$(TARGET) build-obj
#	objdump -d native/build/$(TARGET)/libnative.o > dmp2

build-native:
	make -C native TARGET=$(TARGET) build

build-native-multi:
	for arch in $(ARCH_TARGETS); do \
		make -C native TARGET=$${arch} build; \
	done

clean:
	make -C native clean
	rm -rf main dmp dmp2 dmpgo

build-aarch64: build-native-multi
	make -C . GOARCH=arm64 TARGET=aarch64-linux build

run-aarch64: build-aarch64
	qemu-aarch64 -L /usr/aarch64-linux-gnu -g 9999 ./main

gdb2:
	gdb-multiarch -q --nh -ex 'set architecture arm64' -ex 'file main' -ex 'target remote localhost:9999' -ex 'layout split' -ex 'layout regs'