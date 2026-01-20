from django.db import models
# Create your models here.
# Al aplicar esta herencia, Django va a saber que Author es una tabla en la BD
class Author (models.Model):
    name=models.CharField (verbose_name='Nombre', # etiqueta dentro de la tabla
    max_length= 100,
    default=''
    )
    last_name=models.CharField(verbose_name='Apellido',
    max_length=150,
    default=''
    )
    age=models.PositiveSmallIntegerField (verbose_name='Edad')
    mail=models.EmailField (verbose_name='Correo electromagnetico', default='')
    
    def __str__(self):
        return f"{self.name} {self.last_name}"

class Book (models.Model):
    title=models.CharField('Título del libro',max_length=255,unique=True)
    #Unique=True , Django no va a permitir introducir dos libros con títulos
    #iguales. Cuando cree este campo en la BD solo permitir valores diferentes.
    cod=models.CharField('Codigo',max_length=15,unique=True)
    author=models.ManyToManyField(Author)
    #Con esto establecemos la relación entre las dos tablas.
    def __str__(self):
        return self.title