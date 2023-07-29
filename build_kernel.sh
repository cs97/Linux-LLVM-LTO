#!/bin/sh

kernel_name="-gentoo-llvm-O2-lto"

cd /usr/src/linux

make oldconfig

make CC=clang LLVM=1 menuconfig

make CC=clang \
    LD=ld.lld \
    AR=llvm-ar \
    NM=llvm-nm \
    STRIP=llvm-strip \
    OBJCOPY=llvm-objcopy \
    OBJDUMP=llvm-objdump \
    READELF=llvm-readelf \
    HOSTCC=clang \
    HOSTCXX=clang++ \
    HOSTAR=llvm-ar \
    HOSTLD=ld.lld \
    LLVM_IAS=1 \
    -j14 KCFLAGS="-O2 -march=native -pipe" \
    EXTRAVERSION=$kernel_name \
    all

make modules_install

make install

dracut --hostonly "/boot/initramfs-$(make EXTRAVERSION=$kernel_name kernelrelease).img" \
    --kver "$(make EXTRAVERSION=$kernel_name kernelrelease)"

grub-mkconfig -o /boot/grub/grub.cfg
