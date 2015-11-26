# Feedback E1
## Feedback entrega

### Casos de uso
* Bien.
* Parece que Word se les portó mal con las numeraciones en las listas.
* No se preocupen sobre detalles demasiados específicos como `De estar otra instancia de la aplicación iniciada se cierra.`

### Mockup
* Se ve como más orientado a una aplicación móvil. Se busca que sea para escritorio.
* Quizás enfocar más los items que pusieron a la izquierda a los recursos de la aplicación (como los puntos de interés, listado de facciones, etc).
* Hagan un mejor uso del espacio.

### Modelo de datos
* No les recomiendo la *herencia* en Rails.
* Les conviene hacer una `join_table` entre `Usuario` y `Facción`, ahí le pueden agregar un *booleando* que indique si es admin o no. Así se ahorran tablas adicionales.
* Quizás quitar el `Tipo de punto` (singular) y usar `tags`.
* Revisen bien como haran las tablas intermediaras entre los puntos de interes y los usuarios (para los checkins).
* Les faltó la entidad `Comentarios`.
* 
