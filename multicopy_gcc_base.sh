#!/bin/bash

perf="perf stat -e cycles,instructions"

# Configuración de benchmarks (igual que en tu script original)
xz_1="./xz_base cpu2006docs.tar.xz 6643 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 1036078272 11795472 4"
xz_2="./xz_base cld.tar.xz 1400 19cf30ae51eddcbefda78dd06014b4b96281456e078ca7c13e1c0c9e6aaea8dff3efb4ad6b0456697718cede6bd5454852652806a657bb56e07d61128434b474 536995164 539938872 8"
cactuBSSN="./cactuBSSN_base spec_ref.par"
lbm="./lbm_base 2000 reference.dat 0 0 200_200_260_ldc.of"
wrf="./wrf_base"
pop2="./pop2"
imagick="./imagick_base -limit disk 0 refspeed_input.tga -resize 817% -rotate -2.76 -shave 540x375 -alpha remove -auto-level -contrast-stretch 1x1% -colorspace Lab -channel R -equalize +channel -colorspace sRGB -define histogram:unique-colors=false -adaptive-blur 0x5 -despeckle -auto-gamma -adaptive-sharpen 55 -enhance -brightness-contrast 10x10 -resize 30% refspeed_output.tga"
nab="./nab_base 3j1n 20140317 220"
fotonik3d="./fotonik3d_base"
sroms="./sroms_base < ocean_benchmark3.in.x"
specrand="./specrand_base 1255432124 234923"

# Directorios de resultados
OUTPUTS_DIR="/home/ines/v1_1_9/gcc/results/outputs"
PERF_DIR="/home/ines/v1_1_9/gcc/results/perf"

# Función para lanzar N copias de un benchmark
run_copies() {
    local benchmark_name=$1
    local benchmark_cmd=$2
    local max_copies=$3  # Máximo de copias (ej., 128, 15, 8)
    local input_file=$4  # Opcional: archivo de entrada (para benchmarks con '<')

    echo "===== Benchmark: $benchmark_name ====="

    for copies in 1 2 4 8 16 32 64 128; do
        if (( copies > max_copies )); then
            continue  # Saltar si supera el máximo permitido
        fi

        echo "[+] Lanzando $copies copias de $benchmark_name..."

        # Limpiar archivos de resultados para esta ejecución
        > "$PERF_DIR/${benchmark_name}_${copies}.err"
        > "$OUTPUTS_DIR/${benchmark_name}_${copies}.out"

        # Lanzar cada copia en un núcleo diferente (en paralelo)
        for (( core=0; core < copies; core++ )); do
            > "$PERF_DIR/${benchmark_name}_${copies}.err"
            if [[ -n "$input_file" ]]; then
                echo "Ejecutando: taskset -c $core $perf $benchmark_cmd >> $OUTPUTS_DIR/${benchmark_name}_${copies}.out 2>> $PERF_DIR/${benchmark_name}_${copies}.err < $input_file &"
                taskset -c "$core" $perf $benchmark_cmd >> "$OUTPUTS_DIR/${benchmark_name}_${copies}.out" 2>> "$PERF_DIR/${benchmark_name}_${copies}.err" < "$input_file" &
            else
                echo "Ejecutando: taskset -c $core $perf $benchmark_cmd >> $OUTPUTS_DIR/${benchmark_name}_${copies}.out 2>> $PERF_DIR/${benchmark_name}_${copies}.err &"
                taskset -c "$core" $perf $benchmark_cmd >> "$OUTPUTS_DIR/${benchmark_name}_${copies}.out" 2>> "$PERF_DIR/${benchmark_name}_${copies}.err" &
            fi
        done

        wait  # Esperar a que todas las copias terminen
        echo "[-] $copies copias de $benchmark_name completadas."
    done
}

# --- Ejecución de benchmarks ---
cd /home/ines/v1_1_9/gcc/657 && run_copies "xz_1" "$xz_1" 128
cd /home/ines/v1_1_9/gcc/657 && run_copies "xz_2" "$xz_2" 128

cd /home/ines/v1_1_9/gcc/603 && run_copies "bwaves_1" "./bwaves_base bwaves_1" 128 "bwaves_1.in"
cd /home/ines/v1_1_9/gcc/603 && run_copies "bwaves_2" "./bwaves_base bwaves_2" 128 "bwaves_2.in"

cd /home/ines/v1_1_9/gcc/607 && run_copies "cactuBSSN" "$cactuBSSN" 128

cd /home/ines/v1_1_9/gcc/619 && run_copies "lbm" "$lbm" 128

cd /home/ines/v1_1_9/gcc/621 && run_copies "wrf" "$wrf" 128

cd /home/ines/v1_1_9/gcc/628/base/th1 && run_copies "pop2" "$pop2" 128

cd /home/ines/v1_1_9/gcc/638 && run_copies "imagick" "$imagick" 128

cd /home/ines/v1_1_9/gcc/644 && run_copies "nab" "$nab" 128

cd /home/ines/v1_1_9/gcc/649 && run_copies "fotonik3d" "$fotonik3d" 128

cd /home/ines/v1_1_9/gcc/654 && run_copies "sroms" "$sroms" 128 "ocean_benchmark3.in.x"

cd /home/ines/v1_1_9/gcc/996 && run_copies "specrand" "$specrand" 128
