#!/bin/bash

perf="perf stat -e cycles,instructions"

xz_1="./xz_base cpu2006docs.tar.xz 6643 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 1036078272 11795472 4"
xz_2="./xz_base cld.tar.xz 1400 19cf30ae51eddcbefda78dd06014b4b96281456e078ca7c13e1c0c9e6aaea8dff3efb4ad6b0456697718cede6bd5454852652806a657bb56e07d61128434b474 536995164 539938872 8"

cactuBSSN="./cactuBSSN_base spec_ref.par"

lbm="./lbm_base 2000 reference.dat 0 0 200_200_260_ldc.of"

wrf="./wrf_base"

pop2="./pop2"

imagick="./imagick_base -limit disk 0 refspeed_input.tga -resize 817% -rotate -2.76 -shave 540x375 -alpha remove -auto-level -contrast-stretch 1x1% -colorspace Lab -channel R -equalize +channel -colorspace sRGB -define histogram:unique-colors=false -adaptive-blur 0x5 -despeckle -auto-gamma -adaptive-sharpen 55 -enhance -brightness-contrast 10x10 -resize 30% refspeed_output.tga"

nab="./nab_base 3j1n 20140317 220"

fotonik3d="./fotonik3d_base"

specrand="./specrand_base 1255432124 234923"

DIR_RESULTS="/home/ines/v1_1_9/gcc/results/speedup/peak/"

DIR_GCC="/home/ines/v1_1_9/gcc/"

# 657.xz -----------------------------------------------------------------------------------------
> ${DIR_RESULTS}perf/xz_2.err
> ${DIR_RESULTS}perf/xz_1.err

cd ${DIR_GCC}657

for threads in 1 2 4 8 16 32 64 128; do
    cores=$(seq -s, 0 $((threads - 1)))
    export OMP_NUM_THREADS=$threads
    echo "Threads: $threads" >> ${DIR_RESULTS}perf/xz_1.err
    echo "Ejecutando: taskset -c $cores $perf $xz_1 > ${DIR_RESULTS}outputs/cpu2006docs.tar-6643-4.out 2>> ${DIR_RESULTS}perf/xz_1.err"
    taskset -c $cores $perf $xz_1 > ${DIR_RESULTS}outputs/cpu2006docs.tar-6643-4.out 2>> ${DIR_RESULTS}perf/xz_1.err
    echo "---------------------------------" >> ${DIR_RESULTS}perf/xz_1.err
done

for threads in 1 2 4 8 15; do
    cores=$(seq -s, 0 $((threads - 1)))
    export OMP_NUM_THREADS=$threads
    echo "Threads: $threads" >> ${DIR_RESULTS}perf/xz_2.err
    echo "Ejecutando: taskset -c $cores $perf $xz_2 > ${DIR_RESULTS}outputs/cld.tar-1400-8.out 2>> ${DIR_RESULTS}perf/xz_2.err"
    taskset -c $cores $perf $xz_2 > ${DIR_RESULTS}outputs/cld.tar-1400-8.out 2>> ${DIR_RESULTS}perf/xz_2.err
    echo "---------------------------------" >> ${DIR_RESULTS}perf/xz_2.err
done

# 603.bwaves ---------------------------------------------------------------------------------------
> ${DIR_RESULTS}perf/bwaves_1.err
> ${DIR_RESULTS}perf/bwaves_2.err

cd ${DIR_GCC}603

for threads in 1 2 4 8 16 32 64 128; do
    cores=$(seq -s, 0 $((threads - 1)))
    export OMP_NUM_THREADS=$threads
    echo "Threads: $threads" >> ${DIR_RESULTS}perf/bwaves_1.err
    echo "Ejecutando: taskset -c $cores $perf ./bwaves_base bwaves_1 < bwaves_1.in > ${DIR_RESULTS}outputs/bwaves_1.out 2>> ${DIR_RESULTS}perf/bwaves_1.err"
    taskset -c $cores $perf ./bwaves_base bwaves_1 < bwaves_1.in > ${DIR_RESULTS}outputs/bwaves_1.out 2>> ${DIR_RESULTS}perf/bwaves_1.err
    echo "---------------------------------" >> ${DIR_RESULTS}perf/bwaves_1.err
    echo "Threads: $threads" >> ${DIR_RESULTS}perf/bwaves_2.err
    echo "Ejecutando: taskset -c $cores $perf ./bwaves_base bwaves_2 < bwaves_2.in > ${DIR_RESULTS}outputs/bwaves_2.out 2>> ${DIR_RESULTS}perf/bwaves_2.err"
    taskset -c $cores $perf ./bwaves_base bwaves_2 < bwaves_2.in > ${DIR_RESULTS}outputs/bwaves_2.out 2>> ${DIR_RESULTS}perf/bwaves_2.err
    echo "---------------------------------" >> ${DIR_RESULTS}perf/bwaves_2.err
