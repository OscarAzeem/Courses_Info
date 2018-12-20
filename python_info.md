# Python
* Descripción de Utilidade en Python

## Entornos virtuales
* Crear entorno virtual: 
    * python -m venv projectname; (dónde projectname es el nombre del entorno virtual)
* Activar entorno virtual: 
    * LINUX:
        * source projectname/bin/activate
    * WINDOWS:
        * venv\Scripts\activate; (dónde venv es el nombre del entorno virtual creado en el paso arriba)
            * Once activated it will look like: 
            * (EnviromentCSVTOSQL) (base) C:\Users\xmy9080\Documents\Python_Scripts\CsvToSQL>
* ***Instalando ipykernel para asociar entornos virtuales con Jupyter notebooks***
    * pip install ipykernel
* Instalando un kernel dentro del entorno virtual:
    * ipython kernel install --user --name=projectname; (dónde projectname es el nombre del kernel) 
    
