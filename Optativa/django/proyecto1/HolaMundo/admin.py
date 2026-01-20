from django.contrib import admin
from HolaMundo.models import Author
from HolaMundo.models import Book

# Register your models here.
admin.site.register(Author)
admin.site.register(Book)