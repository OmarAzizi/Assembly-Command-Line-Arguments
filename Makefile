build:
	nasm -g -dwarf2 -f elf64 cmdline.asm -o cmdline.o -l cmdline.lst
	gcc -g -no-pie -o cmdline cmdline.o

clean:
	rm -rf *.o cmdline cmdline.lst
