//
//  LectorLocalJson.m
//  Elefantes Blancos
//
//  Created by Ihonahan Buitrago on 9/11/13.
//  Copyright (c) 2013 Ministerio de Educacion Nacional. All rights reserved.
//

//#import "LectorLocalJson.h"

#import "LectorLocalJson.h"


@implementation LectorLocalJson



+ (NSDictionary *)obtenerPrimerElementoJsonDeArchivo:(NSString *)nombreArchivo
{
    // Debemos obtener primero el contenido a desplegar, que está en los archivos JSon agregados al bundle de la aplicación
    NSError *error = nil;
    NSString *rutaArchivo = [[NSBundle mainBundle] pathForResource:nombreArchivo ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:rutaArchivo options:NSDataReadingUncached error:&error];
    if (!error && data) {
        
        // Si todo va bien y cargamos el JSON, lo parseamos y manejamos para obtener la información a desplegar
        NSObject *contenidoBruto = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *contenidoArreglo = nil;
        
        if ([contenidoBruto isKindOfClass:[NSArray class]]) {
            contenidoArreglo = (NSArray *)contenidoBruto;
        } else if ([contenidoBruto isKindOfClass:[NSDictionary class]]) {
            contenidoArreglo = [NSArray arrayWithObject:(NSDictionary *)contenidoBruto];
        }
        
        if (contenidoArreglo && contenidoArreglo.count) {
            
            // Este diccionario contendrá el primer (y en teoría único) objeto del arreglo JSon, desde donde obtendremos
            // los datos básicos para desplegarlos en la web view.
            NSDictionary *contenidoDiccionario = [contenidoArreglo objectAtIndex:0];
            
            return contenidoDiccionario;
        }
    }
    
    return nil;
}


+ (NSArray *)obtenerElementosJsonDeArchivo:(NSString *)nombreArchivo
{
    // Debemos obtener primero el contenido a desplegar, que está en los archivos JSon agregados al bundle de la aplicación
    NSError *error = nil;
    NSString *rutaArchivo = [[NSBundle mainBundle] pathForResource:nombreArchivo ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:rutaArchivo options:NSDataReadingUncached error:&error];
    if (!error && data) {
        
        // Si todo va bien y cargamos el JSON, lo parseamos y manejamos para obtener la información a desplegar
        NSObject *contenidoBruto = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *contenidoArreglo = nil;
        
        if ([contenidoBruto isKindOfClass:[NSArray class]]) {
            contenidoArreglo = (NSArray *)contenidoBruto;
        } else if ([contenidoBruto isKindOfClass:[NSDictionary class]]) {
            contenidoArreglo = [NSArray arrayWithObject:(NSDictionary *)contenidoBruto];
        }
        
        return contenidoArreglo;
    }
    
    return nil;
}

+ (NSArray *)obtenerDuplasDeArchivo:(NSString *)nombreArchivo conNombreLlave:(NSString *)llave yNombreValor:(NSString *)valor
{
    // Debemos obtener primero el contenido a desplegar, que está en los archivos JSon agregados al bundle de la aplicación
    NSError *error = nil;
    NSString *rutaArchivo = [[NSBundle mainBundle] pathForResource:nombreArchivo ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:rutaArchivo options:NSDataReadingUncached error:&error];
    if (!error && data) {
        
        // Si todo va bien y cargamos el JSON, lo parseamos y manejamos para obtener la información a desplegar
        NSObject *contenidoBruto = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *contenidoArreglo = nil;
        
        if ([contenidoBruto isKindOfClass:[NSArray class]]) {
            contenidoArreglo = (NSArray *)contenidoBruto;
        } else if ([contenidoBruto isKindOfClass:[NSDictionary class]]) {
            contenidoArreglo = [NSArray arrayWithObject:(NSDictionary *)contenidoBruto];
        }

        if (contenidoArreglo && contenidoArreglo.count) {
            NSMutableArray *resultado = [[NSMutableArray alloc] init];
            for (NSDictionary *diccionario in contenidoArreglo) {
                NSMutableDictionary *elemento = [[NSMutableDictionary alloc] init];
                NSNumber *llaveNumber = [NSNumber numberWithLongLong:[[diccionario objectForKey:llave] longLongValue]];
                [elemento setValue:llaveNumber forKey:@"llave"];
                [elemento setValue:[NSString stringWithFormat:@"%@", [diccionario objectForKey:valor]] forKey:@"valor"];
                
                [resultado addObject:elemento];
                elemento = nil;
            }
            
            return resultado;
        }
    }
    
    return nil;
}



@end
