
POKEAPI:

Para ejecutar el programa simplemente hay que bajarse el repositorio y ejecutar con xcode el codigo

El programa muestra una tabla donde mediante una llamada a la api obtenemos diversos datos de los pokemons. La tabla contiene 14 pokemons por página, realizando otra llamada cada vez que se pulsa el botón. Están controlados los límites de pokemon por arriba y por abajo (el offset no puede ser menor que 0 ni mayor 1025, que es el último pokemon existente). Además, se ve una rueda de carga cuando el código está llamando a la api para mostrar visualmente el estado de carga (No siempre funciona no sé porque). Los errores de conexión con la api están controlados mediante un modal que se muestra en pantalla avisnado que no hay conexión. Este modal cuenta con un botón que realizará de nuevo la petición y la intentará mostrar. Finalmente, tocar algún elemento de la tabla podemos ver detalles extras de los pokemon, como la altura, el peso y los tipos, que se meustran mediante imagenes de la api de los tipos.

