# Primera ejecución: speedup básico 
La he ejecutado el benchmark de la aplicación 627.cam4_s porque da un segmentation fault y he visto en varios papers que les ha pasado lo mismo. 
He ejecutado el único benchmark de intspeed que es paralelizable con OMP y todos los de fpspeed (que son paralelizables con OMP).
Los benchmarks de fprate y intrate no los he compilado ni ejecutado en esta versión de SPEC CPU2017.

## Compilación 
La instalación de SPEC CPU2017 se encuentra en mi home, en `/home/ines/cpu2017`.
He usado el fichero de configuración que viene con spec llamado `Example-gcc-linux-x86.cfg`.
Lo he copiado en `gcc.cfg` y le he cambiado el flag -std=c++09 por -std=c++14 y he añadido -fallow-argument-mismatch. No sé si estos son realmente necesarios, pero los añadí porque en la
versión v1.0.9 de SPEC CPU2017 sí que hacían falta.

## Ejecución
Este repositorio contiene todos los scripts y resultados que hay en el directorio `/home/ines/v1_1_9`. Además, `/home/ines/v1_1_9` contiene los ejecutables e inputs de todos los benchmarks de fpspeed y de la aplicación 657.xz_s de intspeed.

### Setting up
1. Turbo boost
He apagado el precision boost para que no haga overcloking antes de ejecutar:
```
echo 0 | sudo tee /sys/devices/system/cpu/cpufreq/boost
```
2. Screen
He utilizado screen para ejecutar el script, para que se mantengan los procesos en ejecución aunque cierre la terminal.

3. Stack ilimitado
He ejecutado el siguiente comando antes de ejecutar el script para que el stack no tenga límite: 
```
ulimit -s unlimited
```

### Resultados
De cada benchmark he ejecutado una sola copia con 1, 2, 4, ... y 128 threads. Los únicos benchmarks que no he podido ejecutar de esta manera han sido el segundo de la aplicación 657.xz_s (que solo llega hasta 15 threads) y 654.srom_s (solo llega hasta 8). Las ejecuciones han sido medidas con perf (por ahora solo ciclos e intrucciones) y los resultados se encuentran en el directorio `/home/ines/v1_1_9/gcc/results/speedup/base/perf`.