done

# 607.cactuBSSN ------------------------------------------------------------------------------------
> ${DIR_RESULTS}perf/cactuBSSN.err

cd ${DIR_GCC}607

for threads in 1 2 4 8 16 32 64 128; do
    cores=$(seq -s, 0 $((threads - 1)))
    export OMP_NUM_THREADS=$threads
    echo "Threads: $threads" >> ${DIR_RESULTS}perf/cactuBSSN.err
    echo "Ejecutando: taskset -c $cores $perf $cactuBSSN > ${DIR_RESULTS}outputs/spec_ref.out 2>> ${DIR_RESULTS}perf/cactuBSSN.err"
    taskset -c $cores $perf $cactuBSSN > ${DIR_RESULTS}outputs/spec_ref.out 2>> ${DIR_RESULTS}perf/cactuBSSN.err
    echo "---------------------------------" >> ${DIR_RESULTS}perf/cactuBSSN.err
done

# 619.lbm -----------------------------------------------------------------------------------------
> ${DIR_RESULTS}perf/lbm.err

cd ${DIR_GCC}619

for threads in 1 2 4 8 16 32 64 128; do
    cores=$(seq -s, 0 $((threads - 1)))
    export OMP_NUM_THREADS=$threads
    echo "Threads: $threads" >> ${DIR_RESULTS}perf/lbm.err
    echo "Ejecutando: taskset -c $cores $perf $lbm > ${DIR_RESULTS}outputs/lbm.out 2>> ${DIR_RESULTS}perf/lbm.err"
    taskset -c $cores $perf $lbm > ${DIR_RESULTS}outputs/lbm.out 2>> ${DIR_RESULTS}perf/lbm.err
    echo "---------------------------------" >> ${DIR_RESULTS}perf/lbm.err
done

# 621.wrf -----------------------------------------------------------------------------------------
> ${DIR_RESULTS}perf/wrf.err

cd ${DIR_GCC}621

for threads in 1 2 4 8 16 32 64 128; do
    cores=$(seq -s, 0 $((threads - 1)))
    export OMP_NUM_THREADS=$threads
    echo "Threads: $threads" >> ${DIR_RESULTS}perf/wrf.err
    echo "Ejecutando: taskset -c $cores $perf $wrf > ${DIR_RESULTS}outputs/rsl.out.0000 2>> ${DIR_RESULTS}perf/wrf.err"
    taskset -c $cores $perf $wrf > ${DIR_RESULTS}outputs/rsl.out.0000 2>> ${DIR_RESULTS}perf/wrf.err
    echo "---------------------------------" >> ${DIR_RESULTS}perf/wrf.err
done

# 628.pop2 -----------------------------------------------------------------------------------------
> ${DIR_RESULTS}perf/pop2.err

for threads in 1 2 4 8 16 32 64 128; do
    cd ${DIR_GCC}628/peak/th$threads
    cores=$(seq -s, 0 $((threads - 1)))
    echo "Threads: $threads" >> ${DIR_RESULTS}perf/pop2.err
    echo "Ejecutando: taskset -c $cores $perf $pop2 > ${DIR_RESULTS}outputs/pop2.out 2>> ${DIR_RESULTS}perf/pop2.err"
    taskset -c $cores $perf $pop2 > ${DIR_RESULTS}outputs/pop2.out 2>> ${DIR_RESULTS}perf/pop2.err
    echo "---------------------------------" >> ${DIR_RESULTS}perf/pop2.err
done

# 638.imagick --------------------------------------------------------------------------------------
> ${DIR_RESULTS}perf/imagick.err

cd ${DIR_GCC}638

