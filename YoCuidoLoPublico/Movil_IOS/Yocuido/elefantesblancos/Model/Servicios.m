//
//  Servicios.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 4/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "Servicios.h"

@implementation Servicios


+ (void)consultarCantidadElefantesPorRegionesConBloque:(void (^)(NSArray *regionesArray, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioElefantesPorRegion];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"eb_moviles"];
    
    [manager GET:urlService
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray *jsonResponse = (NSArray *)responseObject;

              // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
              if (bloque && jsonResponse) {
                  bloque(jsonResponse, nil);
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



+ (void)consultarDepartamentosPorRegion:(int)region conBloque:(void (^)(NSArray *deptosArray, NSError *error))bloque
{
//    // DEBUG
//    region = 2;
    // TODO: Borrar cuando estén listos todos los servicios
    
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioDepartamentosPorRegion];
    service = [NSString stringWithFormat:service, region];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"eb_moviles"];

    [manager GET:urlService
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSArray *jsonResponse = (NSArray *)responseObject;
              
              // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
              if (bloque && jsonResponse) {
                  bloque(jsonResponse, nil);
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



+ (void)consultarMunicipiosPorDepartamento:(long)depto conBloque:(void (^)(NSArray *municipiosArray, NSError *error))bloque
{
    NSString *deptoN=[NSString stringWithFormat:@"%ld",depto];
    if([deptoN length]==1)
        deptoN=[NSString stringWithFormat:@"0%@",deptoN];

    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioMunicipiosPorDepartamento];
    service = [NSString stringWithFormat:service, deptoN];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"eb_moviles"];

    [manager GET:urlService
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray *jsonResponse = (NSArray *)responseObject;
              // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
              if (bloque && jsonResponse) {
                  bloque(jsonResponse, nil);
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


+ (void)consultarElefantesPorMunicipio:(long)municipio conBloque:(void (^)(NSArray *elefantesArray, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioMunicipiosPorDepartamento];
    service = [NSString stringWithFormat:service, municipio];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"eb_moviles"];

    [manager POST:urlService
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray *jsonResponse = (NSArray *)responseObject;
              
              // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
              if (bloque && jsonResponse) {
                  bloque(jsonResponse, nil);
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


+ (void)consultarElefantesPorCodigoMunicipio:(NSString *)municipio conBloque:(void (^)(NSArray *elefantesArray, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioConsultaElefantesPorDeptoYMUnicipio];
    service = [NSString stringWithFormat:service, municipio];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"eb_moviles"];
    
    [manager GET:urlService
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray *jsonResponse = (NSArray *)responseObject;
              // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
              if (bloque && jsonResponse) {
                  bloque(jsonResponse, nil);
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



+ (void)consultarElefantesPorLatitud:(CGFloat)latitud yLongitud:(CGFloat)longitud conBloque:(void (^)(NSArray *elefantesArray, NSError *error))bloque
{
    
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioElefantesPorPosicion];
    service = [NSString stringWithFormat:service, latitud, longitud];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"eb_moviles"];
    
    [manager GET:urlService
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray *jsonResponse = (NSArray *)responseObject;
              
              // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
              if (bloque && jsonResponse) {
                  bloque(jsonResponse, nil);
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


+ (void)consultarDetalleElefantes:(long long)elefante conBloque:(void (^)(NSDictionary  *elefanteDiccionario, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioDetalleElefante];
    service = [NSString stringWithFormat:service, elefante];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"eb_moviles"];
    
    [manager GET:urlService
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = (NSDictionary *)responseObject;
              
              // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
              if (bloque && jsonResponse) {
                  bloque(jsonResponse, nil);
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


+ (void)consultarElefantesMasVotadosConBloque:(void (^)(NSArray *elefantesArray, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioMasVotados];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"eb_moviles"];
    
    [manager GET:urlService
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray *jsonResponse = (NSArray *)responseObject;
              
              // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
              if (bloque && jsonResponse) {
                  bloque(jsonResponse, nil);
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


+ (void)crearElefanteConDiccionario:(NSDictionary *)elefante conBloque:(void (^)(NSDictionary *elefanteDic, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioCrearElefante];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlService parameters:elefante];
    
    // Digest auth
    NSURLCredential *defaultCredential = [NSURLCredential credentialWithUser:@"elefantes" password:@"eb_moviles" persistence:NSURLCredentialPersistenceForSession];
    
    NSURL *feedsURL = [NSURL URLWithString:urlService];
    NSString *host = [feedsURL host];
    NSInteger port = [[feedsURL port] integerValue];
    NSString *protocol = [feedsURL scheme];
    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:host port:port protocol:protocol realm:@"servicios" authenticationMethod:NSURLAuthenticationMethodHTTPDigest];
    
    NSURLCredentialStorage *credentials = [NSURLCredentialStorage sharedCredentialStorage];
    [credentials setDefaultCredential:defaultCredential forProtectionSpace:protectionSpace];
    
    NSURLSessionConfiguration *configuracion = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = nil;
    if (configuracion) {
        [configuracion setURLCredentialStorage:credentials];
        
        configuracion.timeoutIntervalForRequest = 60;
        manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuracion];
        NSURLSessionDataTask *tarea = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                if (bloque) {
                    bloque(nil, error);
                }
            } else if (responseObject) {
                NSDictionary *jsonResponse = (NSDictionary *)responseObject;
                
                // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
                if (bloque && jsonResponse) {
                    bloque(jsonResponse, nil);
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
        }];
        
        [tarea resume];
    }
}



+ (void)agregarFotoAElefante:(NSDictionary *)elefante conBloque:(void (^)(BOOL agregado, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioAgregarFoto];
    long long idElefante = [[elefante objectForKey:@"idElefante"] longLongValue];
//    service = [NSString stringWithFormat:service, idElefante];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlService parameters:elefante];
    
    // Digest auth
    NSURLCredential *defaultCredential = [NSURLCredential credentialWithUser:@"elefantes" password:@"eb_moviles" persistence:NSURLCredentialPersistenceForSession];
    
    NSURL *feedsURL = [NSURL URLWithString:urlService];
    NSString *host = [feedsURL host];
    NSInteger port = [[feedsURL port] integerValue];
    NSString *protocol = [feedsURL scheme];
    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:host port:port protocol:protocol realm:@"servicios" authenticationMethod:NSURLAuthenticationMethodHTTPDigest];
    
    NSURLCredentialStorage *credentials = [NSURLCredentialStorage sharedCredentialStorage];
    [credentials setDefaultCredential:defaultCredential forProtectionSpace:protectionSpace];
    
    NSURLSessionConfiguration *configuracion = [NSURLSessionConfiguration defaultSessionConfiguration];
    [configuracion setURLCredentialStorage:credentials];
    
    configuracion.timeoutIntervalForRequest = 60;
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuracion];
    
    NSURLSessionDataTask *tarea = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            if (bloque) {
                bloque(NO, error);
            }
        } else {
            // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
            if (bloque) {
                bloque(YES, nil);
            } else {
                NSString *msg = @"Mensaje de error";
                NSString *code = @"400";
                NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"error", nil];
                NSError *miError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                if (bloque) {
                    bloque(NO, miError);
                }
            }
        }
    }];
    
    [tarea resume];
    
}



+ (void)votarRechazoAElefante:(long long)elefante conBloque:(void (^)(int nuevosVotos, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioVotoRechazo];
    service = [NSString stringWithFormat:service, elefante];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"eb_moviles"];
    
    [manager GET:urlService
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
             NSDictionary *votos = (NSDictionary *)responseObject;
             int votosQty = [[votos objectForKey:@"cantidadVotos"] intValue];
             if (bloque) {
                 bloque(votosQty, nil);
             } else {
                 NSString *msg = @"Mensaje de error";
                 NSString *code = @"400";
                 NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"error", nil];
                 NSError *miError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                 if (bloque) {
                     bloque(0, miError);
                 }
             }
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (bloque) {
                 bloque(0, error);
             }
         }];
}




