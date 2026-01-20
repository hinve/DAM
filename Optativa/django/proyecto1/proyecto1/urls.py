from django.contrib import admin
from django.urls import path
#from . import views # Importo nuestro módulo views
from HolaMundo.views import otra_mas, autor_list,libro_list

urlpatterns = [
    path('', otra_mas), #quí no habría que meter la carpeta
    #path('otramas/', views.home),
    path('admin/', admin.site.urls),
    path('author/',autor_list),
    path('book/',libro_list),
]