all: kernel.c boot.s
	gcc -m32 -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	as --32 boot.s -o boot.o
