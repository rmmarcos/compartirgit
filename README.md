# compartirgit

El presente documento resume y organiza las tareas y procesos necesarios para crear, documentar y compartir funciones en entorno R. No obstante, la esencia del proceso es común a otros lenguajes de programación por lo que el procedimiento puede replicarse (con sus correspondientes adaptaciones) a otros entornos y lenguajes.

## CREAR Y COMPARTIR SCRIPTS CON RSTUDIO Y GITHUB {#config}

### Instalar "devtools" en RStudio

El primer paso es instalar el paquete `devtools` en RStudio. Este paquete contiene fundamentalmente herramientas y funciones para desarrolladores en entorno R. Es por tanto esencial para crear y documentar paquetes, pero también para conectar con repositorios digitales que permitan su uso y desarrollo compartido.

```{r,eval=F}
install.packages("devtools")
```

	

### Crear cuenta GitHub

[Git](https://git-scm.com/download/win) y [GitHub](https://github.com/signup?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home) son a día de hoy la combinación de lenguaje y plataforma web de uso más extendido entre desarrolladores. Git es un software de **control de versiones** que comunica de forma interactiva con el sitio web de GitHub para crear copias *en la nube* de scripts, paquetes y otros documentos similares.

GitHub establece un *puente* entre nuestro proyecto en modo *local* y la comunidad potencial de usuarios de nuestra(s) herramienta(s). También permite documentar exhaustivamente nuestros proyectos de herramientas y el desarrollo colaborativo, es decir, múltiples desarrolladores trabajando de manera simultánea en un mismo proyecto.

Para completar la instalación básica de las herramientas a utilizar vamos a:

1. Crear una cuenta en [GitHub](https://github.com/signup?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home)
2. Instalar la aplicación de escritorio de [Git](https://git-scm.com/download/win)

La instalación es sencilla, con aceptar todas las opciones por defecto es suficiente.


### Configurar git en nuestro equipo

Una vez instalado Git necesitamos vincular la instalación a un usuario de GitHub existente de modo que podamos subir (`push`) y bajar (`pull`) contenidos. Para ellos hay que usar el `git bash` (lo puedes buscar en el menú de inicio Windows) o terminal de git. Existen otras formas pero esta es bastante sencilla. Una vez abierta la terminal tienes que ejecutar las siguientes instruccion *especificando las credenciales de tu cuenta de GitHub*:

```{bash, eval=F}
git config --global user.name 'yourGitHubUsername'
git config --global user.email 'name@provider.com'
```


###  Configurar git en RStudio 

Lo siguiente es configurar (o comprobar) que RStudio puede acceder a git. Si se han seguido los pasos correctamente debería estar ya configurado. Para verificarlo ejecuta las siguentes instrucciones *en la terminal de RSudio (no en la consola)*:

```{bash, eval=F}
where git #(which si estamos en Linux) 
git --version
```

Si todo es correcto obtendremos las rutas y la versión instalada de git.

Lo siguiente es vincular la sesión de RStudio a GitHub. Existen varias alternativas, aquí usaremos un *token* temporal. Basta con lanzar las siguientes instruccion *en la consola*:

```{r, eval=F}
usethis::create_github_token()
gitcreds::gitcreds_set()
usethis::use_github()
```


### Crear nuevo proyecto como "github repository" -->

Ya está todo list para empezar a trabajar. Lo único pendiente es crear un proyecto en RStudio, asegurándonos de que lo hacemos como un repositorio de GitHub. sigue los siguientes pasos:

1. File/New project...^[Ten en cuenta que el nombre del proyecto será el del repositorio final en GitHub.]
2. New directory/New project
3. Activar "Create github repository"


### Crear y compartir un script

Vamos a crear un script simple de R vacío y lo vamos a subir a un repositorio en GitHub. Voy a llamara mi script *funciones.R* y en él voy a crear una función sencilla que sirve para calcular el índice de vegetación NDVI con información procedente de una imagen digital de satélite que recoja la respuesta espectral del territorio:

```{r, eval=F}
ndvi <- function(red,nir){
  return((nir-red)/(nir+red))
}
```

Una vez creado tenemos que ir a la ventana de Git. Puedes encontrala entre las pestañas de subventana superior derecha en RStudio. En dicha ventana verás un listado de los ficheros y carpetas que están en el proyecto y una serie de opciones:

* `Commit`: esta opción es un híbrido entre guardar y crear un **punto de control**. Mediante esta acción consolidamos todos los cambios que se hayan producido en el proyecto, pero también creamos una **version** a la que podemos regresar si fuera necesario^[De ahí lo de control de versiones].
* `Push`: sube los contenidos actuales del proyecto a GitHub. La primera vez que se ejecuta también crea el repositorio en nuestra web.
* `Pull`: acción inversa a `Push`, recupera los cambios de un repositorio en la web y los incorpora a nuestra versión local^[En el caso de que estemos colaborando con otr@s desarrolladores esta opción permite trabajar con versiones actualizadas y en sincronía con el resto].

Una vez creado el script (con o sin contenido, ahora mismo da igual) **Commiteamos** los cambios^[Cada vez que ejecutamos `Commit` debemos crear un mensaje que describa los cambios realizados.] y subimos el repositorio, `Commit`+`Push`. Solo queda ir a GitHub y comprobar que se ha creado el nuevo repositorio.

Podemos seguir trabajando y actualizando el repositorio mediante nuevos `Commit`+`Push` o permitir que otros usuarios o colegas contribuyan al desarrollo.


## CLONAR UN REPOSITORIO DE GITHUB

Hemos visto como crear y compartir código de manera sencilla. Pero puede ser que nuestro rol sea el de colaborar o simplemente usar los contenidos creados por terceros. De hecho esto último es lo más habitual. Podemos crear una copia de un repositorio existente creado por otro usuario siguiendo estos pasos.

### Crear nuevo proyecto como "github repository"

Vamos a crear un nuevo proyecto pero esta vez no uno vacío si no uno que *apunta* a un repositorio existente en GitHub:

1. File/New R project...
2. Version control/Git
3. Especificar la url del repositorio: https://github.com/rmmarcos/myfirstpackage.git
4. Aceptar y crear

Esto replica la estructura del repositorio en nuestro proyecto local. Ahora podemos modificar alguno de los ficheros y enviarlos `Commit`+`Push` como sugerencia de actualización^[El administrador decidirá si acepta o no nuestros cambios.] del repositorio. Asimismo, podemos ejectuar `Pull` para recuperar la versión aprobada más reciente del repositorio.


## CREAR Y COMPARTIR PAQUETES CON RSTUDIO Y GITHUB

Un script con funciones es **per se** una manera de crear y compartir herramientas. Con lo visto hasta el momento ya podríamos hacerlo, pero podemos ir un paso más allá y crear un `paquete` que contenga las funciones y facilite su uso y diseminación. La principal diferencia reside en que el paquete requiere una documentación más exhaustiva de las funciones y al mismo tiempo provee la estructura adecuada para ello.

Además de la [configuración ya vista](#config), es necesario instalar el paquete `roxygen` que contiene varías utilidades que simplifican considerablemnte el proceso de creación y documentación del paquete:

```{r, eval=F}
install.packages('roxygen')
```

De nuevo tendremos que crear un proyecto nuevo y vacío, pero en esta ocasión del tipo `R package`.

1. Crear nuevo proyecto como "github repository"
2. File/New R project...
3. New directory/New R package
4. Activar "Create github repository"
5. Crearlo con nombre `myfirstpackage`

Igual que en elcaso del script, tenemos que crear un un script en blanco y agregar las funciones a incluir. En el caso de un paquete existen una serie de convenciones en lo relativo a la estructura de directoesio. Por ejemplo, encontraremos un carpeta llamada *R* donde debemos guardar los script con funciones. Repetiremos la misma función para el cálculo del NDVI.


```{r, eval=F}
ndvi <- function(red,nir){
  return((nir-red)/(nir+red))
}
```

Lo siguiente es crear la documentación de la (o las) funciones. En realidad este paso lo que hace es crear la página de ayuda que aparece cuando invocamos la ayuda de una función:

```{r, eval=F}
help('funcion')
```

Es aquí donde entra en juego el paquete `roxygen` en combinación con `devtools`. A través de una **sencilla** estructura de comentarios podemos especificar y describir los parámetros de nuestras funciones:

```{r, eval=F}
#' Calculate NDVI
#'
#' This function caculates the normalized difference vegetation index.
#'
#' @param red value or vector with reflectance in the Red wavelenght
#' @param nir value or vector with reflectance in the NIR wavelenght
#' @return NDVI value
#' @export
#' 
#' ndvi <- function(red,nir){
  return((nir-red)/(nir+red))
}
```

Una vez hecho esto podemos crear la ayuda de la función^[En caso de que haya más de una función crearemos un bloque de código de este tipo para cada una de ellas just encima de la declaración de la función.]:

```{r, eval=F}
devtools::document()
```
 
Una vez lo tenemos finalizamos con `Commit`+`Push`.


## INSTALAR UN PAQUETE DESDE GITHUB

En el paso anterior creamos un repositorio en GitHub que contiene un paquete de R. Ahora ese paquete puede ser utilizado y cualquiera de vosotr@s podría descargarlo y utilizarlo en su instalación de R. El procedimiento es el mismo que con cualquier otro paquete:

1. `install.packages('paquete')`
2. `library(paquete)`

La diferencia reside en que nuestro paquete en su estado actual no forma parte de la distribución oficial de R, sino que lo hemo autopublicado mediante GitHub. No obstante, puede instalarse utilizando las 'devtools':

```{r, eval=F}
#devtools::install_github("yourusername/myfirstpackage")
devtools::install_github("rmmarcos/myfirstpackage")
```

*IMPORTANTE:* si queremos reinstalar el paquete tras haber efectuado alguna modificación tenemos que **desativarlo**:

```{r, eval=F}
detach("package:myfirstpackage", unload=TRUE)
```

Una vez instalado procedemos como con cualquier otro paquete:

```{r, eval=F}
library(myfirstpackage)
help(ndvi)
```

Veamos un ejemplo aplicado:

```{r}
rm(list = ls())
library(raster)
library(tidyverse)
library(myfirstpackage)
#Leer imágenes pre y post incendio ()
prefuego <- raster::stack('./data/S2A_20190625.tif')
postfuego <- raster::stack('./data/S2A_20190705.tif')
nbrpre <- ndvi(prefuego$S2A_20190625.4,prefuego$S2A_20190625.5)
nbrpost <- ndvi(postfuego$S2A_20190705.4,postfuego$S2A_20190705.5)
dNBR <- (nbrpost-nbrpre)*1000
dNBR.df <- as.data.frame(dNBR, xy=T)
dNBR.df %>%
  rename(dNBR=layer) %>%
  ggplot() +
    geom_tile(aes(x,y,fill=dNBR)) +
    scale_fill_steps2(low='darkgreen',mid='Ivory',high = 'tomato4',
                      breaks = c(-Inf,-100,99,440,660,Inf)) +
    theme_minimal()
```


## PUBLICAR PAQUETE EN ZENODO Y CREAR ENTRADA BIBLIOGRÁFICA

Para finalizar el proceso vamos a publicar nuestro código/paquete mediante un repositorio alternativo cuya ventaja principal es que nos permite crear un DOI (Digital Object Identifier) de modo que podemos crear referencia completas e inequívocas que pueden integrarse en publicaciones o documentos académico-científicos. Utilizaremos la plataforma [Zenodo](https://zenodo.org/).

1. Iniciar sesión en Zenodo usando nuestras credenciales de GitHub.
2. Ir a la ventana de GitHub. en el perfil y activar los repositorios a enlazar con zenodo.
3. Ir a GitHub y crear una **release**, un `README` (si no se tenía ya) y un `CITATION.cff`.
4. Editar `README` para incluir el DOI badge.
5. Editar `CITATION` desde el ejemplo para crear una referencia descargable.
