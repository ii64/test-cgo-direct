all: build

PREFIX := zig 

CFLAGS := $(CFLAGS) -O3
CFLAGS += -target $(TARGET)
CFLAGS += -static
CFLAGS += -mavx
CFLAGS += -mavx2
CFLAGS += -mno-bmi
CFLAGS += -mno-red-zone
CFLAGS += -fPIE
CFLAGS += -fno-asynchronous-unwind-tables
CFLAGS += -fno-stack-protector
CFLAGS += -fno-exceptions
CFLAGS += -fno-builtin
CFLAGS += -fno-rtti
# CFLAGS += -nostdlib

CC := $(PREFIX)cc

AR := $(PREFIX)ar
LD := $(PREFIX)ld

build-src:
	mkdir -p build/$(TARGET)
	for fn in *.c; do \
		$(CC) -o build/$(TARGET)/$${fn}.o $(CFLAGS) -c $${fn} ;  \
	done
	
build: build-src
	$(AR) cr build/$(TARGET)/libnative.a build/$(TARGET)/*.o

build-obj: build
	ld --relocatable -o build/$(TARGET)/libnative.o --whole-archive build/$(TARGET)/libnative.a

clean:
	rm -rf build/