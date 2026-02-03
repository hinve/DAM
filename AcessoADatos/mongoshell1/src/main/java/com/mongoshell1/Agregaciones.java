package com.mongoshell1;

import java.util.Arrays;

import org.bson.Document;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Accumulators;
import com.mongodb.client.model.Aggregates;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Projections;
import com.mongodb.client.model.Sorts;

public class Agregaciones {
        public static void main(String[] args) {
        try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017")) {
            MongoDatabase database = mongoClient.getDatabase("AlmacenDB");
            MongoCollection<Document> coleccion = database.getCollection("articulos");

            // 1. Dar de alta 3 artículos adicionales
            System.out.println("--- 1. Insertando 3 nuevos artículos ---");
            coleccion.insertMany(Arrays.asList(
                new Document("nombre", "Teclado").append("categoria", "electronica").append("precio", 25.0).append("stock", 15),
                new Document("nombre", "Libro de Java").append("categoria", "Libros").append("precio", 40.0).append("stock", 8),
                new Document("nombre", "Calcetines").append("categoria", "Ropa").append("precio", 5.0).append("stock", 50)
            ));

            // 2. Calcular el precio promedio de todos los productos
            System.out.println("\n--- 2. Precio promedio total ---");
            coleccion.aggregate(Arrays.asList(
                Aggregates.group(null, Accumulators.avg("promedio", "$precio"))
            )).forEach(doc -> System.out.println(doc.toJson()));

            // 3. Contar el número de productos por categoría
            System.out.println("\n--- 3. Cantidad de productos por categoría ---");
            coleccion.aggregate(Arrays.asList(
                Aggregates.group("$categoria", Accumulators.sum("cuenta", 1))
            )).forEach(doc -> System.out.println(doc.toJson()));

            // 4. Encontrar el producto más caro
            System.out.println("\n--- 4. Producto con mayor precio ---");
            Document masCaro = coleccion.find().sort(Sorts.descending("precio")).first();
            System.out.println(masCaro.toJson());

            // 5. Encontrar los 5 productos más baratos
            System.out.println("\n--- 5. Top 5 productos más económicos ---");
            coleccion.find().sort(Sorts.ascending("precio")).limit(5).forEach(doc -> System.out.println(doc.toJson()));

            // 6. Mostrar nombre y precio de productos con stock < 10
            System.out.println("\n--- 6. Proyección: Nombre y Precio (Stock < 10) ---");
            coleccion.find(Filters.lt("stock", 10))
                     .projection(Projections.fields(Projections.include("nombre", "precio"), Projections.excludeId()))
                     .forEach(doc -> System.out.println(doc.toJson()));
        }
    }
}
