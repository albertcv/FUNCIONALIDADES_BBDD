# FUNCIONALIDADES-de-la-APLICACI-N-masterchef
Crea las funciones o procedimientos adecuados que implementen las siguientes funcionalidades de la aplicación WEB MASTERCHEF (una vez probadas implementa un PACKAGE):     
1. (1pt) Mostrar los datos de la receta que tiene más estrellas, junto con el nombre de su chef, en un formato listado para imprimir, con titulo y forma visual agradable.     
2. (2pt) Crear triggers para que en las tablas que tengais un id que se va incrementando, se pueda realizar un insert sin informar este campo y el trigger lo informe.     
3. (2pt) Mostrar las 3 peores recetas, con sus ingredientes y nombre de chef, en un formato listado para imprimir, con titulo y forma visual agradable (podeis poner lineas con guiones, asteriscos.     
4. (1pt) Pedir al usuario una categoría, y que se le muestren todas las recetas de esa categoría.     
5. (1pt) Listar para cada CATEGORÍA las recetas que hay con la cantidad de ingredientes y unidad.      
6. (3pt) Preguntar al usuario EL NOMBRE DE UN CHEF Y MOSTRAR: 
  - Una cabecera:   NOMBRE CHEF y su total de RECETAS 
  - Para cada chef: Numerar las recetas y mostrar el nombre de la RECETA y sus ingredientes (nombre y tipo)Para cada chef, si tiene menos de tres recetas mostrar mensaje 'tienes que ser más creativo' y si tiene más de 3 recetas: 'Puedes pedir aumento de salario'. El formato del listado debe ser cuidado , para poderse imprimir podéis poner lineas decorativas o separadoras tipo ‘====’ o ‘-----      
8. (2pt) Insertar un nuevo chef, con un id que sea una unidad más del último id y resto de los datos pregunte al usuario. Desactivar el trigger del ejercicio 2, para poder ejecutarlo, poner las instrucciones de activar y desactivar    
9. (Trigger) (1pt) Realizar un log de las  altas/bajas/modificaciones que se han hecho en la tabla CHEF, que conste el usuario y la fecha y hora de la modificación. 
10. (Trigger) (2pt)  Realizar un trigger, que bloquee los Inserts e update’s en la tabla de evaluación para que no se pueda hacer evaluaciones para uno de los cocineros que elijáis.  
11. (2pt) Crear una función, un procedimiento y un trigger para la tabla que os inventasteis ( o una nueva). 
  - (6pt) Crear 3 programas más:     
  - (2pt) Uno que sea un trigger que dentro llame a una función/procedimiento     
  - (2pt) Otro con cursores     
  - (2pt) El tercero que sea un instead of o un compound trigger(a poder ser un poco diferente del que hemos hecho en clase).  

En todos los procedimientos se debe controlar las excepciones posibles, cada una  de forma individualizada (las que se pueden dar y que hayamos trabajado en clase, por ejemplo si nuestro programa realiza una consulta implicita, donde el where va por PK, no tiene sentido que tratéis TWO_MANY_ROWS, porque nunca se puede dar.). Los listados que se muestren deben estar formateados de forma que se pudieran imprimir y consultar en papel. Cada respuesta en un fichero de texto, si alguna pregunta tiene un listado, en el mismo fichero se debe adjuntar el resultado de la ejecución.
