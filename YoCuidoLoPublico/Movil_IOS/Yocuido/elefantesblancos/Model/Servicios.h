//
//  Servicios.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 4/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "Definiciones.h"


@interface Servicios : NSObject



+ (void)consultarCantidadElefantesPorRegionesConBloque:(void (^)(NSArray *regionesArray, NSError *error))bloque;

+ (void)consultarDepartamentosPorRegion:(int)region conBloque:(void (^)(NSArray *deptosArray, NSError *error))bloque;

+ (void)consultarMunicipiosPorDepartamento:(long)depto conBloque:(void (^)(NSArray *municipiosArray, NSError *error))bloque;

+ (void)consultarElefantesPorMunicipio:(long)municipio conBloque:(void (^)(NSArray *elefantesArray, NSError *error))bloque;

+ (void)consultarElefantesPorCodigoMunicipio:(NSString *)municipio conBloque:(void (^)(NSArray *elefantesArray, NSError *error))bloque;

+ (void)consultarElefantesPorLatitud:(CGFloat)latitud yLongitud:(CGFloat)longitud conBloque:(void (^)(NSArray *elefantesArray, NSError *error))bloque;

+ (void)consultarDetalleElefantes:(long long)elefante conBloque:(void (^)(NSDictionary  *elefanteDiccionario, NSError *error))bloque;

+ (void)consultarElefantesMasVotadosConBloque:(void (^)(NSArray *elefantesArray, NSError *error))bloque;

+ (void)crearElefanteConDiccionario:(NSDictionary *)elefante conBloque:(void (^)(NSDictionary *elefanteDic, NSError *error))bloque;

+ (void)agregarFotoAElefante:(NSDictionary *)elefante conBloque:(void (^)(BOOL agregado, NSError *error))bloque;

+ (void)votarRechazoAElefante:(long long)elefante conBloque:(void (^)(int nuevosVotos, NSError *error))bloque;

+ (void)consultarMiElefante:(long long)idElefante conBloque:(void (^)(NSDictionary *elefante, NSError *error))bloque;

+ (void)obtenerImagenGrande:(long long)idGrande conBloque:(void (^)(NSString  *imagenBase64, NSError *error))bloque;

+ (void)modificarMiElefante:(NSDictionary *)elefante conIdElefante:(long long)idElefante conBloque:(void (^)(BOOL modificado, NSError *error))bloque;


+ (void)consultarRazonesDeElefantesConBloque:(void (^)(NSArray  *razonesArray, NSError *error))bloque;

+ (void)consultarRangosDeTiempoConBloque:(void (^)(NSArray  *rangosArray, NSError *error))bloque;


@end