for threads in 1 2 4 8 16 32 64 128; do
    cores=$(seq -s, 0 $((threads - 1)))
    export OMP_NUM_THREADS=$threads
    echo "Threads: $threads" >> ${DIR_RESULTS}perf/imagick.err
    echo "Ejecutando: taskset -c $cores $perf $imagick > ${DIR_RESULTS}outputs/refspeed_convert.out 2>> ${DIR_RESULTS}perf/imagick.err"
    taskset -c $cores $perf $imagick > ${DIR_RESULTS}outputs/refspeed_convert.out 2>> ${DIR_RESULTS}perf/imagick.err
    echo "---------------------------------" >> ${DIR_RESULTS}perf/imagick.err
done

# 644.nab ------------------------------------------------------------------------------------------
> ${DIR_RESULTS}perf/nab.err

cd ${DIR_GCC}644

for threads in 1 2 4 8 16 32 64 128; do
    cores=$(seq -s, 0 $((threads - 1)))
    export OMP_NUM_THREADS=$threads
    echo "Threads: $threads" >> ${DIR_RESULTS}perf/nab.err
    echo "Ejecutando: taskset -c $cores $perf $nab > ${DIR_RESULTS}outputs/3j1n.out 2>> ${DIR_RESULTS}perf/nab.err"
    taskset -c $cores $perf $nab > ${DIR_RESULTS}outputs/3j1n.out 2>> ${DIR_RESULTS}perf/nab.err
    echo "---------------------------------" >> ${DIR_RESULTS}perf/nab.err
done

# 649.fotonick3d ------------------------------------------------------------------------------------
> ${DIR_RESULTS}perf/fotonik3d.err

cd ${DIR_GCC}649

for threads in 1 2 4 8 16 32 64 128; do
    cores=$(seq -s, 0 $((threads - 1)))
    export OMP_NUM_THREADS=$threads
    echo "Threads: $threads" >> ${DIR_RESULTS}perf/fotonik3d.err
    echo "Ejecutando: taskset -c $cores $perf $fotonik3d > ${DIR_RESULTS}outputs/fotonik3d.log 2>> ${DIR_RESULTS}perf/fotonik3d.err"
    taskset -c $cores $perf $fotonik3d > ${DIR_RESULTS}outputs/fotonik3d.log 2>> ${DIR_RESULTS}perf/fotonik3d.err
    echo "---------------------------------" >> ${DIR_RESULTS}perf/fotonik3d.err
done

# 654.sroms -------------------------------------------------------------------------------------------
> ${DIR_RESULTS}perf/sroms.err

cd ${DIR_GCC}654

for threads in 1 2 4 8; do
    cores=$(seq -s, 0 $((threads - 1)))
    export OMP_NUM_THREADS=$threads
    echo "Threads: $threads" >> ${DIR_RESULTS}perf/sroms.err
    echo "Ejecutando: taskset -c $cores $perf ./sroms_base < ocean_benchmark3.in.x > ${DIR_RESULTS}outputs/ocean_benchmark3.log 2>> ${DIR_RESULTS}perf/sroms.err"
    taskset -c $cores $perf $sroms > ${DIR_RESULTS}outputs/ocean_benchmark3.log 2>> ${DIR_RESULTS}perf/sroms.err
    echo "---------------------------------" >> ${DIR_RESULTS}perf/sroms.err
done

# 996.specrand ----------------------------------------------------------------------------------------
> ${DIR_RESULTS}perf/specrand.err

cd ${DIR_GCC}996

for threads in 1 2 4 8 16 32 64 128; do
    cores=$(seq -s, 0 $((threads - 1)))
    export OMP_NUM_THREADS=$threads
    echo "Threads: $threads" >> ${DIR_RESULTS}perf/specrand.err
    echo "Ejecutando: taskset -c $cores $perf $specrand > ${DIR_RESULTS}outputs/rand.234923.out 2>> ${DIR_RESULTS}perf/specrand.err"
    taskset -c $cores $perf $specrand > ${DIR_RESULTS}outputs/rand.234923.out 2>> ${DIR_RESULTS}perf/specrand.err
    echo "---------------------------------" >> ${DIR_RESULTS}perf/specrand.err
done

cd ${DIR_GCC}
