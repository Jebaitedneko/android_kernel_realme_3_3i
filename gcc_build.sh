#!/bin/bash

[ -d "out" ] && rm -rf out || mkdir -p out
[ -d "los-4.9-64" ] && echo "ARM64 TC Present." || echo "ARM64 TC Not Present. Downloading..." | git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 los-4.9-64
[ -d "los-4.9-32" ] && echo "ARM32 TC Present." || echo "ARM32 TC Not Present. Downloading..." | git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9 los-4.9-32

make O=out ARCH=arm64 realme_defconfig
# make O=out ARCH=arm64 k71v1_64_bsp_defconfig

PATH="$(pwd)/los-4.9-64/bin:$(pwd)/los-4.9-32/bin:${PATH}" \
make                  O=out \
                      ARCH=arm64 \
                      CROSS_COMPILE=aarch64-linux-android- \
                      CROSS_COMPILE_ARM32=arm-linux-androideabi- \
                      CONFIG_NO_ERROR_ON_MISMATCH=y \
                      -j8