+ (void)consultarMiElefante:(long long)idElefante conBloque:(void (^)(NSDictionary *elefante, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioConsultarMiElefante];
    service = [NSString stringWithFormat:service, idElefante];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"eb_moviles"];
    
    [manager GET:urlService
      parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = (NSDictionary *)responseObject;
              
              // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
              if (bloque && jsonResponse) {
                  bloque(jsonResponse, nil);
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


+ (void)obtenerImagenGrande:(long long)idGrande conBloque:(void (^)(NSString  *imagenBase64, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioConsultarImagenGrande];
    service = [NSString stringWithFormat:service, idGrande];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"eb_moviles"];
    
    [manager GET:urlService
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *jsonResponse = (NSDictionary *)responseObject;
             
             // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
             if (bloque && jsonResponse) {
                 NSString *base64 = [jsonResponse objectForKey:@"imagen"];
                 bloque(base64, nil);
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



+ (void)modificarMiElefante:(NSDictionary *)elefante conIdElefante:(long long)idElefante conBloque:(void (^)(BOOL modificado, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioModificarElefante];
    service = [NSString stringWithFormat:service, idElefante];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"PUT" URLString:urlService parameters:elefante];
    
    // Digest auth
    NSURLCredential *defaultCredential = [NSURLCredential credentialWithUser:@"elefantes" password:@"eb_moviles" persistence:NSURLCredentialPersistenceForSession];
    
    NSURL *feedsURL = [NSURL URLWithString:urlService];
    NSString *host = [feedsURL host];
    NSInteger port = [[feedsURL port] integerValue];
    NSString *protocol = [feedsURL scheme];
    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:host port:port protocol:protocol realm:@"servicios" authenticationMethod:NSURLAuthenticationMethodHTTPDigest];
    
    NSURLCredentialStorage *credentials = [NSURLCredentialStorage sharedCredentialStorage];
    [credentials setDefaultCredential:defaultCredential forProtectionSpace:protectionSpace];
    
    NSURLSessionConfiguration *configuracion = [NSURLSessionConfiguration defaultSessionConfiguration];
    [configuracion setURLCredentialStorage:credentials];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuracion];
    
    NSURLSessionDataTask *tarea = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            if (bloque) {
                bloque(NO, error);
            }
        } else {
            // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
            if (bloque) {
                bloque(YES, nil);
            } else {
                NSString *msg = @"Mensaje de error";
                NSString *code = @"400";
                NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"error", nil];
                NSError *miError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                if (bloque) {
                    bloque(NO, miError);
                }
            }
        }
    }];
    
    [tarea resume];
    
}



+ (void)consultarRazonesDeElefantesConBloque:(void (^)(NSArray  *razonesArray, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioRazonesElefantes];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"eb_moviles"];
    
    [manager GET:urlService
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *jsonResponse = (NSArray *)responseObject;
             
             // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
             if (bloque && jsonResponse) {
                 bloque(jsonResponse, nil);
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



+ (void)consultarRangosDeTiempoConBloque:(void (^)(NSArray  *rangosArray, NSError *error))bloque
{
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioRangosTiempo];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager managerWithDigestUser:@"elefantes" password:@"eb_moviles"];
    
    [manager GET:urlService
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *jsonResponse = (NSArray *)responseObject;
             
             // Si todo va bien, revisar la respuesta JSon para ver si fue exitosa o no
             if (bloque && jsonResponse) {
                 bloque(jsonResponse, nil);
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



@end
