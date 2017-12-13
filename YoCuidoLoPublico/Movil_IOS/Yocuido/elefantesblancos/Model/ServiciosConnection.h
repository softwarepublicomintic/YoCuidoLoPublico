//
//  ServiciosConnection.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 17/01/14.
//  Copyright (c) 2014 softwareworks. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Definiciones.h"

@interface ServiciosConnection : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property(strong) NSURLConnection *crearConexion;
@property(strong) NSURLConnection *agregarFotoConexion;
@property(strong) NSURLConnection *editarConexion;

@property(strong) crearBloque creacionBloque;
@property(strong) agregarFotoBloque agregadaFotoBloque;
@property(strong) agregarFotoBloque editarBloque;

@property(strong) NSMutableData *crearData;
@property(strong) NSMutableURLRequest *crearRequest;

@property(strong) NSMutableData *agregarFotoData;
@property(strong) NSMutableURLRequest *agregarFotoRequest;

@property(strong) NSMutableData *editarData;
@property(strong) NSMutableURLRequest *editarRequest;



- (void)iniciarCrearElefante:(NSDictionary *)elefante conBloque:(crearBloque)bloque;

- (void)iniciarAgregarFotoElefante:(NSDictionary *)elefante conBloque:(agregarFotoBloque)bloque;

- (void)iniciarEditarElefante:(NSDictionary *)elefante conIdElefante:(long long)idElefante conBloque:(agregarFotoBloque)bloque;

@end
