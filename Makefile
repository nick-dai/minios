BUILD_DIR=./build
LIB=-I include/
CFLAGS=-fno-builtin -fno-stack-protector -O2

.PHONY: clean dump
all: genkey compile sign image dump
evil: compile image dump

compile: $(BUILD_DIR)/mbr.bin $(BUILD_DIR)/loader.bin $(BUILD_DIR)/kernel.bin

image:
	@echo "\033[0;33mMaking the image...\033[0m"
	dd if=$(BUILD_DIR)/mbr.bin of=hd60M.img count=1 bs=512 conv=notrunc
	dd if=$(BUILD_DIR)/loader.bin of=hd60M.img bs=512 count=8 seek=1 conv=notrunc
	dd if=$(BUILD_DIR)/kernel.bin of=hd60M.img bs=512 count=200 seek=10 conv=notrunc

sign:
	@echo "\033[0;33mSigning kernel...\033[0m"
	python3 hash_bin.py
	dd if=$(BUILD_DIR)/kernel_hash.bin of=hd60M.img bs=512 count=1 seek=210 conv=notrunc

genkey:
	@echo "\033[0;33mGenerate keys...\033[0m"
	python3 genKey.py

# Build mbr
$(BUILD_DIR)/mbr.bin: mbr.S
	@echo "\033[0;33mBuilding MBR...\033[0m"
	nasm -I include/ -o $(BUILD_DIR)/mbr.bin mbr.S

# Build loader
$(BUILD_DIR)/loader.bin: loader.S
	@echo "\033[0;33mBuilding loader...\033[0m"
	nasm -I include/ -f elf32 -o $(BUILD_DIR)/loader.elf loader.S

	gcc $(CFLAGS) -m32 -c -o $(BUILD_DIR)/rsa.o rsa.c

	ld -m elf_i386 -Ttext 0x600 $(BUILD_DIR)/loader.elf -o $(BUILD_DIR)/loader.o $(BUILD_DIR)/rsa.o
	objcopy -O binary $(BUILD_DIR)/loader.o $(BUILD_DIR)/loader.bin

# Build kernel
$(BUILD_DIR)/kernel.bin: kernel/main.c lib/print.S
	@echo "\033[0;33mBuilding kernel...\033[0m"
	nasm -I include/ -f elf32 -o $(BUILD_DIR)/print.o lib/print.S
	gcc  -I lib/ -m32 -c -o $(BUILD_DIR)/main.o kernel/main.c
	ld -m elf_i386  $(BUILD_DIR)/main.o $(BUILD_DIR)/print.o -Ttext 0xc0001000 -o $(BUILD_DIR)/main.bin
	objcopy -O binary $(BUILD_DIR)/main.bin $(BUILD_DIR)/kernel.bin

dump:
	@echo "\033[0;33mDump for debugging...\033[0m"
	objdump -D -b binary -m i386 -M intel $(BUILD_DIR)/loader.bin > $(BUILD_DIR)/loader.bin.dump
	objdump -D -b binary -m i386 -M intel $(BUILD_DIR)/kernel.bin > $(BUILD_DIR)/kernel.bin.dump
	objdump -D -b binary -m i386 -M intel $(BUILD_DIR)/rsa.o > $(BUILD_DIR)/rsa.o.dump

clean:
	rm $(BUILD_DIR)/*.*
