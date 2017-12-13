//
//  LectorLocalJson.h
//  Elefantes Blancos
//
//  Created by Ihonahan Buitrago on 9/11/13.
//  Copyright (c) 2013 Ministerio de Educacion Nacional. All rights reserved.
//
//  Esta clase envuelve y centraliza los métodos para leer archivos JSon locales
//  y extraer su información.
//

#import <Foundation/Foundation.h>

@interface LectorLocalJson : NSObject


/*!
 @method obtenerPrimerElementoJsonDeArchivo:
 @abstract
 Método estático que lee el archivo JSon dado y obtiene el primer (o único) objeto JSon,
 y lo retorna en un objeto tipo NSDictionary.
 
 @param nombreArchivo
 Nombre del archivo JSon que será leído.
 */
+ (NSDictionary *)obtenerPrimerElementoJsonDeArchivo:(NSString *)nombreArchivo;

/*!
 @method obtenerElementosJsonDeArchivo:
 @abstract
 Método estático que lee el archivo JSon dado y obtiene todos los objetos JSon contenidos,
 y los retorna en un objeto tipo NSArray que contendría objetos tipo NSDictionary.
 
 @param nombreArchivo
 Nombre del archivo JSon que será leído.
 */
+ (NSArray *)obtenerElementosJsonDeArchivo:(NSString *)nombreArchivo;


/*!
 @method obtenerDuplasDeArchivo: conNombreLlave: yNombreValor:
 @abstract
 Método estático que lee el archivo JSon dado y obtiene todos los objetos JSon contenidos,
 y los retorna en un objeto tipo NSArray que contendría objetos tipo DuplaLlaveValor con 
 los datos del archivo. Este método es ideal para JSon que contenga duplas o parejas de 
 llave - valor, donde la llave sea un valor numérico y el valor una cadena de caracteres.
 
 @param nombreArchivo
 Nombre del archivo JSon que será leído.
 
 @param llave
 Nombre del atributo llave o identificador en el objeto JSON.
 
 @param valor
 Nombre del atributo valor o texto en el objeto JSON.
 */
+ (NSArray *)obtenerDuplasDeArchivo:(NSString *)nombreArchivo conNombreLlave:(NSString *)llave yNombreValor:(NSString *)valor;

@end
