# Apuntes de Postgre / PostGIS

<img src="https://i.imgur.com/GiKFsS3.jpg" text-align: center></div>

Por Rober J

[![](https://img.shields.io/badge/@programapa_-white?style=for-the-badge&labelColor=blue&logo=Twitter&logoColor=white)](https://twitter.com/programapa_)[![](https://img.shields.io/badge/PrograMapa-grey?style=for-the-badge&logo=wordpress)](https://programapa.wordpress.com)[![](https://img.shields.io/badge/Roberto-blue?style=for-the-badge&logo=linkedin)](https://linkedin.com/in/robertojl)


## 👷‍♀️ DDL - Lenguaje de definición de datos 

<details>
  <summary><strong>Introducción a las bases de datos</strong></summary><br>
<p>Una <strong>base de datos</strong> es un conjunto de información estructurada para poder acceder a ella fácilmente. En informática, la base de datos se almacena digitalmente y por medio de programas se accede a la información y se opera con ella. Su aspecto es el de una (o muchas) tabla:</p>
<figure ><table><thead><tr><th>Nombre del elemento</th><th >Barrio</th><th >Distrito</th><th >Fecha de instalación</th></tr></thead><tbody><tr><td >Farola</td><td >Acacias</td><td >Arganzuela</td><td >1995</td></tr><tr><td >Farola</td><td >Atocha</td><td >Arganzuela</td><td >1995</td></tr><tr><td >Buzón</td><td >Jerónimos</td><td >Retiro</td><td >2001</td></tr></tbody></table></figure>
<p>Para que la base de datos sea <strong>geográfica</strong> debe contar con información acerca de su <strong>posición </strong>en el espacio, es decir, debe representar alguna realidad territorial. Una posibilidad sería contar con dos columnas más: una para el dato de la coordenada X y otra para su coordenada Y:</p>
<figure ><table><thead><tr><th >Nombre del elemento</th><th >Barrio</th><th >Distrito</th><th >Fecha de instalación</th><th >Coordenada X</th><th>Coordenada Y</th></tr></thead><tbody><tr><td >Farola</td><td >Acacias</td><td >Arganzuela</td><td >1995</td><td >-3.704281</td><td>40.403497</td></tr><tr><td >Farola</td><td >Atocha</td><td >Arganzuela</td><td >1995</td><td >-3.692546</td><td>40.406163</td></tr><tr><td >Buzón</td><td >Jerónimos</td><td >Retiro</td><td >2001</td><td >-3.684449</td><td>40.407504</td></tr></tbody></table></figure>
<p>De este modo, con el programa adecuado es posible visualizar la información sobre un marco espacial en vez de quedarnos solo con la tabla. Bastará con conocer el sistema de referencia de las coordenadas (WGS 84 EPSG: 4326 en este caso) para que cada una de las filas se convierta en un punto posicionado en sus coordenadas, es decir, pueda <strong>representar su geometría</strong>. </p>
<p>El tamaño de las bases de datos puede ser tan grande que para  manipular la información se recurre a filtros complejos que afinen nuestras búsquedas y operaciones. En este contexto es donde suelen usarse los lenguajes de programación, tanto en programas <strong>gestores de bases de datos</strong> (SGBD) como Acess o Postgre como en Sistemas de Información Geográfica como QGIS. Entre estos lenguajes se encuentra <strong>SQL</strong>, diseñado específicamente para ser el lenguaje común de las bases de datos. </p>
<p><strong>PostgreSQL</strong>, o solo Postgre, es un software de código abierto de gestión de bases de datos que utiliza el <strong>lenguaje SQL</strong> para operar con la información, y entre sus virtudes está la de gestionar la <strong>información espacial</strong> o geometrías de los elementos almacenados en ella. </p>
<p>Para comenzar a usarlo, debemos <a rel="noreferrer noopener" href="https://www.postgresql.org/download/" target="_blank">descargarlo de su página principal</a>, familiarizarnos un poco con <strong>PgAdmin</strong>, la herramienta de Postgre que proporciona interfaz gráfica a nuestras bases de datos y desde la que se realizan la mayor parte de las operaciones, y aprender a <strong>manejar los aspectos fundamentales de SQL</strong>, los cuales trato en este post.</p>
<div ><figure ><img src="https://programapa.files.wordpress.com/2021/04/image-7.png?w=1024" alt=""  srcset="https://programapa.files.wordpress.com/2021/04/image-7.png?w=1024 1024w, https://programapa.files.wordpress.com/2021/04/image-7.png?w=150 150w, https://programapa.files.wordpress.com/2021/04/image-7.png?w=300 300w, https://programapa.files.wordpress.com/2021/04/image-7.png?w=768 768w, https://programapa.files.wordpress.com/2021/04/image-7.png 1366w" sizes="(max-width: 1024px) 100vw, 1024px" /><figcaption><em>Aspecto de pgAdmin</em></figcaption></figure>
<p>Sin embargo, para aplicar estas herramientas a la información geográfica para crear <strong>geodatabases</strong> y combinarlas con Sistemas de Información Geográfica como QGIS es necesario hacer uso de una <strong>extensión </strong>de Postgre llamada <strong>PostGIS </strong>que añade las funcionalidades necesarias para trabajar con esta clase de información y de las cuales hablo en otras entradas del blog.</p>
<div ><figure ><img loading="lazy" src="https://programapa.files.wordpress.com/2020/11/logo_square_postgis.png?w=300" alt="" width="193" height="193" srcset="https://programapa.files.wordpress.com/2020/11/logo_square_postgis.png?w=193 193w, https://programapa.files.wordpress.com/2020/11/logo_square_postgis.png?w=150 150w, https://programapa.files.wordpress.com/2020/11/logo_square_postgis.png 300w" sizes="(max-width: 193px) 100vw, 193px" /><figcaption><em>Logo oficial de PostGIS</em></figcaption></figure>
<p>Por<strong> último, la documentación oficial y otros enlaces de utilidad para Postgre, SQL y PostGIS los recopilo en el siguiente post junto a otros muchos recursos:</p>
<p><strong>⚠ Algunas cuestiones básicas como las claves primarias o la integridad de los datos aún no las he tratado en este post</strong>(proximamente)</p>
 
<br></details>
  
<details>
  <summary><strong>Tablas</strong></summary><br>
  
  <div ><figure ><img src="https://programapa.files.wordpress.com/2020/11/tablas.jpg?w=300" alt="" srcset="https://programapa.files.wordpress.com/2020/11/tablas.jpg?w=300 300w, https://programapa.files.wordpress.com/2020/11/tablas.jpg?w=600 600w, https://programapa.files.wordpress.com/2020/11/tablas.jpg?w=150 150w" sizes="(max-width: 300px) 100vw, 300px" /></figure>
<p >Las tablas son la estructura básica de almacenamiento de PostgreSQL y en general de los datos en las <a href="https://medium.com/@eugeniomendoza/c%C3%B3mo-saber-si-necesitas-una-base-de-datos-nosql-b6cfd5bb7d9b" target="_blank" rel="noreferrer noopener">bases de datos relacionales</a>.</p>
<p>Constan de dos elementos básicos: filas y columnas</p>
<figure ><table><thead><tr><th >ID</th><th >Elemento </th><th >Barrio</th><th >Fecha</th></tr></thead><tbody><tr><td >0001</td><td >Farola</td><td >Acacias</td><td >1995</td></tr><tr><td >0002</td><td >Farola</td><td >Atocha</td><td >1995</td></tr><tr><td >0003</td><td >Buzón</td><td >Jerónimos</td><td >2001</td></tr></tbody></table></figure>
<ul><li>Las <strong>filas </strong>son cada uno de los registros de la tabla, en este caso elementos urbanos.</li><li>Las <strong>columnas </strong>son los distintos datos que se almacenan de cada elemento, en este caso el barrio y distrito al que pertenecen junto a su fecha de instalación.</li></ul>
<p>Además las tablas cuentan también con <a rel="noreferrer noopener" href="https://programapa.wordpress.com/2020/09/24/restricciones-en-sql/" target="_blank">restricciones</a>, tanto para toda la tabla como para algunas de sus columnas.</p>
<p>Forman parte del lenguaje de definición de datos (DDL) de Postgre, es decir, de las herramientas SQL para armar la estructura de la base de datos como son también los <a href="https://programapa.wordpress.com/2020/09/22/lista-de-instrucciones-basicas-de-sql/">esquemas</a> o los <a href="https://programapa.wordpress.com/2020/11/05/dominios/">dominios</a></p>


<h3><strong>Crear tablas</strong></h3>
<p>En una base de datos PostgreSQL pueden crearse tantas tablas como se necesite. La <strong>sintaxis</strong> básica para ello es:</p>
<pre>
CREATE TABLE &#91;IF NOT EXISTS] esquema.nombre_tabla(
nombre_columna1 tipo(n) &#91;RESTRICCIÓN],
nombre_columna2 tipo(n) &#91;RESTRICCIÓN],
nombre_columna3 tipo(n) &#91;RESTRICCIÓN],
&#91;RESTRICCIÓN DE TABLA],
&#91;RESTRICCIÓN DE TABLA]
);
</pre>
<ul><li><strong>Crea una tabla</strong> especificando un nombre junto al esquema al que van a pertenecer.</li><li>Con IF NOT EXISTS comprueba que el nombre no esté repetido para poder crearla.</li><li>Entre paréntesis se especifica el nombre de la columna<em>, </em>el <a href="https://programapa.wordpress.com/2020/10/01/tipos-de-datos-en-sql/">tipo de dato</a> y su longitud (n), y las <a href="https://programapa.wordpress.com/2020/09/24/restricciones-en-sql/">restricciones</a> que tendrá cada columna o toda la tabla.</li></ul>
<p>Por ejemplo, para crear la tabla del inicio, haríamos lo siguiente: </p>
<pre>
CREATE TABLE miesquema.Urbanismo (
ID char(4) PRIMARY KEY,
Elemento varchar(15),
Barrio varchar(15),
Fecha date
);
</pre>

<h3><strong>Modificar tablas y columnas</strong></h3>
<p>Podemos cambiar las propiedades de la tabla o de algunas de sus columnas combinando ALTER TABLE con alguna sentencias según lo que queramos modificar:</p>

<h4><strong>Cambiar nombre a la tabla</strong></h4>
<pre>
ALTER TABLE &#91;IF EXISTS] tabla
 RENAME TO nuevo_nombre
</pre>
<p>IF EXISTS es opcional y evita que de error en caso de no existir la tabla (lo cual detendría toda la ejecución del código)</p>

<h4><strong>Cambiar nombre de la columna</strong></h4>
<pre>
ALTER TABLE tabla RENAME COLUMN columna TO nuevo_nombre
</pre>

<h4><strong>Asignar un nuevo esquema a la tabla</strong></h4>
<pre>
ALTER TABLE tabla SET SCHEMA nombre_esquema
</pre>

<h4>Añadir una nueva columna</h4>
<pre>
ALTER TABLE tabla ADD COLUMN nombre_columna tipo(n) &#91;RESTRICCIÓN]
</pre>
<p>Se indica su nombre, el <a href="https://programapa.wordpress.com/2020/10/01/tipos-de-datos-en-sql/">tipo de dato</a> y opcionalmente sus <a href="https://programapa.wordpress.com/2020/09/24/restricciones-en-sql/">restricciones</a></p>

<h4><strong>Eliminar columnas</strong></h4>
<pre>
ALTER TABLE tabla DROP COLUMN columna &#91;RESTRICT/CASCADE]
</pre>
<p>Con RESTRICT (por defecto) da error en caso de haber datos en las columnas.</p>
<p>CASCADE la borra aunque contenga datos.</p>

<h4><strong>Añadir y quitar expresiones asociadas a las columnas</strong></h4>
<pre>
ALTER TABLE tabla ALTER COLUMN columna SET DEFAULT expresión
</pre>

<h4><strong>Cambiar el tipo de dato que puede almacenar la columna indicada</strong></h4>
<pre>
ALTER TABLE tabla ALTER COLUMN columna &#91;SET DATA] TYPE tipo(n)
</pre>

<h4><strong>Quitar expresión de la tabla</strong></h4>
<pre>
ALTER TABLE tabla ALTER COLUMN columna DROP DEFAULT
</pre>

<h4><strong>Aceptar o no datos nulos</strong></h4>
<pre>
ALTER TABLE tabla ALTER COLUMN columna { SET / DROP } NOT NULL
</pre>

<h4><strong>Añadir una restricción para toda la tabla</strong></h4>
<pre>
ADD CONSTRAINT nombre_restricción RESTRICCIÓN
</pre>

<h4><strong>Añadir una restricción en una columna</strong></h4>
<pre>
ADD CONSTRAINT nombre_restricción RESTRICCIÓN(columna)
</pre>

<h4><strong>Borrar restricción</strong></h4>
<pre>
DROP CONSTRAINT nombre_restricción &#91; RESTRICT / CASCADE ]
</pre>
<p>Con RESTRICT (por defecto) da error en caso de haber datos dependientes de la restricción</p>
<p>CASCADE borra la restricción junto a los datos dependientes de ella</p>


<h3><strong>Borrar las tablas o su contenido</strong></h3>
<p>Se puede tanto borrar completamente una tabla como simplemente dejarla limpia usando las siguientes cláusulas:</p>

<h4><strong>Borrar una o varias tablas (separadas por comas y en ese orden)</strong></h4>
<pre>
DROP TABLE &#91;IF EXISTS] tabla &#91;, tabla2]&#91;RESTRICT / CASCADE]
</pre>
<p>Con IF EXISTS se evita error en caso de no existir.</p>
<p>Por defecto se ejecuta RESTRICT para dar error en caso de existir objetos dependientes de las tablas.</p>
<p>Si se indica CASCADE borrará todas las tablas dependientes.</p>

<h4><strong>Borrar todos los registros de la tabla sin modificar su estructura</strong></h4>
<pre>
TRUNCATE TABLE tabla &#91;RESTRICT / CASCADE]
</pre>
<p>Con RESTRICT (por defecto) se genera error en caso de existir claves externas que la hagan referencia.</p>
<p>CASCADE vacía todas las tablas conectadas por la clave externa.</p>
  
  
<br></details>
<details>
  <summary><strong>Esquemas</strong></summary><br>
  
  <div><figure ><img src="https://programapa.files.wordpress.com/2020/09/esquemas.jpg?w=300" alt="" srcset="https://programapa.files.wordpress.com/2020/09/esquemas.jpg?w=300 300w, https://programapa.files.wordpress.com/2020/09/esquemas.jpg?w=600 600w, https://programapa.files.wordpress.com/2020/09/esquemas.jpg?w=150 150w" sizes="(max-width: 300px) 100vw, 300px" /></figure>
<p>Los esquemas de PostgreSQL son conjuntos de datos o tablas propiedad de uno o varios usuarios de la base de datos.</p>
<p>Forman parte del lenguaje de definición de datos (DDL) de Postgre, es decir, de las herramientas SQL para crear y modificar los objetos que estructuran las bases de datos.</p>

<h3><strong>Crear un esquema</strong></h3>
<p>Basta con usar CREATE SCHEMA y asignarle un nombre:</p>
<pre>
CREATE SCHEMA nombre_esquema
</pre>

<h3><strong>Modificar un esquema</strong></h3>
<pre>
ALTER SCHEMA esquema RENAME TO nuevo_nombre
</pre>
<p>Cambiar el nombre del esquema</p>
<pre>
ALTER SCHEMA esquema OWNER TO nuevo_usuario
</pre>
<p>Cambiar el propietario del esquema</p>
<pre>
&#91;AUTHORIZATION usuario]
</pre>
<p>Especificar usuario propietario del nuevo esquema distinto al creador.</p>

<h3><strong>Borrar un esquema</strong></h3>
<pre>
DROP SCHEMA &#91;IF EXISTS] esquema &#91;RESTRICT / CASCADE]
</pre>
<p>Con IF EXISTS evitamos que se genere un error que detenga el proceso en caso de no existir el esquema.</p>
<p>Por defecto se ejecuta RESTRICT, generando un error en caso de existir información en el esquema.</p>
<p>Con CASCADE se elimina todo.</p>

  
<br></details>
<details>
  <summary><strong>Restricciones</strong></summary><br>
  
  <div><figure ><img src="https://programapa.files.wordpress.com/2020/09/constraints_sql-3.png?w=300" alt="" class="wp-image-3102" srcset="https://programapa.files.wordpress.com/2020/09/constraints_sql-3.png?w=300 300w, https://programapa.files.wordpress.com/2020/09/constraints_sql-3.png?w=150 150w, https://programapa.files.wordpress.com/2020/09/constraints_sql-3.png 383w" sizes="(max-width: 300px) 100vw, 300px" /></figure>
<p>Las restricciones de PostgreSQL son reglas que deben cumplir los datos para poder incorporarlos a las columnas que se encuentren bajo dicha restricción.</p>
<p>Con ellas podemos evitar que se inserten valores nulos, geometrías que no cumplan cierto estándar de calidad o datos que se excedan de los límites que les marquemos.</p>
<p>Existen restricciones que afectan a las columnas y otras que se aplican a toda una tabla.</p>

<p><a id="restriccion_columna"></a></p>
<h3><strong>Restricciones de columna</strong></h3>
<p >Afectan solo a la columna indicada.</p>
<figure ><table><tbody><tr><td>NOT NULL</td><td>No se admiten valores nulos en la columna. <br><br>Obliga a rellenar la fila con valores permitidos si quiere agregarse a la tabla.</td></tr><tr><td>UNIQUE</td><td>El dato de una celda no puede repetirse en la columna. <br><br>Funciona a modo de clave alternativa.</td></tr><tr><td>PRIMARY KEY</td><td>Establece que la columna es la clave primaria de la tabla, por lo que no podrá contener valores nulos ni valores repetidos.</td></tr><tr><td>REFERENCES <em>tabla</em>(<em>columna</em>)</td><td>Solo pueden introducirse en esa columna datos que ya existan previamente en otra <em>tabla.</em> <br><br>Si no se especifica la <em>columna </em>por defecto buscará en la otra tabla una columna con el mismo nombre que a la que se le aplica la restricción. </td></tr><tr><td>CHECK (<em>condiciones</em>)</td><td>Los valores que se introduzcan en la columna deberán cumplir las <em>condiciones </em>que se especifiquen mediante fórmulas matemáticas o lógicas booleanas (TRUE o FALE)</td></tr></tbody></table></figure>

<h3><strong>Restricciones de tabla</strong></h3>
<p >Afectan a toda la tabla o a varias de sus columnas. </p>
<figure ><table><tbody><tr><td>UNIQUE (columna1,columna2&#8230;)</td><td>No se permite que se repitan combinaciones de valores en las filas: si la fila 1 tiene valores <strong>ab </strong>la fila 2 tendrá que ser <strong>aa, bb, ba, bc&#8230; </strong>pero no <strong>ab.</strong></td></tr><tr><td>FOREIGN KEY (columna1,columna2&#8230;) REFERENCES tabla(columna1,columna2&#8230;)</td><td>Establece a las columnas indicadas como claves foráneas para otra tabla. <br><br>Si las columnas de la otra tabla se llaman igual no es necesario especificar el nombre de las columnas a las que referencia.</td></tr><tr><td>CHECK (condiciones)</td><td>La tabla debe ajustarse a las condiciones que se especifiquen mediante fórmulas matemáticas o lógicas booleanas (TRUE o FALSE)</td></tr><tr><td>PRIMARY KEY (columna1,columna2&#8230;)</td><td>Cuando queramos establecer como clave primaria una combinación de columnas, deberá usarse como restricción de tabla.</td></tr></tbody></table></figure>

<h3><strong>Crear una restricción de tabla</strong></h3>
<p>Existen dos maneras de crear una restricción:</p>
<ul><li>Añadir restricciones de tabla y de columna <a href="https://programapa.wordpress.com/2020/11/04/tablas/">en el momento de crear una tabla</a></li><li>Añadirlas posteriormente utilizando ALTER TABLE:</li></ul>

<h4><strong>Añadir restricción a una tabla</strong></h4>
<pre>
ALTER TABLE &#91; IF EXISTS ] tabla ADD CONSTRAINT nombre_restricción RESTRICCIÓN
</pre>

<h4><strong>Añadir restricción a una columna</strong></h4>
<pre>
ALTER TABLE &#91; IF EXISTS ] tabla ADD CONSTRAINT nombre_restricción RESTRICCIÓN (columna)
</pre>
<p>En ambos casos se le asigna un nombre a la restricción para poder identificarla fácilmente. Las restricciones existentes para una tabla pueden verse desde el menú lateral de pgAdmin.</p>

<h3><strong>Borrar una restricción de tabla</strong></h3>
<p>Para borrar una una restricción hay que usar la sentencia modificadora de tablas ALTER TABLE e indicar el nombre que el usuario le dio a la restricción que se va a borrar:</p>
<pre>
ALTER TABLE &#91; IF EXISTS ] tabla DROP CONSTRAINT nombre_restricción &#91; RESTRICT / CASCADE ]
</pre>
<p>Con IF EXISTS no da error en caso de no existir la tabla</p>
<p>Nombre_restricción es el nombre que el usuario le dio a la restricción</p>
<p>Con RESTRICT (por defecto) da error en caso de haber datos dependientes de la restricción. CASCADE borra la restricción junto a los datos dependientes de ella</p>
  
  
<br></details>
<details>
  <summary><strong>Dominios</strong></summary><br>
  
  <div ><figure ><img src="https://programapa.files.wordpress.com/2020/11/dominios.jpg?w=300" alt="" class="wp-image-2926" srcset="https://programapa.files.wordpress.com/2020/11/dominios.jpg?w=300 300w, https://programapa.files.wordpress.com/2020/11/dominios.jpg?w=600 600w, https://programapa.files.wordpress.com/2020/11/dominios.jpg?w=150 150w" sizes="(max-width: 300px) 100vw, 300px" /></figure>
<p >En PostgreSQL los dominios son <strong>conjuntos de <a href="https://programapa.wordpress.com/2020/09/24/restricciones-en-sql/">restricciones</a></strong> que se aplican a una serie de datos para adaptarlos a nuestras necesidades.</p>
<p>Forman parte del lenguaje de definición de datos (DDL) de Postgre, es decir, de las herramientas SQL para armar la estructura de la base de datos.</p>

<h3><strong>Crear dominios</strong></h3>
<pre>
CREATE DOMAIN nombre_dominio &#91;AS] tipo(n)
&#91;DEFAULT expresión]
&#91;CONSTRAINT nombre_restricción RESTRICCIÓN]
{ NOT NULL / NULL / CHECK (expresión) }
</pre>
<p><strong>Estructura para crear un nuevo dominio</strong> especificando un nombre de nuestra elección y el <a href="https://programapa.wordpress.com/2020/10/01/tipos-de-datos-en-sql/">tipo de datos</a> (float, text, date&#8230;) en el que se basará el dominio.</p>
<p>Con DEFULT establecemos la <em>expresión </em>que defina los valores por defecto de las columnas que operen bajo el nuevo dominio creado. Los valores deben coincidir con el tipo de datos especificado arriba. Si no se especifica, el valor por defecto será NULL.</p>
<p>Mediante CONSTRAINT asignamos <a href="https://programapa.wordpress.com/2020/09/24/restricciones-en-sql/">restricciones</a> y opcionalmente un nombre a la restricción de tabla.</p>
<p>Con NULL y NOT NULL se indica si se aceptan valores nulos o no (por defecto los acepta)</p>
<p>CHECK nos permite establecer una expresión booleana (verdadero o falso) para lanzar un error en caso de que no se cumplan los requisitos establecidos al actualizar un campo de acuerdo a la restricción.</p>

<h3><strong>Modificar Dominos</strong></h3>
<p>Para modificar un dominio debe combinarse ALTER DOMAIN con alguna cláusulas en función de lo que queramos modificar:</p>

<h4><strong>Indicar al dominio un nuevo valor por defecto o eliminarlo</strong></h4>
<pre>
ALTER DOMAIN dominio
 { SET DEFAULT expresión / DROP DEFAULT }
</pre>
<p>No afecta a los registros ya creados.</p>
<p>DROP DEFAULT borra el valor por defecto.</p>

<h4><strong>Borra una restricción de dominio </strong></h4>
<pre>
ALTER DOMAIN dominio
 DROP CONSTRAINT &#91; IF EXISTS ] restricción &#91; RESTRICT / CASCADE]
</pre>
<p>Da opción a que salga error si hay objetos dependientes con RESTRICT o que por el contrario los borre con CASCADE.</p>

<h4><strong>Cambiar el nombre de una restricción</strong></h4>
<pre>
ALTER DOMAIN dominio
 RENAME CONSTRAINT restricción TO nuevo_nombre
</pre>

<h4><strong>Cambia al propietario del dominio a uno nuevo, al actual o al que inicie sesión</strong></h4>
<pre>
ALTER DOMAIN dominio
 OWNER TO { nuevo_usuario / CURRENT_USER / SESSION_USER }
</pre>

<h4><strong>Cambia el que se acepten o no valores nulos</strong></h4>
<pre>
ALTER DOMAIN dominio
 { SET / DROP } NOT NULL
</pre>

<h4><strong>Añade una nueva restricción al dominio</strong> siguiendo la estructura de CREATE DOMAIN</h4>
<pre>
ALTER DOMAIN dominio
 ADD restricción
</pre>

<h4><strong>Cambia el nombre del dominio</strong></h4>
<pre>
ALTER DOMAIN dominio
 RENAME TO nuevo_nombre
</pre>

<h4><strong>Cambia el esquema al que pertenece el dominio</strong></h4>
<pre>
ALTER DOMAIN dominio
 SET SCHEMA nuevo_esquema
</pre>

<h3><strong>Borrar dominios</strong></h3>
<pre><code>DROP DOMAIN &#091; IF EXISTS ] dominio &#091;,dominio2] &#091; CASCADE / RESTRICT ]</code></pre>
<p>Se pueden borrar varios dominios separándolos por comas y en ese orden</p>
<p>Con IF EXISTS (solo en PostgreSQL) se evita error en caso de no existir.</p>
<p>Por defecto se ejecuta RESTRICT para dar error en caso de existir objetos dependientes del dominio. CASCADE borra todos los objetos dependientes del dominio.</p>
  
<br></details>
<details>
  <summary><strong>Tipos de datos</strong></summary><br>
  
  <div><figure ><img src="https://programapa.files.wordpress.com/2020/10/elefentesql-copia-2.jpg?w=300" alt="" class="wp-image-3113" srcset="https://programapa.files.wordpress.com/2020/10/elefentesql-copia-2.jpg?w=300 300w, https://programapa.files.wordpress.com/2020/10/elefentesql-copia-2.jpg?w=150 150w, https://programapa.files.wordpress.com/2020/10/elefentesql-copia-2.jpg 535w" sizes="(max-width: 300px) 100vw, 300px" /></figure>
<p>Cada columna en una base de datos de <strong>PostgreSQL </strong>puede almacenar un tipo de dato concreto que debe ser especificado en función de la clase de información que queramos introducir. </p>
<p>La elección del tipo de dato debe hacerse en el proceso inicial del diseño de la base de datos. Ahorrará espacio en disco, agilizará las consultas y operaciones y evitará engorrosas modificaciones a posteriori.</p>

<h3><strong>Caracteres y texto</strong></h3>
<figure ><table><thead><tr><th>Tipo</th><th>Tamaño</th><th>Descripción</th></tr></thead><tbody><tr><td>char(n)</td><td>n bytes</td><td>Reserva espacio en disco para almacenar &#8216;n&#8217; caracteres (entre 1 y 8000) según la codificación usada.</td></tr><tr><td>varchar(n)</td><td>n bytes</td><td>Almacena hasta n caracteres según la codificación sin reservar espacio para ello.</td></tr><tr><td>text</td><td>1 &#8211; 2.147.483.647 bytes</td><td>Puede almacenar texto hasta el límite en bytes permitido.</td></tr></tbody></table><figcaption><em>❗ este tipo de datos debe introducirse &#8216;entrecomillado&#8217;</em></figcaption></figure>

<h3><strong>Números enteros</strong></h3>
<figure ><table><tbody><tr><td>smallint</td><td>2 bytes</td><td>Valores entre -32.768 y 32767</td></tr><tr><td>int</td><td>4 bytes</td><td>Valores entre -2.147.483.648 y 2.147.483.647</td></tr><tr><td>bigint</td><td>8 bytes</td><td>Valores entre 2<sup>-63</sup> y  2<sup>63</sup>&nbsp;</td></tr><tr><td>serial</td><td>4 bytes</td><td>Valores autoincrementables entre -2.147.483.648 y 2.147.483.647</td></tr></tbody></table></figure>

<h3><strong>Números decimales</strong></h3>
<figure ><table><tbody><tr><td>numeric(p,s)</td><td>Variable</td><td>Almacena &#8216;p&#8217; dígitos (precisión) de los cuales &#8216;s&#8217; son decimales (escala)<br>Son valores exactos, ideales para el cálculo.</td></tr><tr><td>real</td><td>4 bytes</td><td>Almacena números reales con hasta 6 posiciones decimales.<br>Valores inexactos.</td></tr><tr><td>float8<br>double precision</td><td>8 bytes</td><td>Almacena números reales con hasta 15 posiciones decimales.<br>Valores inexactos.</td></tr></tbody></table></figure>

<h3><strong>Fechas</strong></h3>
<figure ><table><tbody><tr><td>date</td><td>4 bytes</td><td>Fechas en  calendario gregoriano</td></tr><tr><td>time</td><td>8 bytes</td><td>Almacena la hora con resolución de microsegundo</td></tr><tr><td>timestamp</td><td>8 bytes</td><td>Fecha y hora entre el 4713 a.C. y 294276 d.C. </td></tr><tr><td>timestampz</td><td>8 bytes</td><td>Fecha y hora incluyendo zona horaria entre el 4713 a.C. y 294276 d.C.</td></tr></tbody></table><figcaption><em>❗ este tipo de datos debe introducirse &#8216;entrecomillado&#8217;</em></figcaption></figure>

<h3><strong>Valores lógicos (booleanos)</strong></h3>
<figure ><table><tbody><tr><td>boolean</td><td>1 bit</td><td>Valores que se convierten a TRUE (1, yes, t, y, true) o a FALSE (0, no, f, n, false)</td></tr></tbody></table></figure>

<h3><strong>Geometrías (solo con PostGIS)</strong></h3>
<figure ><table><tbody><tr><td>geometry(tipo, SRC)</td><td>Variable</td><td>Almacena objetos geométricos simples (<em>Simple Feature</em>)<br><br>El <a href="https://programapa.wordpress.com/2020/11/06/tipos-de-datos-espaciales/">tipo</a> puede ser POINT, MULTIPOINT, LINESTRING, MULTILINESTRING, POLYGON y MULTIPOLYGON<br><br>SRC es el código del <a rel="noreferrer noopener" href="https://spatialreference.org/" target="_blank">sistema de referencia</a></td></tr><tr><td>topogeometry(tipo, SRC, tolerancia)</td><td>Variable</td><td>Almacena objetos topogeométricos<br><br>Al igual que las geometrías, su <a href="https://programapa.wordpress.com/2020/11/06/tipos-de-datos-espaciales/">tipo</a> puede ser también POINT, MULTIPOINT, LINESTRING, MULTILINESTRING, POLYGON y MULTIPOLYGON y también requieren de un <a rel="noreferrer noopener" href="https://spatialreference.org/" target="_blank">sistema de referencia</a><br><br>Sin embargo, la topogeometría requiere de una tolerancia clúster para realizar los cálculos. Su valor se dará en unidades del sistema</td></tr></tbody></table></figure>
  
<br></details>
<details>
  <summary><strong>Operadores</strong></summary><br>
  
  <div><figure ><img src="https://programapa.files.wordpress.com/2020/10/elefentesql-copia.jpg?w=300" alt="" class="wp-image-3110" srcset="https://programapa.files.wordpress.com/2020/10/elefentesql-copia.jpg?w=300 300w, https://programapa.files.wordpress.com/2020/10/elefentesql-copia.jpg?w=150 150w, https://programapa.files.wordpress.com/2020/10/elefentesql-copia.jpg 535w" sizes="(max-width: 300px) 100vw, 300px" /></figure>
<p>Los operadores son usados en las consultas de <strong>PostgreSQL </strong>para manipular los datos de la base de datos. Permiten filtrar la información para obtener solo los registros que necesitamos y hacer operaciones con ellos.</p>

<h3><strong>Operadores aritméticos</strong></h3>
<p>Llevan a cabo operaciones matemáticas. El resultado es siempre un número.</p>
<figure ><table><thead><tr><th>Operador</th><th>Descripción</th><th>Ejemplo</th><th>Resultado</th></tr></thead><tbody><tr><td>+</td><td>Suma</td><td>5 + 3</td><td>8</td></tr><tr><td>&#8211;</td><td>Resta</td><td>2 &#8211; 2</td><td>0</td></tr><tr><td>*</td><td>Multiplicación</td><td>7 * 3</td><td>21</td></tr><tr><td>/</td><td>División</td><td>9 / 3</td><td>3</td></tr><tr><td>^</td><td>Elevación</td><td>6 ^ 2</td><td>36 (6*6)</td></tr><tr><td>%</td><td>Módulo: resto de una división entera</td><td>20 % 3<br></td><td>2 (20/3=18)</td></tr><tr><td>|/</td><td>Raíz cuadrada</td><td>|/ 81</td><td>9 (9*9=81)</td></tr><tr><td>||/</td><td>Raíz cúbica</td><td>||/125</td><td>5 (5*5*5=125)</td></tr><tr><td>!</td><td>Factorial</td><td>4!</td><td>24 (1*2*3*4)</td></tr><tr><td>!!</td><td>Factorial (prefijo)</td><td>!!4</td><td>24 (1*2*3*4)</td></tr><tr><td>@</td><td>Valor absoluto</td><td>@ -25<br>@25</td><td>25</td></tr></tbody></table></figure>
<p>Cuando varios operadores se encuentran dentro de una misma expresión, se ejecutan siguiendo un orden, denominado <strong>precedencia de operadores</strong>:</p>
<ol><li>Lo que se encuentre entre paréntesis () </li><li>Multiplicaciones, divisiones y módulos</li><li>Sumas y restas</li><li>Izquierda a derecha cuando exista igualdad de importancia</li></ol>

<h3><strong>Operadores de comparación</strong></h3>
<p>Comprueban si dos valores son iguales o arrojan el mismo resultado. Los resultados de los operadores de comparación son valores true o false dependiendo de si se cumple la comparación o no.</p>
<figure ><table><thead><tr><th>Operador</th><th>Descripción</th><th>Ejemplo </th><th><strong>Resultado</strong></th></tr></thead><tbody><tr><td>=</td><td>Igual que </td><td>1 + 2 = 3</td><td><span class="uppercase">true</span></td></tr><tr><td>!=</td><td>Distinto que</td><td>25 != 5 * 5</td><td>FALSE</td></tr><tr><td>&lt;&gt;</td><td>Distinto que (estándar)</td><td>25 &lt;&gt; 5 * 5</td><td>FALSE</td></tr><tr><td>&lt;</td><td>Menor que</td><td>7  &lt; 10</td><td>TRUE</td></tr><tr><td>&gt;</td><td>Mayor que</td><td>7 &gt; 10</td><td>FALSE</td></tr><tr><td>&lt;=</td><td>Menor o igual que</td><td>7 &lt;= 5</td><td>FALSE</td></tr><tr><td>&gt;=</td><td>Mayor o igual que</td><td>7 &lt;= 7</td><td>TRUE</td></tr><tr><td>!&lt;</td><td>No es menor que</td><td>9 !&lt; 8</td><td>TRUE</td></tr><tr><td>!&gt;</td><td>No es mayor que</td><td>9 !&gt; 7</td><td>FALSE</td></tr></tbody></table></figure>

<h3><strong>Operadores lógicos</strong></h3>
<p>Comprueban si una o varias expresiones son verdad o no. Su resultado son valores true o false. </p>
<p>Daremos los ejemplos con una tabla hipotética con los municipios de España, su población, la provincia y la comunidad autónoma a la que pertenecen.</p>
<figure ><table><thead><tr><th>Operador</th><th>Descripción</th><th>Ejemplo </th><th>Resultado</th></tr></thead><tbody><tr><td>ALL</td><td>TRUE cuando todas las expresiones son TRUE</td><td>(provincia = Zaragoza) ALL (población &lt; 2M)</td><td>TRUE (todos los municipios de Zaragoza tienen menos de 2M de habitantes)</td></tr><tr><td>AND</td><td>TRUE si dos expresiones son TRUE</td><td>(provincia = Zamora) AND (población &gt; 1M)</td><td>FALSE (Zamora existe pero no tiene ningún municipio con 1M de habitantes)</td></tr><tr><td>ANY/SOME</td><td>TRUE para los valores que coinciden con la consulta</td><td>10000 &lt; ANY (población)</td><td>TRUE para todos los municipios con más de 10000 habitantes</td></tr><tr><td>BETWEEN</td><td>TRUE para los valores dentro de un rango</td><td>población BETWEEN 1000 AND 10000</td><td>TRUE para los municipios que tengan entre 1000 y 10000 habitantes</td></tr><tr><td>EXISTS</td><td>TRUE cuando existe el valor en la base de datos</td><td>EXISTS Teruel</td><td>TRUE (Teruel existe)</td></tr><tr><td>IN</td><td>TRUE cuando los datos de un campo se encuentran en la lista</td><td>Provincia IN (&#8216;Jaén&#8217;,&#8217;Granada&#8217;)</td><td>TRUE para todos los municipios de Jaen y Granada.</td></tr><tr><td>NOT </td><td>TRUE cuando no se cumpla la condición. Invierte operadores como LIKE, IN, BETWEEN, EXISTS, IS&#8230;</td><td>NOT (población &gt; 10000)</td><td>TRUE para todos aquellos municipios con menos de 10000 habitantes.</td></tr><tr><td>OR </td><td>TRUE cuando al menos una expresión sea verdadera</td><td>(población &gt;= 5M) OR (provincia = Madrid)</td><td>TRUE. Pese a que ningún municipio de España tiene más de 5M de habitantes, existe la provincia de Madrid.</td></tr><tr><td>IS NULL<br></td><td>TRUE cuando exista algún en el registro. Puede combinarse con NOT.</td><td>Provincia IS NOT NULL</td><td>TRUE porque todos los municipios tendrán asignada una provincia.</td></tr></tbody></table></figure>

<h3><strong>Operadores de cadenas de caracteres</strong></h3>
<p>Permiten operar con texto o cadenas de caracteres, llamadas <em>string</em> en jerga informática.</p>
<figure ><table><thead><tr><th>Operador</th><th>Descripción</th><th>Ejemplo</th><th>Resultado</th></tr></thead><tbody><tr><td>+</td><td>Concatena texto</td><td>&#8216;Corre&#8217; + &#8216;caminos&#8217;</td><td>Correcaminos</td></tr><tr><td>||</td><td>Concatena texto con otros datos que no sean text</td><td>&#8216;Valor: &#8216; || 200</td><td>Valor: 200</td></tr><tr><td>substr</td><td>Extrae subcadenas de texto indicando posiciones.</td><td>substr(&#8216;Correcaminos&#8217;, 0,1,2,3,4)</td><td>Corre</td></tr><tr><td>LIKE</td><td>Compara fragmentos de texto y devuelve TRUE en caso de coincidencia</td><td>municipio LIKE &#8216;Alm&#8217;</td><td>True para municipios que contengan &#8216;alm&#8217; en su nombre: Almería, Almunia&#8230;</td></tr></tbody></table></figure>
  
<br></details>
<details>
  <summary><strong>Índices</strong></summary><br>
  
  <div><figure ><img src="https://programapa.files.wordpress.com/2020/10/indices-postgresql-1.png?w=266" alt="" class="wp-image-2137" srcset="https://programapa.files.wordpress.com/2020/10/indices-postgresql-1.png 266w, https://programapa.files.wordpress.com/2020/10/indices-postgresql-1.png?w=150 150w" sizes="(max-width: 266px) 100vw, 266px" /></figure>
<p>En PostgreSQL los índices son una selección de columnas de una tabla que hacen referencia a todos sus registros. Lo que se consigue con ello es reducir los tiempos de consulta, puesto que en vez de leer toda la tabla se leerá solo el índice, y éste referenciará el resto de campos de la tabla.</p>
<p>Si por ejemplo tenemos una base de datos geográficos para el sistema inteligente de una gran ciudad (Smart City) y queremos encontrar los datos de un solo tipo de bombillas que supondrían solo un 5% del total de miles que puede haber repartidas por toda la ciudad, con un índice en base a los tipos de bombilla nuestra consulta no tendría que recorrer toda la tabla, sino que se centraría en la columna de los tipos de bombilla y a partir de ahí sacaría todos los datos de las que coincidiesen.</p>
<p>Hay que tener en cuenta que los índices <strong>ocupan espacio en disco</strong>, así que no hay que volverse loco creyendo que con muchos índices nos irá todo más rápido porque puede ir en nuestra contra, además de que deben ser actualizados.</p>

<h3><strong>Crear un índice</strong></h3>
<p>PostgreSQL crea automáticamente un índice sobre el campo asignado como Primary Key. Este índice se llamará indice primario, pero pueden crearse más índices dependiendo del campo o expresión a la que queramos tener un acceso más rápido.</p>
<p>La sintaxis para crear un índice en PostgreSQL es la siguiente:</p>
<pre>
CREATE INDEX &#91;IF NOT EXISTS] nombre_del_índice 
ON tabla USING método
(columnas o expresión) 
TABLESPACE pg_default;
</pre>
<p><strong>CREATE INDEX </strong>es la sentencia básica para crear el índice y asignarle un nombre</p>
<p><strong>IF NOT EXISTS</strong> impide que salte error en caso de existir un índice con el mismo nombre que le estamos dando</p>
<p><strong>ON </strong>especifica la tabla de la que se va a hacer el índice</p>
<p><strong>USING</strong> asigna un <strong>método </strong>de indexación a la columna seleccionada o al resultado de una expresión que definamos</p>
<p><strong>TABLESPACE</strong> identifica el lugar donde se almacenará el índice. pg_default es el predeterminado de Postgre.</p>

<h3><strong>Métodos de indexación</strong></h3>
<p>Es el algoritmo que usa PostgreSQL para crear el índice. Si no se especifica ninguno será <strong>btree </strong>por defecto, que es el más común y que se adapta a la mayoría de situaciones.</p>
<p>Para bases de datos espaciales el que más nos interesa es <strong>gist</strong>. Recomiendo echar un vistazo al <a rel="noreferrer noopener" href="https://www.postgresql.org/docs/current/indexes-types.html" target="_blank">artículo sobre indexación espacial</a> de GeoTalleres y a <a rel="noreferrer noopener" href="http://www.sigdeletras.com/2019/creacion-de-indices-con-postgresql-postgis/" target="_blank">este otro artículo</a> sobre el uso de este tipo de índice, pero en resumidas cuentas para indexar geometrías gist es más rápido que b-tree y evita que en caso de existir geometrías muy complejas se supere el tamaño máximo que permite Postgre para un índice.</p>
<p>En la documentación oficial se detallan los<a rel="noreferrer noopener" href="https://www.postgresql.org/docs/current/indexes-types.html" target="_blank"> distintos tipos o métodos de indexación.</a> </p>

<h3><strong>Usar un índice</strong></h3>
<p>Una vez creado el índice, cuando hagamos consultas sobre esa tabla el propio Postgre lo usará para recorrerla.</p>
<p>Puede comprobarse la diferencia en tiempo de procesado de usar o no un índice mediante <strong>EXPLAIN ANALYSE</strong>, una función que devuelve el plan de ejecución de una consulta sin realizarla. Bastaría con usarlo en una consulta antes de crear el índice y volverlo a usar una vez creado.</p>

<h3><strong>Borrar un índice</strong></h3>
<p>Para borrar un índice basta con usar <strong>DROP INDEX:</strong></p>
<pre>
DROP INDEX nombre_del_índice
</pre>
  
<br></details>
<details>
  <summary><strong>Secuencias y serials</strong></summary><br>
  <div><figure ><img src="https://programapa.files.wordpress.com/2020/10/serials_sql.jpg?w=300" alt="" class="wp-image-2275" srcset="https://programapa.files.wordpress.com/2020/10/serials_sql.jpg?w=300 300w, https://programapa.files.wordpress.com/2020/10/serials_sql.jpg?w=600 600w, https://programapa.files.wordpress.com/2020/10/serials_sql.jpg?w=150 150w" sizes="(max-width: 300px) 100vw, 300px" /></figure>
<p>Las secuencias en <strong>PostgreSQL</strong> son una herramienta para generar números enteros sin que se repita ninguno. Estos números se asignan a campos numéricos que habitualmente son clave primaria o serials.</p>
<p>Si por ejemplo inventariamos los cientos de ejemplares de árbol que puede haber en un monte no vamos a darle un nombre único a cada uno, echaríamos mano de una secuencia para que a cada árbol que metamos en la base de datos se le asigne un ID único.</p>

<h3><strong>Crear secuencias</strong></h3>
<p>La sintaxis para crear secuencias es la siguiente:</p>
<pre>
CREATE SEQUENCE nombre_secuencia
&#91;START WITH x]
&#91;INCREMENT BY n]
&#91;MAXVALUE y]
&#91;MINVALUE z]
&#91;CYCLE];
</pre>
<ul><li><strong>CREATE SEQUENCE</strong> es la sentencia para crear la secuencia y asignarle el nombre que queramos</li><li><strong>START WITH</strong> asigna un valor X de tipo entero desde el que empezar</li><li><strong>INCREMENT BY</strong> asigna un valor N de tipo entero que se sumará al anterior</li><li><strong>MAXVALUE</strong> y <strong>MINVALUE</strong> establece los valores enteros máximo y mínimo que tendrá la secuencia</li><li><strong>CYCLE</strong> señala que la secuencia se repetirá una vez llegue al máximo</li></ul>

<p>Los parámetros anteriores pueden omitirse para tomar los siguientes <strong>valores por defecto</strong>:</p>
<ul><li>START WITH 1</li><li>INCREMENT BY 1</li><li>MIN VALUE -9223372036854775808</li><li>MAX VALUE 9223372036854775807</li><li>No se repetirá una vez alcance el máximo</li></ul>
<p>Se puede <strong>conocer cuál será el siguiente valor</strong> de la secuencia con NEXTVAL y usarlo para <strong>insertarlo</strong> en un nuevo registro.</p>
<p>Averiguar el siguiente valor de una secuencia:</p>
<pre>
SELECT NEXTVAL('nombre_secuencia');
</pre>
<p>Insertar un nuevo registro en el que el valor de la primera columna será el del siguiente de la serie:</p>
<pre>
INSERT INTO tabla
VALUES (nextval('nombre_serie'), valor_columna2...);
</pre>
<p>En este ejemplo creamos una tabla con ríos en la que a cada uno se le asigna un ID en base a una serie:</p>
<pre>
CREATE TABLE rios(
ID integer DEFAULT nextval('serie'),
nombre varchar(30),
longitud numeric
)
</pre>

<h3><strong>Modificar una secuencia</strong></h3>
<p>Al modificar una sentencia solo se alteran los siguientes valores que surjan de ella, no los ya creados. La sintaxis es:</p>
<pre>
ALTER SEQUENCE nombre_secuencia
&#91;START WITH x]
&#91;INCREMENT BY n]
&#91;MAXVALUE y]
&#91;MINVALUE z]
&#91;CYCLE];
</pre>

<h3><strong>Borrar una secuencia</strong></h3>
<p>Para borrar una secuencia la sintaxis es la siguiente:</p>
<pre>
DROP SEQUENCE nombre_secuencia &#91;CASCADE];
</pre>
  
<br></details>
<details>
  <summary><strong>Vistas de datos</strong></summary><br>
  
  <div><figure><img src="https://programapa.files.wordpress.com/2020/10/elefante-tv.png?w=150" srcset="https://programapa.files.wordpress.com/2020/10/elefante-tv.png?w=150 150w, https://programapa.files.wordpress.com/2020/10/elefante-tv.png 271w" sizes="(max-width: 150px) 100vw, 150px" /></figure>
<p>Las vistas son una herramienta de <strong>PostgreSQL</strong> para almacenar consultas de información y visualizarlas modo de tabla virtual sin alterar en ningún momento la información de la base de datos.</p>
<p>Son muy útiles porque permiten visualizar conjuntos de datos de forma rápida sin alterar la información, permitiendo ocultarla o mostrarla según nuestra consulta. </p>
<p>También sirven para almacenar esas consultas, especialmente si son complejas, y acceder a ellas en todo momento, mejorando nuestra productividad.</p>
<p>Por último, pueden usarse para dar permisos a otros usuarios de solo visualización, evitando así que puedan modificar los datos.</p>
<p>A través de las funciones <a href="https://programapa.wordpress.com/2020/10/15/consultar-y-agregar-atributos-en-postgresql/">SELECT</a> y <a href="https://programapa.wordpress.com/2020/10/19/combinar-registros-de-tablas-diferentes-en-postgresql-con-join/">JOIN</a> entre otras podrán mostrar tanto conjuntos de filas y columnas de una taba como de varias tablas y resúmenes estadísticos. Así mismo también pueden combinarse las vistas entre sí y con otras tablas.</p>

<h3><strong>Crear vistas</strong></h3>
<p>Tan solo hay que seleccionar un conjunto de datos con <strong>CREATE VIEW</strong>:</p>
<pre>
CREATE VIEW nombre_vista as
SELECT &#91;sentencias select];
</pre>
<p>Se recomienda que los nombres de las vistas sean fácilmente identificables, añadiendo prefijos o sufijos como »vista» a la descripción de la misma.</p>
<p>Para <strong>crear una vista a partir de otra</strong> <strong>vista</strong>, bastaría con referirse a ella al momento de crearla:</p>
<pre>
CREATE VIEW nombre_vista2 as 
SELECT columna1, columna2 FROM nombre_vista1;
</pre>

<h3><strong>Visualizar datos de las vistas</strong></h3>
<p>Visualizarlo siempre que queramos con <a href="https://programapa.wordpress.com/2020/10/15/consultar-y-agregar-atributos-en-postgresql/">SELECT</a>, ya sea toda la vista o solo ciertas columnas o registros:</p>
<pre>
-- Selecciona toda la vista
SELECT * FROM nombre_vista;
-- Selecciona las columnas 1 y 2 de la vista
SELECT columna1, columna2 FROM nombre_vista;
-- Devuelve el valor máximo de la columna 3 de la vista
SELECT MAX(columna3) FROM nombre_vista;
</pre>

<h3><strong>Borrar una vista</strong></h3>
<p>Las vistas se borran con <strong>DROP VIEW</strong>:</p>
<pre>
DROP VIEW nombre_vista
</pre>
  
<br></details>
<details>
  <summary><strong>Funciones</strong></summary><br>
  
  <div><figure ><img src="https://programapa.files.wordpress.com/2020/10/funciones_sql-1.jpg?w=300" alt="" srcset="https://programapa.files.wordpress.com/2020/10/funciones_sql-1.jpg?w=300 300w, https://programapa.files.wordpress.com/2020/10/funciones_sql-1.jpg?w=600 600w, https://programapa.files.wordpress.com/2020/10/funciones_sql-1.jpg?w=150 150w" sizes="(max-width: 300px) 100vw, 300px" /></figure>
<p>Las funciones en <strong>PostgreSQL </strong>son sentencias predefinidas por el usuario para no tener que repetir el mismo código una y otra vez. Con una vez que sean definidas tan solo habrá que introducir en el futuro las nuevas variables que serán aplicadas a dicha función.</p>
<p>Si por ejemplo solemos consultar en nuestra geodatabase los usos de suelo de España por provincias, no será necesario andar reescribiendo o copiando y pegando la misma consulta  una y otra vez, sino que podemos definir una función en la que tan solo introduciendo el nombre de la provincia que necesitemos.</p>
<p>PostgreSQL cuenta con <strong>funciones propias</strong> que <a rel="noreferrer noopener" href="https://www.postgresql.org/docs/13/functions.html" target="_blank">se detallan en la documentación oficial</a>, entre ellas las funciones de agregado que vemos en la entrada <a href="https://programapa.wordpress.com/2020/10/15/consultar-y-agregar-atributos-en-postgresql/">consultar y agregar atributos</a>. Conocerlas evita tener que crearlas, pero en muchas ocasiones tendremos que hacerlo según nuestras necesidades.</p>

<h3><strong>Crear una función</strong></h3>
<p>La sintaxis para crear una función es la siguiente:</p>
<pre>
CREATE &#91;OR REPLACE] FUNCTION nombre_función(parametros) 
RETURNS tipo_dato
AS 'expresión' 
language sql;
</pre>
<ul><li><strong>CREATE FUNCTION</strong> es la sentencia para crear funciones</li><li><strong>OR REPLACE</strong> es opcional y permite reescribir una función ya existente que tenga el mismo nombre</li><li>Los <strong>parámetros</strong> son los nombres que se le darán a las variables de la función junto a su tipo de dato. Conviene no repetir con nombres de columna.</li><li><strong>RETURNS</strong> especifica el tipo de dato que devolverá la función.</li><li><strong>AS </strong>define la expresión o función que tomará las variables definidas en los parámetros</li><li><strong>language sql</strong> indica que la función se ha escrito en SQL. Además de SQL pueden escribirse funciones en otros lenguajes como PL/PgSQL</li></ul>

<h4><strong>Ejemplo</strong></h4>
<p>Podemos poner como ejemplo la función que seleccionaría los usos del suelo en función de la provincia. Para crearla usaríamos el siguiente código:</p>
<pre>
CREATE OR REPLACE FUNCTION usos_provincia(varchar) RETURNS varchar
AS 'SELECT usos FROM tabla_usos WHERE provincia = $1'
language sql;
</pre>
<p>&#8216;varchar&#8217; es el tipo de argumento cuyo dato es introducido por el usuario y sustituirá a $1 en el SELECT.</p>
<p>En este caso indica que el usuario deberá introducir una cadena de texto de tipo variable.</p>
<p>$1 indica que se está tomando el primer argumento de la lista, en este caso &#8216;nombre&#8217;. Es muy útil si la función requiere de varios argumentos.</p>
<p>Para <strong>usar </strong>esta función y obtener los usos en Cáceres lo haríamos de la siguiente manera:</p>
<pre>
SELECT usos_provincia('Cáceres');
</pre>

<h3><strong>Eliminar funciones</strong></h3>
<p>La sintaxis para borrarlas es:</p>
<pre>
DROP FUNCTION &#91; IF EXISTS ] nombre_función&#91;(argumentos)]&#91;CASCADE]
</pre>
<p>Los <strong>argumentos </strong>solo habría que definirlos en caso de haber creado dos funciones distintas con el mismo nombre.</p>
<p><strong>IF EXISTS</strong> evita que se genere error en caso de no existir la función</p>
<p><strong>CASCADE </strong>borrará todos los elementos que dependan de la función que se va a eliminar.</p>
  
<br></details>
<details>
  <summary><strong>Triggers</strong></summary><br>
  
  <div><figure ><img src="https://programapa.files.wordpress.com/2020/10/trigger-sql.jpg?w=300" srcset="https://programapa.files.wordpress.com/2020/10/trigger-sql.jpg?w=300 300w, https://programapa.files.wordpress.com/2020/10/trigger-sql.jpg?w=600 600w, https://programapa.files.wordpress.com/2020/10/trigger-sql.jpg?w=150 150w" sizes="(max-width: 300px) 100vw, 300px" /></figure>
<p>En <strong>PostgreSQL</strong>, los triggers (desencadenantes o disparadores) son códigos que se ejecutarán de forma automática cuando se produzca un evento determinado.</p>
<p>Podemos programarlos para que se ejecuten:</p>
<ul><li><strong>antes o después</strong> de una sentencia <a href="https://programapa.wordpress.com/2020/10/05/lista-de-instrucciones-basicas-en-postgresql-dml/">SELECT, INSERT, DELETE o UPDATE</a></li><li><strong>una vez por cada fila afectada </strong>por las sentencias anteriores</li></ul>

<h3><strong>Crear un trigger</strong></h3>
<p>La sintaxis para crear un trigger es la siguiente:</p>
<pre>
CREATE TRIGGER nombre_trigger {BEFORE/AFTER} {INSERT/UPDATE/DELETE}
ON tabla &#91; FOR &#91; EACH ] {ROW/STATEMENT} ]
EXECUTE PROCEDURE función(argumentos);
</pre>
<p>CREATE TRIGGER es la sentencia para crear triggers y asignarles un nombre</p>
<p>BEFORE y AFTER indican si el trigger se ejecutará antes de o después de un INSERT, UPDATE o DELETE.</p>
<p>ON es para definir la tabla a la que se aplicará el trigger</p>
<p>FOR EACH indica que se ejecutará por cada fila ROW afectada o solo una vez junto a la sentencia STATEMENT</p>
<p>Tras EXECUTE PROCEDURE se referenciará la función que se ejecutará</p>

<p>Hay que tener en cuenta que la <strong>función</strong> que se va a ejecutar:</p>
<ul><li>deberá estar definida antes de crear el trigger</li><li>debe devolver el tipo trigger</li><li>no puede tener argumentos</li><li>puede usarse en varios triggers</li><li>puede desencadenar otros triggers</li></ul>
<p>Si esta <a href="https://programapa.wordpress.com/2020/10/27/funciones/">función </a>la definimos como PL/pgSQL podremos usar las<strong> variables especiales</strong> OLD y NEW para triggers de filas (ROW)</p>
<ul><li><strong>OLD</strong> contiene la fila que había antes de usar sobre ella UPDATE o DELETE </li><li><strong>NEW</strong> contiene la fila resultado de aplicar un INSERT o UPDATE</li></ul>

<h3><strong>Ejemplo: crear función y usarla en un trigger</strong></h3>
<p>A continuación vamos a crear un trigger que se active cada vez que se vaya a borrar una fila para que en su lugar se cambien los valores a NULL:</p>

<h4><strong>1- Crear la función</strong></h4>
<pre>
CREATE OR REPLACE FUNCTION no_borrar() RETURNS TRIGGER AS $no_borrar$
DECLARE plpgsql
BEGIN
RETURN NULL;
END;
$no_borrar$
LANGUAGE plpgsql;
</pre>
<p>no_borrar() es el nombre de la función</p>
<p>Con RETURNS TRIGGER indicamos que la función se usará en un trigger</p>
<p>AS es un requisito del lenguaje para indicar de nuevo el nombre de la función entre los símbolos $ tanto al principio como al final de la función.</p>
<p>Entre BEGIN y END se encuentra el código o expresión que se ejecutará. RETURN es un valor que siempre se devolverá al usar la función. También podría usarse un UPDATE o un INSERT por ejemplo.</p>
<p>En LANGUAGE indicamos que se usa Pl/pgSQL</p>

<h4><strong>2- Crear el trigger</strong></h4>
<pre>
CREATE TRIGGER trigger_borrado BEFORE DELETE
ON municipios FOR EACH ROW
EXECUTE PROCEDURE no_borrar();
</pre>
<p>Se crea un trigger llamado <em>trigger_borrado</em> que se ejecuta antes de usar DELETE sobre una tabla llamada <em>municipios</em>.</p>
<p>El trigger ejecutará la función no_borrar() creada anteriormente por cada fila afectada por DELETE, rellenándolas con valores nulos en vez de eliminarlas.</p>

<p><a id="borrar_trigger"></a></p>
<h3><strong>Borrar un trigger</strong></h3>
<p>La sintaxis para borrar un trigger es la siguiente:</p>
<pre>
DROP TRIGGER nombre_trigger ON tabla;
</pre>
  
<br></details>

  
## 🛠 DML - Lenguaje de manipulación de datos
  
<details>
  <summary><strong>SELECT</strong></summary><br>
  
  <p>Los resultados de SELECT consisten en nuevas tablas que contienen los registros que se ajustan a nuestra consulta: parámetros o condiciones que hemos establecido en una sentencia. Esta tabla deberá guardarse si queremos conservarla.</p>
<p>A continuación se muestran varios ejemplos de la función SELECT en los que se va añadiendo el uso de cláusulas básicas como WHERE o DISTINCT. Todas pueden combinarse entre ellas para afinar los resultados y generar búsquedas más complejas.</p>

<h4><strong>Seleccionar columnas por su nombre</strong></h4>
<pre>
SELECT columna1, columna2
 FROM tabla;
</pre>

<h4><strong>Seleccionar todas las columnas de una tabla</strong></h4>
<pre>
SELECT * FROM tabla;
</pre>

<p>Seleccionar columnas de una tabla específica creando una nueva columna llamada columna3 con los resultados de sumar 50 a una de esas columnas.</p>
<pre>
SELECT columna1, (columna2 + 50) AS columna3
FROM tabla;
</pre>
<p>Pueden crearse expresiones usando <a href="https://programapa.wordpress.com/2020/10/01/operadores-en-postgresql/">operadores</a> para generar nuevas columnas a partir de los datos existentes. </p>
<p>Deben ir entre paréntesis.</p>

<h4><strong>No mostrar valores repetidos al seleccionar columnas con DISTINCT</strong></h4>
<pre>
SELECT DISTINCT columna1, columna2
 FROM tabla;
</pre>

<h4><strong>Filtrar la información mediante expresiones con WHERE </strong></h4>
<pre>
SELECT * FROM tabla 
WHERE columna1 &lt; 100;
</pre>
<p>Deben usarse <a href="https://programapa.wordpress.com/2020/10/01/operadores-en-postgresql/">operadores</a> </p>
<p>Este ejemplo selecciona los registros de una tabla cuando en la <em>columna1 </em>el valor es inferior a 100.</p>

<h4><strong>Ordenar una selección de datos con ORDER BY</strong></h4>
<pre>
SELECT columna1, columna2
FROM tabla
ORDER BY columna2 &#91;DESC];
</pre>
<p>Si no usamos DESC se ordenan de menor a mayor</p>
<p>Si usamos DESC se ordenan de mayor a menor</p>
<p>Admite números y texto</p>
<pre>
SELECT columna1, columna2
FROM tabla
ORDER BY columna2, columna1;
</pre>
<p>En caso de existir registros con el mismo valor en la columna 2 se ordenarían según la columna 1 y sucesivamente.</p>

<h4><strong>Mostrar los x primeros resultados de una selección con LIMIT</strong></h4>
<pre>
SELECT * FROM tabla
LIMIT 100;
</pre>
<p>En este caso se mostrarían solo los 100 primeros registros</p>

<h4><strong>Obviar los primeros x resultados de una selección con OFFSET</strong></h4>
<pre>
SELECT * FROM tabla
OFFSET 50;
</pre>
<p>En este caso no se mostrarían los 50 primeros registros</p>
<pre>
SELECT * FROM tabla
LIMIT 60
OFFSET 30
</pre>
<p>Combinando LIMIT y OFFEST para este caso se seleccionarán los registros 31 al 91.</p>

<h4><strong>Orden de la cláusulas</strong></h4>
<p>El<strong> orden </strong>en el que se deben escribir las cláusulas básicas SELECT dentro de una misma sentencia es el siguiente:</p>
<ol><li>SELECT</li><li>FROM</li><li>WHERE</li><li>ORDER</li><li>LIMIT</li><li>OFFSET</li></ol>
  
<br></details>
<details>
  <summary><strong>INSERT</strong></summary><br>
  
  <p>Con INSERT se introduce nuevas filas en la base de datos especificando los datos nuevos y las columnas en las que se colocarán.</p>
<p>Debe prestarse especial atención a la sintaxis de los datos que introducimos: el texto debe ir entrecomillado, al igual que las fechas. Los números no deben entrecomillarse, pues los tomará como texto. </p>
<p>Si los valores que introducimos se asignan a columnas que no soportan su tipo de datos (introducimos texto en una columna para números) se generará error.</p>
<pre>
INSERT INTO tabla &#91;(columna1, columna2, columna3...)]
VALUES (valor_columna1,valor_columna2,valor_columna3...);
</pre>
<p><strong>INSERT INTO</strong> especifica el lugar donde se añadirán los nuevos registros</p>
<p>Con <strong>VALUES</strong> asignamos valores en el orden que hemos especificado con INSERT INTO</p>
<p>Si no se han especificado columnas los valores tomarán la posición original de las columnas de la tabla en la que introducimos los datos.</p>

<h4><strong>Ejemplos de inserciones</strong></h4>
<pre>
INSERT INTO parcelas (tamaño, provincia, precio_m2)
VALUES (200,'Barcelona',80);
</pre>
<p>Solo se introducen datos en las columnas indicadas, por lo que si alguna otra columna no acepta datos nulos se generará error</p>

<pre>
INSERT INTO parcelas 
VALUES ('54548GL',200,'Barcelona',80);
</pre>
<p>En este caso se introducen datos en todas las columnas según su orden</p>
<p>El primer dato sería un identificador para la parcela de <a href="https://programapa.wordpress.com/2020/10/01/tipos-de-datos-en-sql/">tipo char(7)</a> por lo que debe ir entrecomillado</p>

<pre>
INSERT INTO parcelas
VALUES ('54548GL',200,'Barcelona',80),
       ('65882GL',520,'Tarragona',NULL);
</pre>
<p>Puede introducirse varios registros a la vez</p>
<p>Si no se quiere introducir datos para alguna columna en un registro concreto y la columna lo permite se puede especificar con NULL</p>
  
<br></details>
<details>
  <summary><strong>DELETE</strong></summary><br>
  
  <p>DELETE selecciona columnas al igual que SELECT pero lo que hace es borrarlas.</p>
<pre>
DELETE FROM tabla
</pre>
<ul><li>Elimina toda la tabla</li></ul>
<p>Podemos añadir cláusulas como WHERE para eliminar selectivamente los datos:</p>
<pre>
DELETE parcelas WHERE tamaño_m2 &lt; 1000 AND provincia = 'Salamanca'
</pre>
<ul><li>Elimina los registros de la tabla parcelas aquellas parcelas de Salamanca que tengan menos de 1000 metros cuadrados.</li></ul>
  
<br></details>
<details>
  <summary><strong>UPDATE</strong></summary><br>
  
  <p>UPDATE actualiza el valor de los registros seleccionados con nuevos valores.</p>
<p>La sintaxis básica de<strong> UPDATE </strong>es seleccionar una tabla y definir una expresión después de<strong> SET </strong>indicando columnas a actualizar y los nuevos valores que tendrán:</p>
<pre>
UPDATE tabla SET &#91;expresión]
</pre>

<h4><strong>Ejemplos de actualización de registros</strong></h4>
<pre>
UPDATE parcelas
SET valor_m2 = 5
WHERE tipo = 'rural' AND provincia = 'Córdoba'
</pre>
<p>Actualiza el valor del m2 a 5€ cuando la parcela se encuentra en la provincia de Córdoba y está catalogada como rural</p>

<pre>
UPDATE parcelas SET valor_m2 = valor_m2 * 1.03
</pre>
<p>Aumenta el valor del m2 de las parcelas un 3% multiplicando su valor por 1.03</p>
  
<br></details>
<details>
  <summary><strong>Consultar y agregar atributos</strong></summary><br>
  
  <div><figure ><img src="https://programapa.files.wordpress.com/2020/10/postgre_consultas-2.png?w=243" srcset="https://programapa.files.wordpress.com/2020/10/postgre_consultas-2.png 243w, https://programapa.files.wordpress.com/2020/10/postgre_consultas-2.png?w=150 150w" sizes="(max-width: 243px) 100vw, 243px" /></figure>
<p>En <strong>PostgreSQL</strong> las sentencias SELECT se utilizan para extraer información de la base de datos y generar tablas nuevas. Es parte de lo que se conoce como DML o Data Manipulation Language que introducimos en el post sobre<em> <a rel="noreferrer noopener" href="https://programapa.wordpress.com/2020/10/05/lista-de-instrucciones-basicas-en-postgresql-dml/" target="_blank">Select, Insert, Delete y Update</a>.</em> </p>
<p>Aquí veremos <strong>cláusulas específicas de SELECT para agregar datos</strong>. Son <a href="https://programapa.wordpress.com/2020/10/27/funciones/">funciones</a> que generan resultados únicos a partir de los valores que se encuentren en filas distintas, haciendo operaciones matemáticas sobre ellos o agrupándolos.</p>
<p>A continuación tenéis ejemplos de código SQL describiendo las cláusulas de agregación de datos empleadas con una hipotética tabla llamada  <em>tabla_arbolado</em> que cuenta con las columnas id, especie, altura_m, podas y nidos_aves.</p>

<h3><strong>Ejemplos de agregación de atributos</strong></h3>
<pre>
SELECT especie FROM tabla_arbolado GROUP BY especie;
</pre>
<p><strong>GROUP BY</strong> genera una nueva columna que agrupa todas las filas en valores únicos.</p>
<p>En este caso se han agrupado todos los árboles inventariados de un parque según su especie. A diferencia de DISTINCT, cada grupo (especie) se encuentra unido a los registros que aglutina (árboles), permitiendo operar con ellos para obtener estadísticas.</p>

<pre>
SELECT especie FROM tabla_arbolado GROUP BY especie,
HAVING altura_m &gt; 10;
</pre>
<p><strong>HAVING </strong>filtra los resultados de los grupos creados con GOUP BY.</p>
<p>Siguiendo con el ejemplo anterior, el resultado final será la agrupación de árboles por especie que midan más de 10 metros.</p>

<pre>
SELECT AVG(altura_m) FROM tabla_arbolado;
</pre>
<p><strong>AVG</strong> devuelve la media de los valores numéricos de la columna indicada.</p>
<p>En este caso obtendríamos la altura media de todos los árboles de la tabla arbolado.</p>

<pre>
SELECT COUNT(id_arbol) FROM tabla_arbolado';
SELECT COUNT(id_arbol) AS recuento_acacias FROM tabla_arbolado WHERE especie = 'acacia';
</pre>
<p><strong>COUNT</strong> devuelve el número de filas que cumplen la condición indicada.</p>
<p>En el primer caso nos diría cuántos árboles hay en el parque.</p>
<p>En el segundo caso obtendríamos el número de acacias del parque.</p>

<pre>
SELECT MAX(altura_m) FROM tabla_arbolado;
</pre>
<p><strong>MAX</strong> devuelve el valor máximo de la columna seleccionada.</p>
<p>En este caso nos diría cuántos metros mide el árbol más alto del parque.</p>

<pre>
SELECT MIN(podas) FROM tabla_arbolado;
</pre>
<p><strong>MIN</strong> devuelve el valor mínimo de la columna seleccionada.</p>
<p>En este caso nos diría cuál es el menor número de podas que ha tenido algún árbol en el parque.</p>

<pre>
SELECT SUM(nidos_aves) FROM tabla_arbolado;
</pre>
<p><strong>SUM</strong> devuelve la suma de los valores numéricos de una columna seleccionada.</p>
<p>En este caso nos diría el número total de nidos de pájaro que se han descubierto en el parque.</p>

<pre>
SELECT ARRAY_AGG(especie) FROM tabla_arbolado;
</pre>
<p><strong>ARRAY_AGG</strong> crea una lista con los valores de la columna indicada, incluyendo los nulos.</p>
<p>En este ejemplo obtendríamos una lista con todas las especies existentes en el arbolado del parque.</p>

<p>Las cláusulas anteriores son combinables entre si, pudiendo hacer <strong>selecciones más complejas</strong>:</p>
<pre>
SELECT especie, COUNT(nidos_aves) AS recuento_nidos, 
COUNT(podas) AS recuento_podas FROM tabla_arbolado 
GROUP BY nombre 
ORDER BY recuento_nidos DESC;
</pre>
<p>Con este código obtendríamos el número de nidos de ave y de podas que se han encontrado en cada una de las especies, ordenado de mayor a menor número de nidos.</p>
  
<br></details>
<details>
  <summary><strong>JOIN - Unir tablas </strong></summary><br>
  
  <div><figure ><img src="https://programapa.files.wordpress.com/2020/10/join.png?w=300" srcset="https://programapa.files.wordpress.com/2020/10/join.png?w=300 300w, https://programapa.files.wordpress.com/2020/10/join.png?w=150 150w, https://programapa.files.wordpress.com/2020/10/join.png 495w" sizes="(max-width: 300px) 100vw, 300px" /></figure>
<p>Las bases de datos en <strong>PostgreSQL </strong>suelen estar formadas por varias tablas como consecuencia del diseño lógico en el proceso inicial de su creación.</p>
<p>En ocasiones necesitamos que la información dispersa en varias tablas se muestre unida en nuevas tablas, permitiendo ver la relación entre los datos y operar con ellos fácilmente. Para realizar esto en PostgreSQL se utilizan las sentencias JOIN.</p>

<h3><strong>CROSS JOIN</strong></h3>
<p>Esta sentencia une cada fila de la primera tabla con cada fila de la segunda tabla. Generará por tanto una nueva tabla con el número de filas resultado de multiplicar el número de filas de la tabla 1 por el número de filas de la tabla 2:</p>
<div ><figure ><img loading="lazy" src="https://programapa.files.wordpress.com/2020/10/crossjoin.png?w=526" width="319" height="332" srcset="https://programapa.files.wordpress.com/2020/10/crossjoin.png?w=319 319w, https://programapa.files.wordpress.com/2020/10/crossjoin.png?w=144 144w, https://programapa.files.wordpress.com/2020/10/crossjoin.png?w=288 288w, https://programapa.files.wordpress.com/2020/10/crossjoin.png 526w" sizes="(max-width: 319px) 100vw, 319px" /></figure>
<p>Si tuviésemos dos tablas, una con las provincias de España y otra con una lista de categorías de usos del suelo, obtendríamos una nueva tabla en la que cada fila correspondería a una provincia y un uso del suelo.</p>
<p>Las columnas que contendría la nueva tabla se especifica en SELECT. En el siguiente caso se añadirían las columnas Nombre y Uso:</p>
<pre>
SELECT provincias.Nombre, usos_del_suelo.Uso 
FROM provincias, usos_del_suelo;
</pre>
<pre>
SELECT provincias.Nombre, usos_del_suelo.Uso
FROM provincias
CROSS JOIN usos_del_suelo;
</pre>
<p>Resultado:</p>
<figure><table><thead><tr><th>Nombre</th><th>Uso</th></tr></thead><tbody><tr><td>Almería</td><td>Cultivo</td></tr><tr><td>Almería</td><td>Industrial</td></tr><tr><td>Almería</td><td>Forestal</td></tr><tr><td>Albacete</td><td>Cultivo</td></tr><tr><td>Albacete</td><td>Industrial</td></tr><tr><td>Albacete</td><td>Forestal</td></tr></tbody></table></figure>

<h3><strong>INNER JOIN</strong></h3>
<div ><figure ><img loading="lazy" src="https://programapa.files.wordpress.com/2020/10/inner-join.png?w=337" width="182" height="127" srcset="https://programapa.files.wordpress.com/2020/10/inner-join.png?w=182 182w, https://programapa.files.wordpress.com/2020/10/inner-join.png?w=150 150w, https://programapa.files.wordpress.com/2020/10/inner-join.png?w=300 300w, https://programapa.files.wordpress.com/2020/10/inner-join.png 337w" sizes="(max-width: 182px) 100vw, 182px" /></figure>
<p>Con INNER JOIN lo que hacemos es unir en una misma fila aquellos registros de las tablas seleccionadas que compartan un atributo en común.</p>
<p>Pongamos que tenemos dos tablas, una con las provincias y otra con municipios. La de provincias tiene una columna ID con un identificador único para cada una y la de municipios tiene una columna con el código de la provincia en la que están. </p>
<p>Al hacer el INNER JOIN obtendríamos una nueva tabla en la que cada fila almacenaría tanto el nombre de la provincia como el del municipio. Debe indicarse qué columna de la primera tabla corresponde a la de la segunda, pudiendo hacer uso de abreviaturas (j y k para este ejemplo).</p>
<p>Las columnas que contendría la nueva tabla se especifica en SELECT. En el siguiente caso se añadirían todas las columnas al usar el asterisco (*):</p>
<pre>
SELECT * FROM provincias j 
INNER JOIN municipios k
ON j.ID = k.ID_prov;
</pre>
<p>INNER JOIN es el JOIN por defecto, por lo que puede prescindirse de escribir JOIN</p>
<pre>
SELECT * FROM provincias j 
JOIN municipios k
ON j.ID = k.ID_prov;
</pre>
<p>Resultado:</p>
<figure><table><thead><tr><th>ID</th><th>Prov</th><th>ID_Prov</th><th>Municipio</th></tr></thead><tbody><tr><td>1</td><td>Almería</td><td>1</td><td>Níjar</td></tr><tr><td>1</td><td>Almería</td><td>1</td><td>Gádor</td></tr><tr><td>1</td><td>Almería</td><td>1</td><td>Aguadulce</td></tr><tr><td>2</td><td>Albacete</td><td>2</td><td>Tinajeros</td></tr><tr><td>2</td><td>Albacete</td><td>2</td><td>Barrax</td></tr><tr><td>2</td><td>Albacete</td><td>2</td><td>Argamasón</td></tr></tbody></table></figure>

<h3><strong>OUTER JOIN</strong></h3>
<p>Une las tablas incluyendo las filas que no estén unidas por campos en común. Ello hace que se generen campos nulos, pero permite ver si hay registros en una tabla que no guardan la relación que deberían con la otra. </p>
<p>Hay tres tipos según qué tabla queremos que una todas sus filas:</p>
<h4><strong>LEFT OUTER JOIN </strong></h4>
<div><figure ><img loading="lazy" src="https://programapa.files.wordpress.com/2020/10/left-join.png?w=337" width="198" height="138" srcset="https://programapa.files.wordpress.com/2020/10/left-join.png?w=198 198w, https://programapa.files.wordpress.com/2020/10/left-join.png?w=150 150w, https://programapa.files.wordpress.com/2020/10/left-join.png?w=300 300w, https://programapa.files.wordpress.com/2020/10/left-join.png 337w" sizes="(max-width: 198px) 100vw, 198px" /></figure>
<p>Genera una nueva tabla uniendo todas las filas de la primera tabla, aunque muchas de ellas no guarden relación con un campo en común con la otra.</p>
<p>Por ejemplo, si tenemos una primera tabla con las provincias de España y su ID, y otra con las inundaciones de España durante 2019 con el ID de la provincia en el que se originaron, al hacer el LEFT JOIN obtendríamos una tabla en la que conservaríamos las provincias en las que no se han producido inundaciones:</p>
<pre>
SELECT * FROM provincias j 
LEFT &#91;OUTER] JOIN inundacion_2019 k
ON j.ID = k.ID_prov;
</pre>
<ul><li>No es necesario escribir el OUTER</li><li>Las columnas que contendría la nueva tabla se especifica en SELECT. En este caso se añadirían todas las columnas al usar el asterisco (*)</li></ul>
<p>Resultado:</p>
<figure><table><thead><tr><th>ID</th><th>Prov</th><th>ID_Prov</th><th>Inundado</th></tr></thead><tbody><tr><td>1</td><td>Almería</td><td>1</td><td>Níjar</td></tr><tr><td>2</td><td>Murcia</td><td>2</td><td>San Javier</td></tr><tr><td>2</td><td>Murcia</td><td>2</td><td>Totana</td></tr><tr><td>2</td><td>Murcia</td><td>2</td><td>Torre Pacheco</td></tr><tr><td>3</td><td>Alicante</td><td>3</td><td>San Miguel de Salinas</td></tr><tr><td>3</td><td>Alicante</td><td>3</td><td>Pilar de la Horadada</td></tr><tr><td>4</td><td>Las Palmas</td><td>NULL</td><td>NULL</td></tr><tr><td>5</td><td>Santa Cruz</td><td>NULL</td><td>NULL</td></tr></tbody></table></figure>

<h4><strong>RIGHT OUTER JOIN </strong></h4>
<div ><figure ><img loading="lazy" src="https://programapa.files.wordpress.com/2020/10/right-join.png?w=337" width="209" height="146" srcset="https://programapa.files.wordpress.com/2020/10/right-join.png?w=209 209w, https://programapa.files.wordpress.com/2020/10/right-join.png?w=150 150w, https://programapa.files.wordpress.com/2020/10/right-join.png?w=300 300w, https://programapa.files.wordpress.com/2020/10/right-join.png 337w" sizes="(max-width: 209px) 100vw, 209px" /></figure>
<p>Hace lo mismo pero son las filas de la segunda tabla las que son todas unidas a las de la primera.</p>
<p>Usando el ejemplo anterior, si hiciésemos RIGHT JOIN solo obtendríamos de la tabla de provincias aquellas en las que se han producido inundaciones, conservando todos los registros sobre inundaciones (incluiría así a Ceuta y Melilla, que son Ciudades Autónomas):</p>
<pre>
SELECT * FROM provincias j 
RIGHT &#91;OUTER] JOIN inundacion_2019 k
ON j.ID = k.ID_prov;
</pre>
<ul><li>No es necesario escribir el OUTER</li><li>Las columnas que contendría la nueva tabla se especifica en SELECT. En este caso se añadirían todas las columnas al usar el asterisco (*)</li></ul>
<p>Resultado:</p>
<figure><table><thead><tr><th>ID</th><th>Prov</th><th>ID_Prov</th><th>Inundado</th></tr></thead><tbody><tr><td>1</td><td>Almería</td><td>1</td><td>Níjar</td></tr><tr><td>2</td><td>Murcia</td><td>2</td><td>San Javier</td></tr><tr><td>2</td><td>Murcia</td><td>2</td><td>Totana</td></tr><tr><td>2</td><td>Murcia</td><td>2</td><td>Torre Pacheco</td></tr><tr><td>3</td><td>Alicante</td><td>3</td><td>San Miguel de Salinas</td></tr><tr><td>3</td><td>Alicante</td><td>3</td><td>Pilar de la Horadada</td></tr><tr><td>NULL</td><td>NULL</td><td>0</td><td>Ceuta</td></tr><tr><td>NULL</td><td>NULL</td><td>0</td><td>Melilla</td></tr></tbody></table></figure>

<h4><strong>FULL OUTER JOIN</strong></h4>
<div ><figure ><img loading="lazy" src="https://programapa.files.wordpress.com/2020/10/full-join.png?w=337" alt="" class="wp-image-1844" width="219" height="153" srcset="https://programapa.files.wordpress.com/2020/10/full-join.png?w=219 219w, https://programapa.files.wordpress.com/2020/10/full-join.png?w=150 150w, https://programapa.files.wordpress.com/2020/10/full-join.png?w=300 300w, https://programapa.files.wordpress.com/2020/10/full-join.png 337w" sizes="(max-width: 219px) 100vw, 219px" /></figure>
<p> Crea una nueva tabla con todas las filas de las tablas a unir:</p>
<pre>
SELECT * FROM provincias j 
FULL &#91;OUTER] JOIN inundacion_2019 k
ON j.ID = k.ID_prov;
</pre>
<ul><li>No es necesario escribir el OUTER</li><li>Las columnas que contendría la nueva tabla se especifica en SELECT. En este caso se añadirían todas las columnas al usar el asterisco (*)</li></ul>
<p>Resultado:</p>
<figure><table><thead><tr><th>ID</th><th>Prov</th><th>ID_Prov</th><th>Inundado</th></tr></thead><tbody><tr><td>1</td><td>Almería</td><td>1</td><td>Níjar</td></tr><tr><td>2</td><td>Murcia</td><td>2</td><td>San Javier</td></tr><tr><td>2</td><td>Murcia</td><td>2</td><td>Totana</td></tr><tr><td>2</td><td>Murcia</td><td>2</td><td>Torre Pacheco</td></tr><tr><td>3</td><td>Alicante</td><td>3</td><td>San Miguel de Salinas</td></tr><tr><td>3</td><td>Alicante</td><td>3</td><td>Pilar de la Horadada</td></tr><tr><td>4</td><td>Las Palmas</td><td>NULL</td><td>NULL</td></tr><tr><td>5</td><td>Santa Cruz</td><td>NULL</td><td>NULL</td></tr><tr><td>NULL</td><td>NULL</td><td>0</td><td>Ceuta</td></tr><tr><td>NULL</td><td>NULL</td><td>0</td><td>Melilla</td></tr></tbody></table></figure>

<h4><strong>JOINS MÚLTIPLES</strong></h4>
<div ><figure ><img loading="lazy" src="https://programapa.files.wordpress.com/2020/10/join-multiples.png?w=562" alt="" class="wp-image-1846" width="353" height="155" srcset="https://programapa.files.wordpress.com/2020/10/join-multiples.png?w=353 353w, https://programapa.files.wordpress.com/2020/10/join-multiples.png?w=150 150w, https://programapa.files.wordpress.com/2020/10/join-multiples.png?w=300 300w, https://programapa.files.wordpress.com/2020/10/join-multiples.png 562w" sizes="(max-width: 353px) 100vw, 353px" /></figure>
<p>Para unir más de dos tablas deben encadenarse un JOIN con otro. El primer JOIN une la primera y la segunda tabla. El segundo une ese resultado con una tercera tabla, el tercero unirá ese resultado con una cuarta tabla y así sucesivamente.</p>
<p>Como ejemplo, podríamos unir al FULL JOIN del ejemplo anterior una tercera tabla con la lista de municipios que han recibido ayudas para la reparación de los daños:</p>
<pre>
SELECT * 
FROM provincias j 
FULL &#91;OUTER] JOIN inundacion_2019 k
ON j.ID = k.ID_prov
LEFT JOIN ayudas f
ON k.Inundado = f.Ayuda;
</pre>
<p>Resultado:</p>
  
  <figure class="wp-block-table is-style-stripes"><table><thead><tr><th>ID</th><th>Prov</th><th>ID_Prov</th><th>Inundado</th><th>Ayuda</th></tr></thead><tbody><tr><td>1</td><td>Almería</td><td>1</td><td>Níjar</td><td>NULL</td></tr><tr><td>2</td><td>Murcia</td><td>2</td><td>San Javier</td><td>NULL</td></tr><tr><td>2</td><td>Murcia</td><td>2</td><td>Totana</td><td>Totana</td></tr><tr><td>2</td><td>Murcia</td><td>2</td><td>Torre Pacheco</td><td>Torre Pacheco</td></tr><tr><td>3</td><td>Alicante</td><td>3</td><td>San Miguel de Salinas</td><td>NULL</td></tr><tr><td>3</td><td>Alicante</td><td>3</td><td>Pilar de la Horadada</td><td>Pilar de la Horadada</td></tr><tr><td>4</td><td>Las Palmas</td><td>NULL</td><td>NULL</td><td>NULL</td></tr><tr><td>5</td><td>Santa Cruz</td><td>NULL</td><td>NULL</td><td>NULL</td></tr><tr><td>NULL</td><td>NULL</td><td>0</td><td>Ceuta</td><td>Ceuta</td></tr><tr><td>NULL</td><td>NULL</td><td>0</td><td>Melilla</td><td>NULL</td></tr></tbody></table></figure>

  
<br></details>
<details>
  <summary><strong>Subconsultas</strong></summary><br>
  
  <div><figure ><img src="https://programapa.files.wordpress.com/2020/10/subconsultas.jpg?w=300" srcset="https://programapa.files.wordpress.com/2020/10/subconsultas.jpg?w=300 300w, https://programapa.files.wordpress.com/2020/10/subconsultas.jpg?w=600 600w, https://programapa.files.wordpress.com/2020/10/subconsultas.jpg?w=150 150w" sizes="(max-width: 300px) 100vw, 300px" /></figure>
<p>En ocasiones necesitamos hacer consultas en <strong>PostgreSQL</strong> que por su complejidad nos obligan a escribir códigos largos, teniendo que dividirlo en varias partes según el procedimiento lógico que nos haga llegar al resultado que esperamos.</p>
<p>En vez de encadenar instrucciones dependientes unas de otras se puede <strong>simplificar</strong> el proceso anidando una consulta dentro de otra, es decir, creando <strong>subconsultas</strong>.</p>
<p>Las subconsultas son sentencias SELECT metidas entre paréntesis () dentro de otras <a href="https://programapa.wordpress.com/2020/10/05/lista-de-instrucciones-basicas-en-postgresql-dml/">sentencias SELECT, INSERT, DELETE y UPDATE</a>. </p>
<p>A continuación tienes los <strong>distintos tipos de subconsultas</strong> que existen. Les acompañarán ejemplos tomando como base una tabla ficticia en la que se almacenan municipios con su nombre, superficie, altitud media, población y provincia a la que pertenecen.</p>
<p>El <a href="https://programapa.wordpress.com/2020/10/01/operadores-en-postgresql/">operador</a> siempre debe escogerse con cuidado dependiendo del resultado que queramos obtener con la subconsulta. Si el resultado esperado es un único valor o registro usaremos los operadores aritméticos o de comparación, pero si vamos a obtener varios valores habrá que echar mano de los operadores lógicos.</p>

<h3><strong>Subconsulta como expresión</strong></h3>
<p>Selecciona datos a partir de otra selección.</p>
<pre>
SELECT columna 
FROM tabla 
WHERE columna OPERADOR (subconsulta);
</pre>

<h4><strong>Ejemplos</strong></h4>
<pre>
SELECT nombre
FROM municipios
WHERE superficie &gt; ALL (SELECT superficie FROM municipios
WHERE provincia = 'León' OR población &gt; 10000 );
</pre>
<p>Listaríamos los municipios cuya superficie es mayor que la superficie de cualquier municipio de la provincia de León o que su población supere los 10000 habitantes.</p>

<pre>
SELECT nombre
FROM municipios
WHERE altitud &lt; ANY (SELECT altitud FROM municipios
WHERE provincia = 'Huelva');
</pre>
<p>Seleccionaríamos los municipios cuya altitud media sea inferior a la que tenga cualquier municipio de la provincia de Huelva.</p>

<pre>
SELECT nombre
FROM municipios
WHERE provincia IN (SELECT provincia FROM municipios
GROUP BY provincia 
ORDER BY SUM(población) DESC
LIMIT 5);
</pre>
<p>Averiguaríamos cuáles son los municipios de las 5 provincias más pobladas.</p>
<p>IN compara la provincia a la que pertenece cada municipio con las 5 provincias que obtienen un valor más alto al sumar los valores de población de sus municipios.</p>

<h3><strong>Subconsultas como tabla</strong></h3>
<p>En este caso se usa una subconsulta para filtrar la fuente de información sobre la que se hará la consulta principal. Para ello, se usa justo después de FROM.</p>
<pre>
SELECT columna 
FROM (subconsulta_tabla1)
JOIN tabla2;
</pre>
<p>Este tipo de subconsulta resulta útil, por ejemplo, cuando vas a realizar un <a href="https://programapa.wordpress.com/2020/10/19/combinar-registros-de-tablas-diferentes-en-postgresql-con-join/">JOIN</a>, ya que así los datos se procesarían más rápido.</p>

<h4><strong>Ejemplo</strong></h4>
<pre>
SELECT nombre FROM (SELECT nombre, población FROM municipios) 
WHERE población &gt; 5000 
</pre>
<p>Hemos seleccionado los municipios con más de 5000 habitantes cargando solo las dos columna que íbamos a usar: nombre y población.</p>

<h3><strong>Subconsultas correlacionadas</strong></h3>
<pre>
SELECT (subconsulta1)(subconsulta2)
FROM tabla
WHERE columna OPERADOR (expresión);
SELECT columna
FROM tabla
WHERE columna OPERADOR (subconsulta con función_agregado);
</pre>
<p>Una de las consultas o subconsultas sobre una tabla dependen del resultado de otra consulta sobre esa misma tabla.</p>
<p>En el primer caso lo establecido en la subconsulta 1 sería necesario para llevar a cabo la subconsulta 2.</p>
<p>En el segundo caso la subconsulta contendría una función de agregado cuyo resultado alimentaría a la consulta principal.</p>

<h4><strong>Ejemplo</strong></h4>
<pre>
SELECT nombre 
FROM municipios
WHERE altitud &gt; (SELECT AVG(altitud) FROM municipios);
</pre>
<p>Obtendríamos los nombres de los municipios cuya altitud supera a la media de altitud de todos los municipios.</p>
<p>La altitud media es un dato que no conocemos pero que tampoco ha sido necesario que lo calculáramos previamente porque se ha utilizado la función de agregado AVG (calcula la media aritmética)</p>
  
<br></details>
  
## 🐘🌏 PostGIS 

<details>
  <summary><strong>Datos geométricos</strong></summary><br>
  
  <p>En cartografía, los elementos geográficos se abstraen, según su naturaleza, en objetos geométricos como puntos, líneas o polígonos que son posicionados en un marco de referencia espacial a través de las coordenadas de sus vértices. </p>
<p>Es el caso de las <strong>variables geográficas discretas</strong>, es decir, elementos que pueden individualizarse: un árbol será un punto que marque sus coordenadas, una parcela será un polígono cuyos lados recorran sus lindes, una calle recta corresponderá a una línea que una dos puntos correspondientes al inicio y fin de dicha calle etc.</p>
<p>Esta clase de información geográfica en forma de objetos geométricos se denomina <strong>vectorial</strong>. Existe otra denominada ráster que suele utilizarse para variables continuas del territorio como elevación o temperaturas.</p>
<p>En una base de datos geográficos que siga el <strong>modelo Simple Feature</strong> cada uno de los objetos vectoriales corresponderá con un registro en una tabla que contendrá información como su nombre, sus medidas, su fecha o cualquier otro valor que queramos. </p>
<p>Las geometrías en <strong>PostGIS </strong>se engloban dentro del <a href="https://programapa.wordpress.com/2020/10/01/tipos-de-datos-en-sql/">tipo de dato</a> <strong>geometry</strong> en el que se especifica qué tipo de geometría se va a almacenar:</p>
<pre><code>geometry(tipo, SRC)</code></pre>
<ul><li><strong>Tipo</strong> hace referencia al tipo de geometría que almacenará una columna que guarde geometrías y que serán detallados más abajo</li><li><strong>SRC </strong>es el código del<strong> <a rel="noreferrer noopener" href="https://spatialreference.org/" target="_blank">sistema de referencia</a></strong> en el que se encuentren las coordenadas de los objetos que se introduzcan</li></ul>
<h3><strong>Tipos de geometría</strong></h3>
<p>A continuación se detallan los tipos de geometría con los que trabaja PostGIS:</p>
<h4><strong>POINT</strong></h4>
<figure><img src="https://programapa.files.wordpress.com/2020/11/point.png?w=150"/></figure>
<p>Un único punto en el espacio localizado a través de sus coordenadas X e Y. Se utiliza para posicionar elementos individualizados en un único registro como una persona, un comercio o un coche.</p>
<p>Con los puntos se pueden hacer por ejemplo interpolaciones, selecciones espaciales o análisis de proximidad.</p>
<p>Cuando sean <a href="https://programapa.wordpress.com/2020/10/05/lista-de-instrucciones-basicas-en-postgresql-dml/">insertados </a>en un registro deberá usarse la siguiente codificación WKT (<em>Well Known Text</em>) con las coordenadas del punto:</p>
<pre><code>POINT (10 15)</code></pre>
<h4><strong>MULTIPOINT</strong></h4>
<figure><img src="https://programapa.files.wordpress.com/2020/11/multipoint.png?w=150"/></figure>
<p>Se puede también almacenar en un solo registro varios puntos que cuenten con las mismas características salvo su posición en el espacio, como puede ser el caso de buzones, señales de tráfico STOP o lugares donde se han encontrado trufas.</p>
<p>Con ellos pueden hacerse al igual que con los POINT análisis de proximidad o selecciones espaciales.</p>
<p>Cuando sean <a href="https://programapa.wordpress.com/2020/10/05/lista-de-instrucciones-basicas-en-postgresql-dml/">insertados </a>en un registro deberá usarse la siguiente codificación WKT con las coordenadas de cada punto separados por comas:</p>
<pre><code>MULTIPOINT (10 15, 15 25, 7 35, 30 28)</code></pre>
<h4><strong>LINESTRING</strong></h4>
<figure><img loading="lazy" src="https://programapa.files.wordpress.com/2020/11/linestring.png?w=150" width="150" height="150" /></figure>
<p>Cada registro almacena una sola línea. Las líneas consisten en una secuencia de puntos unidos según el orden en el que han sido introducidos. Se usan para elementos lineales del territorio como caminos, ríos, fronteras o rutas de todo tipo.</p>
<p>Este tipo de geometría permite medir longitudes y hacer análisis de redes entre otros geoprocesos.</p>
<p>Cuando sean <a href="https://programapa.wordpress.com/2020/10/05/lista-de-instrucciones-basicas-en-postgresql-dml/">insertados </a>en un registro deberá usarse la siguiente codificación WKT con las coordenadas de los vértices en el orden en el que se dibujará la línea:</p>
<pre><code>LINESTRING (10 30, 20 15, 40 10)</code></pre>
<h4><strong>MULTILINESTRING</strong></h4>
<figure><img src="https://programapa.files.wordpress.com/2020/11/multilinestring.png?w=150"/></figure>
<p>Un único registro también puede almacenar varias líneas que cuenten con las mismas características, como pueden ser curvas de nivel con el mismo valor de altitud o distintos tramos de una misma carretera.</p>
<p>Cuando sean <a href="https://programapa.wordpress.com/2020/10/05/lista-de-instrucciones-basicas-en-postgresql-dml/">insertados </a>en un registro deberá usarse la siguiente codificación WKT con las coordenadas de los vértices de cada línea agrupados entre paréntesis:</p>
<pre><code>MULTILINESTRING ((10 40, 20 15, 40 10) , (5 7, 12 5) , (45 30, 30 25, 27 39, 41 50 ))</code></pre>
<h4><strong>POLYGON</strong></h4>
<div class="wp-block-jetpack-layout-grid alignfull column1-desktop-grid__span-2 column1-desktop-grid__start-5 column1-desktop-grid__row-1 column2-desktop-grid__span-2 column2-desktop-grid__start-7 column2-desktop-grid__row-1 column1-tablet-grid__span-4 column1-tablet-grid__row-1 column2-tablet-grid__span-4 column2-tablet-grid__start-5 column2-tablet-grid__row-1 column1-mobile-grid__span-4 column1-mobile-grid__row-1 column2-mobile-grid__span-4 column2-mobile-grid__row-2 wp-block-jetpack-layout-gutter__nowrap wp-block-jetpack-layout-gutter__none">
<div class="wp-block-jetpack-layout-grid-column wp-block-jetpack-layout-grid__padding-none">
<figure><img src="https://programapa.files.wordpress.com/2020/11/polygon.png?w=150"/></figure>
<div class="wp-block-jetpack-layout-grid-column wp-block-jetpack-layout-grid__padding-none">
<figure><img src="https://programapa.files.wordpress.com/2020/11/polygon2.png?w=150"/></figure>
<p>Los polígonos son líneas cerradas en las que el primer y el último vértice coinciden en el espacio. Sirven para representar superficies como parcelas, embalses o usos del suelo.</p>
<p>Permiten hacer cálculos de superficie, selecciones espaciales y recortar capas entre otros geoprocesos.</p>
<p>Cuando sean <a href="https://programapa.wordpress.com/2020/10/05/lista-de-instrucciones-basicas-en-postgresql-dml/">insertados </a>en un registro deberá usarse la siguiente codificación WKT con las coordenadas de los vértices de cada polígono, teniendo en cuenta que el primero y el último deben ser el mismo:</p>
<pre><code>POLYGON(5 20, 20 10, 35 22, 15 35, 5 20)</code></pre>
<p>Si se quiere dejar huecos dentro de un polígono como el de la segunda imagen, habrá que añadir un segundo polígono que delimite la línea del agujero:</p>
<pre><code>POLYGON((5 20, 20 10, 35 22, 15 35, 5 20) , (16 19, 20 30, 25 29))</code></pre>
<h4><strong>MULTIPOLYGON</strong></h4>
<figure><img src="https://programapa.files.wordpress.com/2020/11/multipolygon.png?w=150"/></figure>
<p>En este caso un mismo registro amacena varias geometrías poligonales con los mismos atributos. Es útil por ejemplo para usos del suelo, en donde una única clase como la urbana es común para todas las áreas que se clasifiquen como tales (dependería siempre de con cuántas clases quieras trabajar)</p>
<pre><code>POLYGON((5 20, 20 10, 35 22, 15 35, 5 20) , (36 32, 70 19, 50 45), (6 45, 5 50, 55 50, 60 45))</code></pre>
<h3><strong>Dimensiones de las geometrías</strong></h3>
<p>Dado que las geometrías son objetos espaciales, contarán con una u otra dimensión según sus características medibles:</p>
<figure><table><thead><tr><th data-align="center">Geometría</th><th data-align="center">Dimensión</th></tr></thead><tbody><tr><td data-align="center">La nada</td><td data-align="center">-1</td><td data-align="left">No hay coordenadas, no hay nada que medir</td></tr><tr><td data-align="center">Puntos</td><td data-align="center">0</td><td data-align="left">Una posición concreta en el espacio</td></tr><tr><td data-align="center">Líneas</td><td data-align="center">1</td><td data-align="left">La unión de varias posiciones que da lugar a las líneas, permitiendo medir longitudes</td></tr><tr><td data-align="center">Polígonos</td><td data-align="center">2</td><td data-align="left">Una línea cerrada da lugar a una superficie con valores medibles de ancho y largo (y a partir de ellas otras derivadas como la superficie)</td></tr></tbody></table></figure>
<p>De momento solo trataremos estas dimensiones pero existen más:</p>
<ul><li>Tercera dimensión: una coordenada Z con valores de altura nos permitirá medir también volúmenes.</li><li>Cuarta dimensión: coordenadas temporales T que nos permiten medir velocidades, entre otras cosas.</li></ul>
  
  <br></details>
  
<details>
  <summary><strong>Predicados espaciales</strong></summary><br>
  
  <p>Los predicados espaciales son «<em>operaciones de tipo lógico que nos indican si entre dos objetos geográficos existe o no un tipo de relación dada</em>» (<a href="https://volaya.github.io/libro-sig/chapters/Analisis_espacial.html" target="_blank" rel="noreferrer noopener">Análisis espacial &#8211; Relaciones topológicas; Libro SIG de Víctor Olaya</a>) </p>
<p>Es decir, es la forma que tenemos para decirle al programa informático que compruebe si dos o más objetos geográficos (entidades) se tocan, se cruzan, a qué distancia están, qué espacio no comparten ninguno de los dos&#8230;</p>
<p>Estos predicados espaciales (también llamados geográficos o topológicos según el autor) varían su sintaxis según la herramienta que estemos usando. En este post resumo la sintaxis de estos predicados en PostGIS.</p>
<p>Con ellos obtendremos valores TRUE (booleanos) cuando se cumpla la relación espacial consultada entre las geometrías de los objetos incluidas en el predicado.</p>
<p>Los siguientes predicados espaciales y muchos otros más podéis <a href="https://postgis.net/docs/reference.html#Spatial_Relationships" target="_blank" rel="noreferrer noopener">encontrarlos en la documentación oficial de PostGIS</a></p>
<h2>INTERSECT</h2>
<p>Las geometrías tienen algún punto en común</p>
<pre>
ST_Intersects(geometry A, geometry B)
</pre>
<figure><img src="https://programapa.files.wordpress.com/2020/11/st_intersects.png?w=375" srcset="https://programapa.files.wordpress.com/2020/11/st_intersects.png 375w, https://programapa.files.wordpress.com/2020/11/st_intersects.png?w=119 119w, https://programapa.files.wordpress.com/2020/11/st_intersects.png?w=239 239w" sizes="(max-width: 375px) 100vw, 375px" /></figure>
<h2>EQUALS</h2>
<p>Las geometrías son idénticas</p>
<pre>
ST_Equal(geometry A, geometry B)
</pre>
<figure><img src="https://programapa.files.wordpress.com/2020/11/st_equals.png?w=352" srcset="https://programapa.files.wordpress.com/2020/11/st_equals.png 352w, https://programapa.files.wordpress.com/2020/11/st_equals.png?w=150 150w, https://programapa.files.wordpress.com/2020/11/st_equals.png?w=300 300w" sizes="(max-width: 352px) 100vw, 352px" /></figure>
<h2>DISJOINT</h2>
<p>Las geometrías no coinciden en ningún momento</p>
<pre>
ST_Disjoint(geometry A , geometry B)
</pre>
<figure><img src="https://programapa.files.wordpress.com/2020/11/st_disjoint.png?w=329" srcset="https://programapa.files.wordpress.com/2020/11/st_disjoint.png 329w, https://programapa.files.wordpress.com/2020/11/st_disjoint.png?w=108 108w, https://programapa.files.wordpress.com/2020/11/st_disjoint.png?w=216 216w" sizes="(max-width: 329px) 100vw, 329px" /></figure>
<h2>CROSSES</h2>
<p>Dos geometrías coinciden en un único punto</p>
<pre>
ST_Crosses(geometry A, geometry B)
</pre>
<figure><img src="https://programapa.files.wordpress.com/2020/11/st_crosses.png?w=336" srcset="https://programapa.files.wordpress.com/2020/11/st_crosses.png 336w, https://programapa.files.wordpress.com/2020/11/st_crosses.png?w=150 150w, https://programapa.files.wordpress.com/2020/11/st_crosses.png?w=300 300w" sizes="(max-width: 336px) 100vw, 336px" /></figure>
<h2> OVERLAPS </h2>
<p>Existe un solapamiento entre dos objetos, generando una nueva geometría</p>
<pre>
ST_Overlaps(geometry A, geometry B)
</pre>
<figure><img src="https://programapa.files.wordpress.com/2020/11/st_overlaps-1.png?w=275" srcset="https://programapa.files.wordpress.com/2020/11/st_overlaps-1.png 275w, https://programapa.files.wordpress.com/2020/11/st_overlaps-1.png?w=150 150w" sizes="(max-width: 275px) 100vw, 275px" /></figure>
<h2>TOUCHES</h2>
<p>Las geometrías se tocan sin coincidir sus interiores en ningún momento</p>
<pre>
ST_Touches(geometry A, geometry B)
</pre>
<figure><img src="https://programapa.files.wordpress.com/2020/11/st_touches.png?w=323" srcset="https://programapa.files.wordpress.com/2020/11/st_touches.png 323w, https://programapa.files.wordpress.com/2020/11/st_touches.png?w=135 135w, https://programapa.files.wordpress.com/2020/11/st_touches.png?w=271 271w" sizes="(max-width: 323px) 100vw, 323px" /></figure>
<h2>WITHIN/CONTAINS</h2>
<p>Comprueba si una geometría está dentro de otra (within) o si una geometría contiene a otra (contains)</p>
<p>A está dentro de B:</p>
<pre>
ST_Within(geometry A , geometry B)
</pre>
<p>A contiene B:</p>
<pre>
ST_Contains(geometry A, geometry B)
</pre>
<figure><img src="https://programapa.files.wordpress.com/2020/11/st_within.png?w=329" srcset="https://programapa.files.wordpress.com/2020/11/st_within.png 329w, https://programapa.files.wordpress.com/2020/11/st_within.png?w=108 108w, https://programapa.files.wordpress.com/2020/11/st_within.png?w=216 216w" sizes="(max-width: 329px) 100vw, 329px" /></figure>
<h2>DISTANCE WITHIN</h2>
<p>Si una geometría se encuentra a cierta distancia de otra</p>
<pre>
ST_DWithin(geometry A, geometry B, distance)
</pre>
<figure><img src="https://programapa.files.wordpress.com/2020/11/st_dwithin.png?w=330" srcset="https://programapa.files.wordpress.com/2020/11/st_dwithin.png 330w, https://programapa.files.wordpress.com/2020/11/st_dwithin.png?w=150 150w, https://programapa.files.wordpress.com/2020/11/st_dwithin.png?w=300 300w" sizes="(max-width: 330px) 100vw, 330px" /></figure>
<h2> DISTANCE </h2>
<p>En este caso, en vez de devolver TRUE o FALSE devuelve un valor decimal con la distancia entre las geometrías seleccionadas en las unidades del sistema de referencia de la capa:</p>
<pre>
  
  <br></details>
  
<details>
  <summary><strong>Crear topología</strong></summary><br>
  
  <p>La topología, referida al ámbito geográfico, son las relaciones espaciales que existen entre distintos objetos o fenómenos territoriales. </p>
<p>Cuando hacemos análisis espaciales como <a href="https://programapa.wordpress.com/2020/11/13/relaciones-espaciales/">comentamos en este artículo</a> se comprueba la existencia de estas relaciones, dónde se producen y en qué magnitud. Sin embargo, eso no quiere decir que los datos espaciales contengan topología, sino que dicha topología se calcula o extrae a posteriori a partir de objetos posicionados en un marco espacial.</p>
<p>Por ejemplo, si tenemos dos polígonos correspondientes a dos parcelas que se encuentran pegadas la una a la otra, un análisis espacial nos devolvería el dato que dice que se encuentran compartiendo frontera.</p>
<p>Cuando los objetos almacenan topología, lo que hacen es guardar esas relaciones existentes entre ellos, es decir, las relaciones son implícitas a ellos. De este modo, cuando los datos se editen, los objetos seguirán manteniendo esas relaciones.</p>
<p>Si ahora modificáramos el límite de una de esas parcelas, ampliando su tamaño sobre la otra, no se produciría un solape, sino que la otra parcela vería reducida su tamaño y seguirían compartiendo borde.</p>
<p>Añadir topología es muy útil porque reduce la geometría a sus primitivas, haciendo que ocupen menos espacio y permitiendo hacer análisis espaciales más rápidos y precisos. Sin embargo, resulta contraproducente usarla en muchas situaciones. Recomiendo leer el <a rel="noreferrer noopener" href="http://volaya.github.io/libro-sig/chapters/Tipos_datos.html#Topolog%C3%ADa" target="_blank">apartado de topología</a> del capítulo sobre modelos de información geográfica del libro SIG de Víctor Olaya para ampliar más sobre este tema.</p>
<h2><strong>Añadir topología con PostGIS</strong></h2>
<p>PostGIS permite que añadamos topología a nuestras capas espaciales en unos pocos pasos:</p>
<h3><strong>1 &#8211; Activar la extensión PostGIS y la extensión PostGIS_topology </strong></h3>
<p>Antes de comenzar es necesario que la base de datos PostgreSQL cuente con las funciones espaciales (proporcionadas por la extensión PostGIS) y con las funciones topológicas (dadas en PostGIS_topology).</p>
<p>Bastará con ejecutar las siguientes sentencias:</p>
<pre>
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology; 
</pre>
<h3><strong>2 &#8211; Crear esquema topológico</strong></h3>
<p>Lo primero es crear con el siguiente código un <a href="https://programapa.wordpress.com/2020/09/22/lista-de-instrucciones-basicas-de-sql/">esquema</a> en PostgreSQL en el que que se almacenará la topología:</p>
<pre>
SELECT topology.CreateTopology('nombre_topología', SRC, tolerancia);
</pre>
<p>Se le asigna un nombre a la topología, generalmente el nombre de la capa a la que se la añadiremos junto a un prefijo o un sufijo &#8216;topo&#8217; (topo_carreteras por ejemplo)</p>
<p>El <a rel="noreferrer noopener" href="https://spatialreference.org/" target="_blank">sistema de referencia</a> de la topología (25830 por ejemplo)</p>
<p>La tolerancia clúster (por ejemplo 0.1) asigna la misma posición a los vértices que se encuentren dentro de esa tolerancia, desplazándolos un poco durante el proceso. Por tanto, dicha tolerancia debe ser pequeña para que así reasigne solo aquellos vértices que realmente pudieran verse repetidos.</p>
<p>El <strong>resultado </strong>es un nuevo esquema que contará con las siguientes tablas, cada una almacenando una parte de la topología: los nodos, los bordes, las caras y las relaciones existentes entre ellos.</p>
<figure><img src="https://programapa.files.wordpress.com/2020/12/image-15.png?w=150"/></figure>
<h3><strong>3 &#8211; Añadir columna topogeométrica a la capa</strong></h3>
<p>Tendremos que usar la siguiente sentencia:</p>
<pre>
SELECT topology.AddTopoGeometryColumn('nombre_topo', 'esquema_capa', 'nombre_capa', 'nombre_topogeom', 'tipo_geometría');
</pre>
<p><em>Nombre_topo </em>indica el esquema topológico creado en el punto 1 en el que se guardará la topología </p>
<p><em>Esquema_capa</em> se refiere al esquema en el que se encuentra la capa a la que vamos a dar topología</p>
<p><em>Nombre_capa </em>es el nombre de la tabla (o capa, es lo mismo) espacial </p>
<p><em>Nombre_topogeom</em> es el nombre de la columna que contendrá la topogeometría. Habitualmente se la llama <em>topogeom</em></p>
<p><em>Tipo_geometría </em>es el <a href="https://programapa.wordpress.com/2020/11/06/tipos-de-datos-espaciales/">tipo de geometría</a> de la capa </p>
<p>Cuando se añade una capa al esquema topológico por un lado se añade una nueva columna llamada <em>topogeom </em>a la tabla de la capa que va a albergar topología.</p>
<figure><img src="https://programapa.files.wordpress.com/2020/12/image-16.png?w=130"/></figure>
<p>Pero también por otro&nbsp;lado se&nbsp;añade automáticamente&nbsp;un registro en la&nbsp;tabla&nbsp;de&nbsp;metadatos&nbsp;<em>layer</em> del esquema <em>topology</em> con la capa que incorpora la topología. Este es un esquema que se crea automáticamente cuando activamos la extensión de topología en una base de datos de PostgreSQL.</p>
<h3><strong>4 &#8211; Rellenar&nbsp;la&nbsp;nueva&nbsp;columna&nbsp;<em>topogeom</em></strong></h3>
<p>Se actualiza la capa rellenando la columna <em>topogeom </em>con los datos de la columna de geometría transformados a topología:</p>
<pre>
UPDATE nombre_capa 
SET topogeom = topology.toTopoGeom(
     columna_geom, 'esquema_topo', 
     layer_id, tolerancia
);
</pre>
<p><em>Columna_geom </em>es la columna con geometría de la tabla</p>
<p><em>Esquema_topo</em> es el esquema topológico que creamos al inicio</p>
<p><em>Layer_id</em> es el identificador de la capa de topología asignado en la tabla <em>layer </em>del esquema <em>topology</em></p>
<p><em>Tolerancia</em> es el umbral para reasignar vértices explicado en el punto 1</p>
<figure><img src="https://programapa.files.wordpress.com/2020/12/image-20.png?w=103"/></figure>
<p>Pueden generarse errores durante el proceso al emplear tolerancias muy grandes o al existir geometrías no válidas. En tal caso hay que revisar las geometrías para que sean válidas y reducir la tolerancia, es decir, exigir más precisión a la hora de crear la topología.</p>
<h3><strong>5 &#8211; Ya en QGIS</strong></h3>
<p>Una vez hecho todo esto, desde QGIS veríamos un esquema en el que se encuentran cuatro capas: la de los nodos, la de los bordes, la de las caras y la de las relaciones. Las podremos añadir al proyecto y operar con ellas aprovechando sus ventajas, pero teniendo también en cuenta sus inconvenientes, ya que por ejemplo no son adecuadas para fines estéticos o de diseño.</p>
<figure><img src="https://programapa.files.wordpress.com/2020/12/image-18.png?w=172" srcset="https://programapa.files.wordpress.com/2020/12/image-18.png 172w, https://programapa.files.wordpress.com/2020/12/image-18.png?w=111 111w" sizes="(max-width: 172px) 100vw, 172px" /></figure>
<figure><img src="https://programapa.files.wordpress.com/2020/12/image-19.png?w=897" srcset="https://programapa.files.wordpress.com/2020/12/image-19.png 897w, https://programapa.files.wordpress.com/2020/12/image-19.png?w=150 150w, https://programapa.files.wordpress.com/2020/12/image-19.png?w=300 300w, https://programapa.files.wordpress.com/2020/12/image-19.png?w=768 768w" sizes="(max-width: 897px) 100vw, 897px" /></figure>
<p>Por ejemplo, si simplificáramos las geometrías de las Comunidades Autónomas de España con <em>ST_Simplify</em> sobre la columna <em>geom </em>(la de geometrías simples)<em> </em>se originarían gaps entre las distintas regiones. </p>
<figure><img src="https://programapa.files.wordpress.com/2020/12/image-33.png?w=649" srcset="https://programapa.files.wordpress.com/2020/12/image-33.png 649w, https://programapa.files.wordpress.com/2020/12/image-33.png?w=150 150w, https://programapa.files.wordpress.com/2020/12/image-33.png?w=300 300w" sizes="(max-width: 649px) 100vw, 649px" /></figure>
<p>En cambio, si lo aplicáramos sobre la columna <em>topogeom</em> (la columna que hemos añadido con la topología) esto no se produciría puesto que mantendría la consistencia de los datos, es decir, mantendría los polígonos unidos:</p>
<figure><img src="https://programapa.files.wordpress.com/2020/12/image-34.png?w=699" srcset="https://programapa.files.wordpress.com/2020/12/image-34.png 699w, https://programapa.files.wordpress.com/2020/12/image-34.png?w=150 150w, https://programapa.files.wordpress.com/2020/12/image-34.png?w=300 300w" sizes="(max-width: 699px) 100vw, 699px" /></figure>
<h3><strong>6 &#8211; Borrar la topología de una capa</strong></h3>
<p>Si quisiéramos borrar la topología habría que usar el siguiente código:</p>
<pre>
SELECT topology.DropTopology('nombre_capa');
</pre>
  
  <br></details>
  
<details>
  <summary><strong>Crear topología de red</strong></summary><br>
  
  <h2><strong>Topología de red</strong></h2>
<p>A la hora de hacer análisis espaciales es conveniente que nuestros geodatos cuenten con topología. En el <a href="https://programapa.wordpress.com/2020/12/15/anadir-topologia-a-las-capas/">post de topología en PostGIS</a> explico brevemente qué es la topología y qué bondades ofrece, pero en resumidas cuentas la topología almacena las <a rel="noreferrer noopener" href="https://programapa.wordpress.com/2020/11/13/relaciones-espaciales/" target="_blank">relaciones espaciales</a> existentes en nuestros datos.</p>
<p>La topología aplicada a capas de carreteras, ríos o cualquier entidad lineal del territorio lo que hace es estructurar los datos para que cada arco comience siempre en un nodo y acabe en otro, identificando en sus atributos el nodo en el que empieza y en el que acaba. Dicho de otro modo, cada cruce es un punto y cada calle es un arco que debe conectar sí o sí con dos puntos (aunque sea una calle sin salida).</p>
<p>Gracias a esta información podremos hacer análisis de redes tales como:</p>
<ul><li>Averiguar la ruta más corta entre dos nodos de la red</li><li>La ruta más corta para atravesar varios puntos y regresar al origen</li><li>Calcular los costes de desplazamiento entre varias rutas</li></ul>
<p>Además, podríamos añadir a la coctelera variables como la velocidad o el sentido de la circulación para cada tramo, los giros prohibidos de cada nodo, el estado del tráfico, restricciones&#8230;</p>
<p>Básicamente, lo que se hace es calcular la longitud total del recorrido sumando las longitudes de los arcos por los que ha sido posible circular. A ese valor se le aplicarán los distintos factores que condicionen el viaje como por ejemplo:</p>
<ul><li>El consumo de carburante en litros/km</li><li>Emisiones contaminantes en kg CO2/km</li><li>Tiempo de recorrido en función de la velocidad de la vía</li><li>Mayor o menor factor de consumo en función de la carga y la pendiente</li></ul>
<p>El valor final puede ser comparado entre distintas alternativas para encontrar la ruta óptima en función del tiempo y los costes económicos y/o ecológicos que estemos dispuestos a asumir.</p>
<h2><strong>Añadir topología a una red en PostGIS</strong></h2>
<h3><strong>Activar las extensiones PostGIS y pgRouting</strong></h3>
<p>Lo primero que necesitamos es que la base de datos tenga activadas las extensiones PostGIS y pgRouting:</p>
<pre>
create extension postgis;
create extension pgrouting;
</pre>
<p>pgRouting es una extensión de PostGIS dedicada al análisis de redes con la que podremos añadir topología a <a rel="noreferrer noopener" href="https://programapa.wordpress.com/2020/11/06/tipos-de-datos-espaciales/" target="_blank">capas multilínea o multilinestring</a> como puede ser la red de carreteras, de metro o la red fluvial y empezar a usarlas para nuestros análisis de redes.</p>
<h3><strong>Importar y preparar los datos</strong></h3>
<p>Si obtenemos la capa de líneas desde OpenStreetMap y la importamos en pgRouting como cuento <a href="https://programapa.wordpress.com/2021/01/15/importar-la-red-viaria-de-osm-a-postgis-con-pgrouting-windows/">en esta otra entrada</a> la topología se generará automáticamente, pero lo habitual es que tengamos que construirla.</p>
<p>Para importar un .shp se puede usar el PostGIS Shapefile Import/Export manager, que viene por defecto con PostGIS y permite añadir a la base de datos que seleccionemos (que tenga activadas las extensiones del punto anterior) los shapefiles que se encuentren en nuestro PC. </p>
<p>Para crear la topología de redes es necesario asegurarnos de que <strong>la capa de líneas cuenta con las siguientes columnas</strong>:</p>
<ol><li>Una columna ID que identifique cada de forma individual</li><li>Una columna con la geometría de cada arco</li><li>Otra columna de tipo double que vaya a almacenar los costes de desplazamiento para cada arco</li><li>Una columna que vaya a almacenar el ID del nodo en el que empieza el arco (source) y otra columna que almacene el ID del nodo en el que termine (target)</li></ol>
<p>El siguiente código viene a añadir las columnas de costes y de nodos source y target, que son las que no suelen estar presentes en los shapefiles:</p>
<pre>
ALTER TABLE nombre_capa ADD COLUMN coste double precision;
ALTER TABLE nombre_capa ADD COLUMN source int;
ALTER TABLE nombre_capa ADD COLUMN target int;
</pre>
<h3><strong>Crear la topología de red</strong></h3>
<p>Una vez cumplamos estos requisitos, ejecutaremos el siguiente código para crear la topología de redes:</p>
<pre>
SELECT pgr_createTopology('nombre_capa', 0.001, 'geom', 'gid', 'source', 'target');
</pre>
<p>pgr_createTopology necesita las siguientes variables:</p>
<ul><li>El nombre de la capa/tabla a la que añadiremos la topología.</li><li>La tolerancia o umbral, habitualmente en metros, a partir del cual se asigna la misma posición en el espacio a los vértices que se encuentren dentro de él. Debe ser pequeña para que así reasigne solo aquellos vértices que realmente pudieran verse repetidos, por eso en el ejemplo se ha puesto 0.001.</li><li>Las columnas de geometría, de ID y source y target</li></ul>
<p>Una vez hecho esto, se creará una nueva tabla con el nombre de la capa de líneas a la que le hemos añadido la topología + el sufijo »_vértices_pgr» que almacenará los nodos de la red, y las columnas source y target se actualizarán almacenando para cada vértice los ID de los nodos a los que está conectado.</p>
<p>La capa ya estará lista para llevar acabo análisis de redes.</p>
  
  <br></details>
  
  <details>
  <summary><strong>Importar red viaria de OSM con pgRouting</strong></summary><br>
  
   <h2><strong>¿Qué es pgRouting?</strong></h2>
<p>Pgrouting es un complemento que amplía las posibilidades de calcular proximidades con PostGIS añadiendo funcionalidades de red. En vez de calcular distancias en línea recta entre objetos geométricos (como puedan ser dos puntos) se calcularán rutas en base a una red de nodos y vértices.</p>
<p>Además se puede añadir a la coctelera variables como el coste máximo por unidad de espacio, tiempos de recorrido, emisiones contaminantes, estado del tráfico y demás condicionantes para hallar la ruta óptima, similar a lo que hace Google con Maps. </p>
<p>Incluso pueden crearse rutas para visitar varios puntos y volver al origen (conocido como el <a rel="noreferrer noopener" href="https://es.wikipedia.org/wiki/Problema_del_viajante" target="_blank">Problema del Viajante</a>) optimizando los recursos disponibles.</p>
<p>Pero para hacer estos análisis necesitamos como base una red de vértices interconectados con nodos: capas vectoriales que almacenen callejeros de núcleos urbanos o redes de carreteras. OpenStreetMap (OSM) permite descargarnos geodatos de todos aquellos sitios cartografiados en su plataforma de forma totalmente gratuita, y además a la carta: podemos elegir el área concreta de la que descargaremos los datos.</p>
<p>En esta entrada veremos cómo descargar pgRouting e importar la red viaria de OSM a PostGIS y dejarla lista para hacer análisis de redes.</p>
<h2><strong>Descargar pgRouting</strong></h2>
<p>Si ya estáis usando PostGIS, pgRouting suele venir dentro del paquete de herramientas espaciales que incluye, por lo que no tendríais que hacer nada.</p>
<p>Si no es el caso, hay que usar la aplicación Stack Builder que trae PostgreSQL para descargar alguno de los paquetes de herramientas espaciales que se encuentran en la categoría de Spatial Extensions en los que se incluya tanto PostGIS como pgRouting.</p>
<h2><strong>Importar datos de OpenStreetMap</strong></h2>
<h3><strong>1- Obtener los datos</strong></h3>
<p>Como hemos dicho, OpenStreetMap es una plataforma flexible que permite descargarnos sus conjuntos de datos para zonas específicas que elijamos. En el post <a href="https://programapa.wordpress.com/2020/09/26/fuentes-de-geodatos/"><strong>Fuentes de geodatos</strong></a> hay una sección dedicada a esta plataforma con enlaces a distintos servicios de descarga en función del conjunto de datos que necesitemos.</p>
<p>Servicios como Geofabrik permiten la descarga de archivos .shp en algunos conjuntos de datos, pero la mayoría, si no son todos, descargan los archivos de OpenStreetMap en formato .osm, propio de esta plataforma. Por ello este post va dirigido a la importación de archivos .osm.</p>
<p>Para seleccionar datos de OSM usando coordenadas tendremos que acceder a la API desde el navegador y hacer una llamada añadiendo al final del enlace de la barra de direcciones el comando map?bbox= seguido de las coordenadas de una <em>bouncing box</em> que delimite el área del que queremos datos:</p>
<p>La bouncing box puede obtenerse en la página <a href="http://bboxfinder.com/#" target="_blank" rel="noreferrer noopener">bbox finder</a>
<p>Por ejemplo, la descarga de datos OSM para San Javier (Bolivia) podría ser el siguiente enlace:</p>
<p><a href="http://overpass-api.de/api/xapi?map?bbox=-62.522936,-16.285458,-62.488689,-16.266425" rel="nofollow">http://overpass-api.de/api/xapi?map?bbox=-62.522936,-16.285458,-62.488689,-16.266425</a></p>
<p>El último paso de este punto sería <strong>renombrar el archivo descargado</strong> para que su extensión sea .osm. Este archivo contendrá la cartografía OSM disponible para las cordenadas indicadas, pero <strong>pgRouting importará solo la red de carreteras.</strong></p>
<h3><strong>2- Crear base de datos con PostGIS y pgRouting </strong></h3>
<p>Para importar estos datos a PostgreSQL tendremos que crear una base de datos espaciales activando las extensiones PostGIS y pgRouting. Puede hacerse tanto a través de la interfaz de pgAdmin o del siguiente código:</p>
<pre>
CREATE DATABASE nombre
    WITH 
    OWNER = usuario
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;
CREATE EXTENSION postgis;
CREATE EXTENSION pgrouting;
</pre>
<p>También puede simplemente activarse estas extensiones en una base de datos ya existente.</p>
<h3><strong>3- Importar los datos a la base de datos</strong></h3>
<p>La importación deberá hacerse con la Consola de Windows o Símbolo de Sistema. </p>
<p>Lo primero una vez abierto es cambiar la ruta de trabajo a la ruta en la que se encuentra el archivo osm2pgrouting.exe. La ruta puede variar en función de dónde tengáis instalado PostgreSQL:</p>
<pre>
cd C:\Program Files\PostgreSQL\12\bin\
</pre>
<p>Después se debe señalar en primer lugar el nombre del archivo .exe a abrir (osm2pgRouting) junto a los siguientes parámetros:</p>
<pre>
osm2pgRouting --file C:\Users\usuario\Downloads\archivo.osm --dbname nombre_database --username usuario --password constraseña --conf mapconfig.xml --clean
</pre>
<p>&#8211;osm2pgRouting = el archivo .exe que ejecuta osm2pgrouting</p>
<p>&#8211;file = el archivo .osm a importar</p>
<p>&#8211;dbname = el nombre de la base de datos con PostGIS y pgRouting activados a la que se importará el archivo</p>
<p>&#8211;username = usuario de la base de datos PostgrSQL</p>
<p>&#8211;password = contraseña de acceso del usuario</p>
<p>&#8211;conf = la ruta en la que se encuentra el archivo mapconfig.xml. Este archivo indica a osm2pgRouting las tipologías de las vías y carreteras que tiene que importar, por lo que puede modificarse para quedarnos solo las que nos interesen. Si estuviese en la misma carpeta que osm2pgRouting bastaría con poner su nombre.</p>
<p>&#8211;clean elimina las tablas que ya existiesen en la base de datos con el mismo nombre</p>
<p>Si todo ha salido bien, tras tiempo (en función de la cantidad de datos) la consola de Windows devolverá al final del todo lo siguiente:</p>
<figure<img src="https://programapa.files.wordpress.com/2020/12/image-21.png?w=391" srcset="https://programapa.files.wordpress.com/2020/12/image-21.png 391w, https://programapa.files.wordpress.com/2020/12/image-21.png?w=150 150w, https://programapa.files.wordpress.com/2020/12/image-21.png?w=300 300w" sizes="(max-width: 391px) 100vw, 391px" /></figure>
<h3><strong>4- Resultados</strong></h3>
<p>Dentro de la base de datos que hemos indicado en los parámetros veremos creadas nuevas tablas con los datos de OpenStreetMap:</p>
<figure<img src="https://programapa.files.wordpress.com/2020/12/image-22.png?w=186" srcset="https://programapa.files.wordpress.com/2020/12/image-22.png 186w, https://programapa.files.wordpress.com/2020/12/image-22.png?w=150 150w" sizes="(max-width: 186px) 100vw, 186px" /></figure>
<p>Entre las ventajas de usar datos OSM para nuestros análisis de redes e importarlos con este sistema es que <strong>la topología se genera automáticamente.</strong> Las tablas que usaremos para hacer los análisis de redes serán <em>ways </em>(arcos) y <em>ways_vertices </em>(nodos).</p>
<p>Si lo visualizáramos en QGIS obtendríamos algo así:</p>
<figure<img src="https://programapa.files.wordpress.com/2021/01/image-3.png?w=575" srcset="https://programapa.files.wordpress.com/2021/01/image-3.png 575w, https://programapa.files.wordpress.com/2021/01/image-3.png?w=150 150w, https://programapa.files.wordpress.com/2021/01/image-3.png?w=300 300w" sizes="(max-width: 575px) 100vw, 575px" /></figure>
<p>Cada arco termina en un nodo que conecta con otros arcos. En la tabla de atributos podemos obtener información como su identificador, el nombre de la vía, su longitud, con qué nodos conecta&#8230;</p>
<p>Cada nodo almacena su identificador y sus coordenadas.</p>
<p>¡Ya tendríamos listo todo para hacer análisis de redes ya sea en PostGIS o en QGIS!</p> 
    
  <br></details>
