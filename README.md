# Taller de splines

## Propósito

Estudiar algunos tipos de curvas paramétricas y sus propiedades.

## Tarea

Implemente las curvas cúbicas naturales, de Hermite y Bezier (cúbica y de grado 7), de acuerdo a las indicaciones del sketch adjunto.

*Sugerencia:* Como las curvas de Hermite y cúbica de Bezier requieren varias secciones, reacomode los puntos de control para que su continuidad sea C<sup>1</sup>. Ver [acá](https://visualcomputing.github.io/Curves/#/5/5) y [propiedad 4 de acá](https://visualcomputing.github.io/Curves/#/6/4).

## Profundización

Represente los _boids_ del [FlockOfBoids](https://github.com/VisualComputing/framesjs/tree/processing/examples/Advanced/FlockOfBoids) mediante superficies de spline.

## Integrantes

Máximo 3.

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
|Andres Rondon| [amrondonp](https://github.com/amrondonp)             |
|Raul Ramirez| [raulramirezp](https://github.com/raulramirezp)             |
|Juan Carlos Gama| [JuanCarlosUNAL](https://github.com/JuanCarlosUNAL)             |

## Ejecución

Se usó la libreria [Jblas](http://jblas.org/) para facilitar algunas operaciones algebraicas ( como hallar inversa de una matriz nxn ), la puede instalar como se describe en la página web oficial ó si usa linux:

*   Ubuntu: 
    ``` 
    sudo apt-get install jblas
    ```
*   Fedora: 
    ```
    sudo dnf install jblas
    ```


Una vez instalada la librería, procedemos a:

* Acceder a la carpeta del sketchbook y entrar el directorio *libraries*
* Allí crear los directorios recursivamente así: */org/jblas/library*
* Copiar el archivo jblas.jar a ese nuevo directorio.
* Si usa Linux se debería ver algo así: 
```
~/sketchbook/libraries/org/jblas/library/jblas.jar
```

El archivo jblas.jar se encuentra en en el directorio jblas adjunto.

## Conclusiones

* En la implementación del interpolador de Natural Cubic Splines, se tuvo dificultades a la hora de realizar la implementación, dado que en la literatura que se encuentra en internet, la mayoria de definiciones de esta se dan para interpolar una serie de puntos en 2D, e inicialmente se pensó que la generalización a 3D podría resultar más compleja, luego nos dimos cuenta que en realidad cada componente del nuevo punto en el espacio, calculado por el polimonio, era una implementación uni-dimensional. 

* Se pudo observar que la curva obtenida con el algoritmo de Natural Cubic Spline, era más apróximada a la generada por el algoritmo de Hermite.



## Entrega

* Modo de entrega: Haga [fork](https://help.github.com/articles/fork-a-repo/) de la plantilla e informe la url del repo en la hoja *urls* de la plantilla compartida (una sola vez por grupo). Plazo: 29/4/18 a las 24h.
