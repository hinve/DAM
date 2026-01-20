from django.http import HttpResponse #Necesario para poder responder al cliente
#con httpresponse, podemos responder con texto plano o con html
from django.shortcuts import render

from HolaMundo.models import Author, Book

#forma de responder al cliente cuando hace un http
def hola_mundo (request): # El request captura las peticiones de los clientes
    return HttpResponse ("<h1>hola mundo</h1>")

def otra_mas (request):
    autor = Author.objects.all()
    return render(request,'index.html', {'authors':autor})
    autor.html
    
def autor_list (request):
    autor=Author.objects.all()
    return render(request,'author.html',{'authors':autor})
    
def libro_list (request):
    libro=Book.objects.all()
    return render(request,'book.html',{'books':libro})

