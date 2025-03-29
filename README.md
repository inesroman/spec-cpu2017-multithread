# Primera ejecución: speedup básico 
Este repositorio contiene todos los scripts de `/home/ines/v1_1_9` y sus resultados. Además, `/home/ines/v1_1_9` también contiene los ejecutables e inputs de los benchmarks.

He ejecutado el único benchmark de intspeed que es paralelizable con OMP (657.xz_s) y todos los de fpspeed (que son paralelizables con OMP), menos 627.cam4_s porque da segmentation fault y he visto en varios artículos que les ha pasado lo mismo.

En esta versión de SPEC CPU2017, no he compilado ni ejecutado los benchmarks de fprate e intrate.

## 1. Compilación 
La instalación de SPEC CPU2017 se encuentra en mi home, en `/home/ines/cpu2017`.

### GCC
Para la versión compilada con gcc, he usado el fichero de configuración que viene con SPEC llamado `Example-gcc-linux-x86.cfg`. Lo he copiado en `gcc.cfg` y le he cambiado el flag `-std=c++09` por `-std=c++14` y he añadido `-fallow-argument-mismatch`. No sé si estos son realmente necesarios, pero los añadí porque en la versión v1.0.9 de SPEC CPU2017 sí que lo eran. 

Esta configuración ha fallado en la compilación de tres aplicaciones en la versión peak, por lo que he creado el fichero de configuración `peak.cfg`, en el que he cambiado el flag `Ofast` por `O3`.

### AOCC
Para la versión compilada con aocc,  he usado el fichero de configuración que viene con SPEC llamado `Example-aocc-linux-x86.cfg` y  lo he copiado en `aocc.cfg`. La compilación y ejecución con esta configuración han funcionado para todas las aplicaciones excepto 621.wrf_s. Para esta, he tenido que eliminar el flag `-flto` y he guardado esta nueva configuración en `aocc_621.cfg`.

## 2. Ejecución
Este repositorio contiene todos los scripts de `/home/ines/v1_1_9` y sus resultados. Además, `/home/ines/v1_1_9` contiene los ejecutables e inputs de las aplicaciones.

### Setting up
1. Turbo boost. He apagado el Precision Boost para que no haga overclocking antes de ejecutar:
```
echo 0 | sudo tee /sys/devices/system/cpu/cpufreq/boost
```
2. Screen. He utilizado Screen para poder ejecutar el script y que se mantengan los procesos en ejecución aunque cierre la terminal.

3. Stack ilimitado. He ejecutado el siguiente comando antes de ejecutar el script para que el stack no tenga límite: 
```
ulimit -s unlimited
```

4. Multithreading. SMT está activado y divide los recursos dinámicamente entre los dos hilos de cada núcleo. Las parejas de hilos en el mismo núcleo son (0,64), (1,65), ..., (63,127). Por lo tanto, hasta la ejecución con 128 hilos, no hay hilos compartiendo un mismo núcleo.

### Resultados
De cada benchmark he ejecutado una sola copia con 1, 2, 4, ... y 128 hilos de cada uno de los ejecutables que he obtenido de cada aplicación: gcc base, aocc y gcc peak (excepto 628.pop2_s, que solo ha creado un ejecutable base al compilar con gcc). Los únicos benchmarks que no he podido ejecutar de esta manera han sido el segundo de la aplicación 657.xz_s (que solo llega hasta 15 hilos) y el de 654.srom_s (solo llega hasta 8).

Las ejecuciones han sido medidas con perf (por ahora solo ciclos e instrucciones) y los resultados se encuentran en los directorios `/home/ines/v1_1_9/gcc/results/speedup/base/perf`, `/home/ines/v1_1_9/gcc/results/speedup/peak/perf` y `/home/ines/v1_1_9/aocc/results/speedup/base/perf`.