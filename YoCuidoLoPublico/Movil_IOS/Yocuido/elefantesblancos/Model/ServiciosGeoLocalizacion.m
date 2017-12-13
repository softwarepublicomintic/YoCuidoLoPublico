//
//  ServiciosGeoLocalizacion.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 13/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "ServiciosGeoLocalizacion.h"

@implementation ServiciosGeoLocalizacion


- (id)init
{
    self = [super init];
    if (self) {
        // Ubicación
        self.ubicacion = [[CLLocationManager alloc] init];
        self.ubicacion.delegate = self;
        
        if([self.ubicacion respondsToSelector:@selector(requestAlwaysAuthorization)]){
            NSUInteger code = [CLLocationManager authorizationStatus];
            if (code == kCLAuthorizationStatusNotDetermined && ([self.ubicacion respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.ubicacion respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
                // choose one request according to your business.
                if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                    [self.ubicacion requestAlwaysAuthorization];
                } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                    [self.ubicacion  requestWhenInUseAuthorization];
                } else {
                    NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
                }
            }
        }
        
        self.ubicacion.desiredAccuracy = kCLLocationAccuracyBest;
        self.ubicacion.distanceFilter=kCLDistanceFilterNone;
        [self.ubicacion requestWhenInUseAuthorization];
        [self.ubicacion startMonitoringSignificantLocationChanges];
    }
    
    return self;
}


+ (void)obtenerCoordenadasParaDireccion:(NSString *)direccion conBloque:(void (^)(NSDictionary *ubicacionRespuesta, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedGeoUrlServidor];
    NSString *service = [Definiciones sharedGeoServicioGeoReferencia];
    service = [NSString stringWithFormat:service, direccion];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"313Fant3s"];
    
    [manager GET:urlService
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *jsonResponse = (NSDictionary *)responseObject;
             
             // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
             if (bloque && jsonResponse) {
                 BOOL success = [[jsonResponse objectForKey:@"success"] boolValue];
                 if (!success) {
                     NSString *msg = @"Mensaje de error";
                     NSString *code = @"400";
                     NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"error", nil];
                     NSError *miError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                     bloque(nil, miError);
                 } else {
                     bloque(jsonResponse, nil);
                 }
             } else {
                 NSString *msg = @"Mensaje de error";
                 NSString *code = @"400";
                 NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"error", nil];
                 NSError *miError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                 if (bloque) {
                     bloque(nil, miError);
                 }
             }
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (bloque) {
                 bloque(nil, error);
             }
         }];
}



+ (void)obtenerDireccionParaCoordenadas:(CLLocationCoordinate2D)coordenada conBloque:(void (^)(NSDictionary *ubicacionRespuesta, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedGeoUrlServidor];
    NSString *service = [Definiciones sharedGeoServicioGeoInverso];
    service = [NSString stringWithFormat:service, coordenada.latitude, coordenada.longitude];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"313Fant3s"];
    
    [manager GET:urlService
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *jsonResponse = (NSDictionary *)responseObject;
             
             // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
             if (bloque && jsonResponse) {
                 BOOL success = [[jsonResponse objectForKey:@"success"] boolValue];
                 if (!success) {
                     NSString *msg = @"Mensaje de error";
                     NSString *code = @"400";
                     NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"error", nil];
                     NSError *miError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                     bloque(nil, miError);
                 } else {
                     NSDictionary *object = [jsonResponse objectForKey:@"object"];
                     NSString *direccion = [object objectForKey:@"address"];
//                     NSString *ciudad = [object objectForKey:@"cityName"];
                     NSString *zona = [object objectForKey:@"zone"];
                     NSString *codigoMunicipio = [NSString stringWithFormat:@"%lld", [[object objectForKey:@"code"] longLongValue]];
                     NSRange rango;
                     rango.location = 0;
                     rango.length = 5;
                     if([codigoMunicipio length]==4)
                         codigoMunicipio=[NSString stringWithFormat:@"0%@", codigoMunicipio];
                     codigoMunicipio = [codigoMunicipio substringWithRange:rango];
                     int codigo = [codigoMunicipio intValue];
                     int codDepto = codigo / 1000;
                     NSString *codDeptoStr = [NSString stringWithFormat:@"%d", codDepto];
                     
                     NSDictionary *respuesta = @{@"codigo_municipio" : codigoMunicipio,
                                                 @"codigo_departamento" : codDeptoStr,
                                                 @"direccion" : direccion,
//                                                 @"ciudad" : ciudad,
                                                 @"zona" : zona
                                                 };
                     bloque(respuesta, nil);
                 }
             } else {
                 NSString *msg = @"Mensaje de error";
                 NSString *code = @"400";
                 NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"error", nil];
                 NSError *miError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                 if (bloque) {
                     bloque(nil, miError);
                 }
             }
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (bloque) {
                 bloque(nil, error);
             }
         }];
}



+ (ServiciosGeoLocalizacion *)sharedServiciosGeoLicalizacion
{
    static ServiciosGeoLocalizacion *misServicios = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        misServicios = [[ServiciosGeoLocalizacion alloc]init];
    });
    
    return misServicios;
}


- (void)iniciarUbicacionGPS
{
    [self.ubicacion startUpdatingLocation];

}


/*-(CLLocationCoordinate2D) getLocation{
    CLLocationManager *locationManager = [[CLLocationManager alloc]init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    
    
    
}*/




#pragma mark - CLLocationManagerDelegate métodos
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (locations && locations.count) {
        CLLocation *punto = [locations objectAtIndex:0];
        self.ultimaUbicacion = CLLocationCoordinate2DMake(punto.coordinate.latitude, punto.coordinate.longitude);
        [self.ubicacion stopUpdatingLocation];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICACION_UBICACION_GPS object:self];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICACION_GPS_ERROR object:self];
}






@end
