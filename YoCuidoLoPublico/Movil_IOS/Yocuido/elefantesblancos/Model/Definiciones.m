//
//  Definiciones.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 25/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "Definiciones.h"

@implementation Definiciones



+ (BOOL)validarCorreoElectronico:(NSString *)candidato
{
    NSString *correoRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *correoPrueba = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", correoRegex];
    
    return [correoPrueba evaluateWithObject:candidato];
}


+ (BOOL)validarCadenaNumerica:(NSString *)candidato
{
    NSCharacterSet* noNumericos = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [candidato rangeOfCharacterFromSet: noNumericos];
    return r.location == NSNotFound;
}


+ (BOOL)validarCadenaCaracteresValidos:(NSString *)candidato
{
    NSCharacterSet* caracteresEspeciales = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZáéíóúÁÉÍÓÚüÜ0123456789 -."] invertedSet];
    NSRange r = [candidato rangeOfCharacterFromSet: caracteresEspeciales];
    return r.location == NSNotFound;
}


+ (BOOL)validarCadenaCaracteres:(NSString *)candidato contraRegEx:(NSString *)regex
{
    NSPredicate *correoPrueba = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [correoPrueba evaluateWithObject:candidato];
}



+ (NSString *)sharedImagenAncho
{
    static NSString *miAnchoShared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miAnchoShared = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESImagenAncho"];
    });
    
    return miAnchoShared;
}

+ (NSString *)sharedImagenAlto
{
    static NSString *miAltoShared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miAltoShared = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESImagenAlto"];
    });
    
    return miAltoShared;
}

+ (NSString *)sharedUrlServidor
{
    static NSString *miUrlServidor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miUrlServidor = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESUrlServidor"];
    });
    
    return miUrlServidor;
}


+ (NSString *)sharedAPIKeyGoogleMaps
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESGoogleMapsAPIKey"];
    });
    
    return miApiKey;
}


+ (NSString *)sharedServicioElefantesPorRegion
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioElefantesPorRegion"];
    });
    
    return miApiKey;
}


+ (NSString *)sharedServicioDepartamentosPorRegion
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioDepartamentosPorRegion"];
    });
    
    return miApiKey;
}


+ (NSString *)sharedServicioMunicipiosPorDepartamento
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioMunicipiosPorDepartamento"];
    });
    
    return miApiKey;
}


+ (NSString *)sharedServicioElefantesPorPosicion
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioElefantesPorPosicion"];
    });
    
    return miApiKey;
}


+ (NSString *)sharedServicioDetalleElefante
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioDetalleElefante"];
    });
    
    return miApiKey;
}


+ (NSString *)sharedServicioMasVotados
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioMasVotados"];
    });
    
    return miApiKey;
}


+ (NSString *)sharedServicioCrearElefante
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioCrearElefante"];
    });
    
    return miApiKey;
}



+ (NSString *)sharedServicioConsultaElefantesPorDeptoYMUnicipio
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioConsultaElefantesPorDeptoYMUnicipio"];
    });
    
    return miApiKey;
}


+ (NSString *)sharedServicioAgregarFoto
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioAgregarFoto"];
    });
    
    return miApiKey;
}


+ (NSString *)sharedServicioVotoRechazo
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioVotoRechazo"];
    });
    
    return miApiKey;
}




+ (NSString *)sharedServicioRazonesElefantes
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioConsultarMotivos"];
    });
    
    return miApiKey;
}


+ (NSString *)sharedServicioRangosTiempo
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioConsultarRangosTiempo"];
    });
    
    return miApiKey;
}



+ (NSString *)sharedServicioConsultarMiElefante
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioConsultarMiElefante"];
    });
    
    return miApiKey;
}



+ (NSString *)sharedServicioConsultarImagenGrande
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioConsultarImagenGrande"];
    });
    
    return miApiKey;
}



+ (NSString *)sharedServicioModificarElefante
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESServicioModificarElefante"];
    });
    
    return miApiKey;
}





+ (NSString *)sharedGeoUrlServidor
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESGEOUrlServidor"];
    });
    
    return miApiKey;
}


+ (NSString *)sharedGeoServicioGeoReferencia
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESGEOServicioGeoReferencia"];
    });
    
    return miApiKey;
}


+ (NSString *)sharedGeoServicioGeoInverso
{
    static NSString *miApiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miApiKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRESGEOServicioGeoInverso"];
    });
    
    return miApiKey;
}




+ (NSString*)base64DeData:(NSData*)data
{
    NSString *resultado = [data base64EncodedStringWithSeparateLines:NO];
    
    NSString *ruta = [NSString stringWithFormat:@"%@/imgStrBase64.txt", RUTA_CACHE];
    NSError *error = nil;
    BOOL archivoEnCache = [resultado writeToFile:ruta atomically:YES encoding:NSASCIIStringEncoding error:&error];
    
    if (archivoEnCache) {
        NSLog(@"Archivo temporal de base64: %@", ruta);
    }
    
    error = nil;
    NSString *resultado2 = [NSString stringWithContentsOfFile:ruta encoding:NSUTF8StringEncoding error:&error];
    
    if (resultado2) {
        return resultado2;
    } else {
        return resultado;
    }
}



+ (UIImage *)imagenDesdeImagen:(UIImage *)imagen conNuevoTamano:(CGSize)nuevoTamano
{
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(nuevoTamano, NO, 0.0);
    [imagen drawInRect:CGRectMake(0, 0, nuevoTamano.width, nuevoTamano.height)];
    UIImage *resultado = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultado;
}



@end
