//
//  ServiciosGeoLocalizacion.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 13/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "Definiciones.h"

#import <CoreLocation/CoreLocation.h>


@interface ServiciosGeoLocalizacion : NSObject <CLLocationManagerDelegate>


@property(assign) CLLocationCoordinate2D ultimaUbicacion;
@property(nonatomic, strong) CLLocationManager *ubicacion;



+ (void)obtenerCoordenadasParaDireccion:(NSString *)direccion conBloque:(void (^)(NSDictionary *ubicacionRespuesta, NSError *error))bloque;

+ (void)obtenerDireccionParaCoordenadas:(CLLocationCoordinate2D)coordenada conBloque:(void (^)(NSDictionary *ubicacionRespuesta, NSError *error))bloque;


+ (ServiciosGeoLocalizacion *)sharedServiciosGeoLicalizacion;

- (void)iniciarUbicacionGPS;


@end
