# TP_Carbot
Diseñé y desarrollé CarBot, un sistema experto de arquitectura híbrida (Python/Prolog) para la recomendación vehicular y optimización logística. Integré validación formal mediante Máquinas de Turing, garantizando la integridad de los datos de entrada y la eficiencia computacional en procesos de búsqueda sobre grandes datasets. 
1. REQUISITOS DEL SISTEMA

Para ejecutar este proyecto correctamente, el entorno debe contar con:
- Python: Versión 3.11.9 (recomendada/utilizada en el desarrollo).
- SWI-Prolog: Debe estar instalado nativamente en el sistema operativo y 
  agregado a las variables de entorno (PATH) para que PySwip pueda encontrarlo.
- IDE: Visual Studio Code con la extensión de Jupyter instalada.

3. ARCHIVOS DEL PROYECTO

- app.ipynb      : Archivo principal (Jupyter Notebook) con la lógica en Python.
- carbotdef.pl   : Base de conocimientos y reglas lógicas en Prolog.
- Autosdef.csv   : Dataset con el inventario de vehículos.
- Autos.pdf      : Es de donde se obtiene el dataset. 
- README.txt     : Este archivo de instrucciones.
- Informe AlgLog : PDF que contiene el informe detallado del proyecto.

4. INSTRUCCIONES DE EJECUCIÓN

1. Abrir la carpeta del proyecto en Visual Studio Code.
2. Abrir el archivo "app.ipynb".
3. Asegurarse de seleccionar el Kernel de Python (3.11.9) en la esquina 
   superior derecha de VS Code.
4. Ejecutar las celdas de código de forma secuencial (o usar el botón 
   "Run All").

5. NOTA IMPORTANTE DE USO E INTERACCIÓN (LEER ANTES DE USAR)

Debido a la forma en que el entorno de Jupyter Notebook maneja los buffers de 
entrada y salida estándar (I/O) en comunicación con el subproceso de Prolog, 
es posible que note una particularidad durante el chat:

* Congelamiento de consola: A veces, después de ingresar un dato, la celda 
  parece quedarse esperando sin mostrar el texto del bot.
* Solución: Si el chat parece pausado, presionar [ENTER] 
  en la barra de input para forzar la actualización del buffer.
* Guía de Estados: Para evitar confusiones, el programa imprime siempre en 
  pantalla el estado actual del Autómata Finito entre corchetes 
  (por ejemplo: [preguntando_tipo] o [recomendando]). Guiarse por este indicador de etapa para saber qué está esperando el 
  sistema, más allá del texto impreso.
