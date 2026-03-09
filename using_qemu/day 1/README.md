# Basic Overview of BareMetal programming for ARM fully emulated with QEMU and U-Boot

refs: https://github.com/umanovskis/baremetal-arm
        Bare-metal programming for ARM E-book

if sd card creation doesn't work due to nbd
do this before attempting to making sd image 
else remove tmp folder and try again
```
sudo modprobe nbd
```

## QEMU

```
qemu-system-arm -M vexpress-a9 -m 32M -no-reboot -nographic -monito telnet:127.0.0.1:1234,server,nowait -kernel u-boot-2018.09/u-boot -sd sdcard.img
```

## U-Boot

```
mmc list
ext2ls mmc 0
est2load mmc 0 0x60000000 bare-arm.uimg
iminfo 0x60000000
bootm 0x60000000
```

## other Terminal

```
telnet localhost 1234
```
## Build and Running

example assebly file
```
arm-none-eabi-as -o startup.o startup.s
```
example c source file
```
arm-none-eabi-gcc -c -nostdlib -nostartfiles -lgcc -o cstart.o cstart.c
```
link to linker
```
arm-none-eabi-ld -T linkscript.ld -o cenv.elf startup.o cstart.o 
```
convert elf to binary
```
arm-none-eabi-objcopy -O binary cenv.elf cenv.bin 
```

## create u-boot image

```
../../../u-boot//tools/mkimage -A arm -C none -T kernel -a 0x60000000 -e 0x60000000 -d cenv. bin bare-arm.uimg
./create-sd.sh sdcard.img bare-arm.uimg
```

## create sd card image

```
./create-sd.sh sdcard.img bare-arm.uimg
```

## run qemu 

```
qemu-system-arm -M vexpress-a9 -m 512M -no-reboot -nographic -monitor telnet:127.0.0.1:1234,server,nowait -kernel ../../../u-boot/u-boot -sd sdcard.img
```
## dump elf

```
arm-none-eabi-objdump -h cenv.elf
```
