# Linux-LLVM-O3-LTO_FULL

```
cd /usr/src/linux
```

```
sudo cp /usr/src/linux-6.4.4-gentoo/.config .config
```

```
sudo make oldconfig
```

CONFIG_LTO_CLANG_FULL=y
```
sudo make CC=clang LLVM=1 menuconfig
```

```
make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld LLVM_IAS=1 -j14 KCFLAGS="-O3 -march=alderlake -pipe" EXTRAVERSION=-gentoo-llvm-O3-lto-full all
```

```
sudo make modules_install
```

```
sudo make install
```


```
sudo dracut --hostonly "/boot/initramfs-$(make EXTRAVERSION=-gentoo-llvm-O3-lto-full kernelrelease).img" --kver "$(make EXTRAVERSION=-gentoo-llvm-O3-lto-full kernelrelease)"
```


```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```