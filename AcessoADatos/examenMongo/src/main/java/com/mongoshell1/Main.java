package com.mongoshell1;

import java.util.Arrays;
import java.util.Scanner;

import org.bson.conversions.Bson;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Accumulators;
import com.mongodb.client.model.Aggregates;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Sorts;
import com.mongodb.client.model.Updates;

public class Main {

    // Ejercicio 1: Búsqueda por rango de calorías
    static void buscarPorCalorias(Scanner teclado, MongoCollection<org.bson.Document> coleccion) {
        System.out.print("Calorías mínimas: ");
        int minCalorias = Integer.parseInt(teclado.nextLine());
        System.out.print("Calorías máximas: ");
        int maxCalorias = Integer.parseInt(teclado.nextLine());

        Bson filtro = Filters.and(
            Filters.gte("calorias", minCalorias),
            Filters.lte("calorias", maxCalorias)
        );

        System.out.println("\n--- Recetas encontradas ---");
        coleccion.find(filtro)
                 .sort(Sorts.ascending("calorias"))
                 .forEach(doc -> System.out.println("   - " + doc.get("nombre")));
    }

    // Ejercicio 2: Recetas con ingrediente específico y dificultad
    static void buscarPorIngredienteYDificultad(Scanner teclado, MongoCollection<org.bson.Document> coleccion) {
        System.out.print("Ingrediente: ");
        String ingrediente = teclado.nextLine();
        System.out.print("Dificultad (Fácil/Media/Difícil): ");
        String dificultad = teclado.nextLine();

        Bson filtro = Filters.and(
            Filters.eq("ingredientes", ingrediente),
            Filters.eq("dificultad", dificultad)
        );

        System.out.println("\n--- Recetas encontradas ---");
        coleccion.find(filtro)
                 .forEach(doc -> System.out.println("   - " + doc.get("nombre")));
    }

    // Ejercicio 3: Recetas más recientes por categoría
    static void recetasRecientesPorCategoria(MongoCollection<org.bson.Document> coleccion) {
        System.out.println("\n--- Top 3 recetas más recientes por categoría ---");
        
        coleccion.aggregate(Arrays.asList(
            new org.bson.Document("$sort", new org.bson.Document("fecha_publicacion", -1)),
            new org.bson.Document("$group", new org.bson.Document()
                .append("_id", "$categoria")
            ),
            new org.bson.Document("$project", new org.bson.Document()
                .append("_id", 1)
                .append("recetas", new org.bson.Document("$slice", Arrays.asList("$recetas", 3)))
            )
        )).forEach(doc -> System.out.printf("   - Nombre: %s | Categoria: %s\n", doc.get("nombre"), doc.get("categoria")));
    }

    // Ejercicio 4: Actualización múltiple con condiciones
    static void actualizacionMultiple(Scanner teclado, MongoCollection<org.bson.Document> coleccion) {
        System.out.print("Ingredientes (separados por comas): ");
        String[] ingredientes = teclado.nextLine().split(",");
        for (int i = 0; i < ingredientes.length; i++) {
            ingredientes[i] = ingredientes[i].trim();
        }

        System.out.print("Nuevo ingrediente a añadir: ");
        String nuevoIngrediente = teclado.nextLine();

        Bson filtro = Filters.expr(
            new org.bson.Document("$gte", Arrays.asList(
                new org.bson.Document("$size", new org.bson.Document("$filter", 
                    new org.bson.Document()
                        .append("input", "$ingredientes")
                        .append("as", "ing")
                        .append("cond", new org.bson.Document("$in", Arrays.asList("$$ing", Arrays.asList(ingredientes))))
                )), 2
            ))
        );

        coleccion.updateMany(filtro, Updates.addToSet("ingredientes", nuevoIngrediente));
        System.out.println("Actualización completada");
    }

    // Ejercicio 5: Recetas por mes
    static void recetasPorMes(MongoCollection<org.bson.Document> coleccion) {
            coleccion.aggregate(Arrays.asList(
                Aggregates.group("$fecha_publicacion", Accumulators.sum("cuenta", 1))
            )).forEach(doc -> System.out.println(doc.toJson()));
    }

    public static void main(String[] args) {
        MongoDatabase database;
        MongoCollection<org.bson.Document> coleccion;
        try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017")) {
            database = mongoClient.getDatabase("GestionDeRecetas");
            coleccion = database.getCollection("recetas");
 
            boolean flag = true;
            try (Scanner teclado = new Scanner(System.in)) {
            while (flag) {
                System.out.println("Dime una opcion:");
                System.out.println("    1. Busqueda por rango de calorias");
                System.out.println("    2. Recetas con ingrediente especifico y dificultad");
                System.out.println("    3. Recetas mas recientes por categoria");
                System.out.println("    4. Actualizacion multiple con condiciones");
                System.out.println("    5. Recetas por mes");
                System.out.println("    6. Salir");
                System.out.print("Opcion: ");
                String opcion = teclado.nextLine();
                
                switch (opcion) {
                        case "1" -> { 
                            System.out.println("Busqueda por rango de calorias");
                            buscarPorCalorias(teclado, coleccion);
                        }
                        case "2" -> {
                            System.out.println("Recetas con ingrediente especifico y dificultad");
                            buscarPorIngredienteYDificultad(teclado, coleccion);
                        }
                        case "3" -> {
                            System.out.println("Recetas mas recientes por categoria");
                            recetasRecientesPorCategoria(coleccion);
                        }
                        case "4" -> {
                            System.out.println("Actualizacion multiple con condiciones");
                            actualizacionMultiple(teclado, coleccion);
                        }
                        case "5" -> {
                            System.out.println("Recetas por mes de publicacion");
                            recetasPorMes(coleccion);
                        }
                        case "6" -> {
                            flag = false;
                        }
                        default -> System.out.println("No es correcto");
                    }
                }
            }
        }   
    }
}