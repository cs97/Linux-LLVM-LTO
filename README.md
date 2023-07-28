# Linux-LLVM-O3-LTO_FULL

### example on gentoo linux

### Install dracut: 
```
emerge --ask sys-kernel/dracut
```

### change directory to /usr/src/linux
```
cd /usr/src/linux
```
### copy old config if available
```
sudo cp /usr/src/linux-6.4.4-gentoo/.config .config
```
```
sudo make oldconfig
```

### Kernel configuration
```
General architecture-dependent options ---><br>
    Link Time Optimization (LTO) (Clang ThinLTO (EXPERIMENTAL)) ---><br>
        ( ) None<br>
        (x) Clang Full LTO (EXPERIMENTAL)<br>
        ( ) Clang ThinLTO (EXPERIMENTAL)
```   
```
sudo make CC=clang LLVM=1 menuconfig
```

### build Kernel
```
sudo make CC=clang \
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
    -j14 KCFLAGS="-O3 -march=alderlake -pipe" \
    EXTRAVERSION=-gentoo-llvm-O3-lto-full \
    all
```

### install Kernel and Modules
```
sudo make modules_install
```
```
sudo make install
```

### build initramfs
```
sudo dracut --hostonly "/boot/initramfs-$(make EXTRAVERSION=-gentoo-llvm-O3-lto-full kernelrelease).img" \
    --kver "$(make EXTRAVERSION=-gentoo-llvm-O3-lto-full kernelrelease)"
```

### update Grub
```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
