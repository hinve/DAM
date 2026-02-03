package com.mongoshell1;

import org.bson.Document;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Sorts;
import com.mongodb.client.model.Updates;

public class Main {
public static void main(String[] args) {
        try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017")) {
            MongoDatabase database = mongoClient.getDatabase("almacen");
            MongoCollection<Document> coleccion = database.getCollection("articulos");

            // 1. Buscar productos por nombre (usando "Zapatillas deportivas" del JSON)
            System.out.println("--- 1. Buscando 'Zapatillas deportivas' ---");
            coleccion.find(Filters.eq("nombre", "Zapatillas deportivas")).forEach(doc -> System.out.println(doc.toJson()));

            // 2. Añadir nuevos productos
            System.out.println("\n--- 2. Añadiendo 'Monitor LED' ---");
            Document nuevo = new Document("nombre", "Monitor LED")
                                .append("categoria", "electronica")
                                .append("precio", 150.0)
                                .append("stock", 5);
            coleccion.insertOne(nuevo);
            coleccion.find(Filters.eq("nombre", "Monitor LED")).forEach(doc -> System.out.println(doc.toJson()));

            // 3. Buscar productos por categoría (usando "Ropa" del JSON)
            System.out.println("\n--- 3. Productos de la categoría 'Ropa' ---");
            coleccion.find(Filters.eq("categoria", "Ropa")).forEach(doc -> System.out.println(doc.toJson()));

            // 4. Mostrar productos con stock inferior a 10 
            // (Nota: Solo el último artículo del JSON tiene stock definido)
            System.out.println("\n--- 4. Productos con stock < 10 ---");
            coleccion.find(Filters.lt("stock", 10)).forEach(doc -> System.out.println(doc.toJson()));

            // 5. Productos de una categoría (Calzado) ordenados alfabéticamente
            System.out.println("\n--- 5. Calzado ordenado (A-Z) ---");
            coleccion.find(Filters.eq("categoria", "Calzado"))
                     .sort(Sorts.ascending("nombre"))
                     .forEach(doc -> System.out.println(doc.toJson()));

            // 6. Actualizar precios: Subir 5% a la categoría 'electronica'
            System.out.println("\n--- 6. Incrementando 5% a la categoría 'electronica' ---");
            coleccion.updateMany(Filters.eq("categoria", "electronica"), Updates.mul("precio", 1.05));
            coleccion.find(Filters.eq("categoria", "electronica")).forEach(doc -> System.out.println(doc.toJson()));
        }
    }
}