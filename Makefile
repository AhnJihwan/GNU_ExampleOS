all: linker.ld kernel.c boot.S
	gcc -m32 -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	as --32 boot.s -o boot.o
	ld -m elf_i386 -T linker.ld boot.o kernel.o -o gnu.bin -nostdlib
	grub-file --is-x86-multiboot gnu.bin
	mkdir -p isodir/boot/grub
	cp gnu.bin isodir/boot/gnu.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o gnu.iso isodir

qemu: gnu.iso
	qemu-system-i386 -cdrom gnu.iso
