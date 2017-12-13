//
//  ServiciosConnection.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 17/01/14.
//  Copyright (c) 2014 softwareworks. All rights reserved.
//

#import "ServiciosConnection.h"

@implementation ServiciosConnection

@synthesize crearConexion;
@synthesize agregarFotoConexion;
@synthesize creacionBloque;
@synthesize agregadaFotoBloque;
@synthesize crearData;
@synthesize agregarFotoData;
@synthesize crearRequest;
@synthesize agregarFotoRequest;


- (void)iniciarCrearElefante:(NSDictionary *)elefante conBloque:(crearBloque)bloque
{
    self.creacionBloque = bloque;
    
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioCrearElefante];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:elefante options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!error) {
        self.crearRequest = [[NSMutableURLRequest alloc] init];
        self.crearRequest.URL = [NSURL URLWithString:urlService];
        self.crearRequest.HTTPMethod = @"POST";
        [self.crearRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.crearRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.crearRequest setValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
        [self.crearRequest setHTTPBody: data];

        self.crearData = [[NSMutableData alloc] init];
        
        self.crearConexion = [[NSURLConnection alloc] initWithRequest:self.crearRequest delegate:self];
        [self.crearConexion start];
    }
}

- (void)iniciarAgregarFotoElefante:(NSDictionary *)elefante conBloque:(agregarFotoBloque)bloque
{
    self.agregadaFotoBloque = bloque;
    
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioAgregarFoto];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:elefante options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!error) {
        self.agregarFotoRequest = [[NSMutableURLRequest alloc] init];
        self.agregarFotoRequest.URL = [NSURL URLWithString:urlService];
        self.agregarFotoRequest.HTTPMethod = @"POST";
        [self.agregarFotoRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.agregarFotoRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.agregarFotoRequest setValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
        [self.agregarFotoRequest setHTTPBody: data];
        
        self.agregarFotoData = [[NSMutableData alloc] init];
        
        self.agregarFotoConexion = [[NSURLConnection alloc] initWithRequest:self.agregarFotoRequest delegate:self];
        [self.agregarFotoConexion start];
    }
}


- (void)iniciarEditarElefante:(NSDictionary *)elefante conIdElefante:(long long)idElefante conBloque:(agregarFotoBloque)bloque
{
    self.editarBloque = bloque;
    
    NSString *serverUrl = [Definiciones sharedUrlServidor];
    NSString *service = [Definiciones sharedServicioModificarElefante];
    service = [NSString stringWithFormat:service, idElefante];
    NSString *urlService = [NSString stringWithFormat:@"%@/%@", serverUrl, service];
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:elefante options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!error) {
        self.editarRequest = [[NSMutableURLRequest alloc] init];
        self.editarRequest.URL = [NSURL URLWithString:urlService];
        self.editarRequest.HTTPMethod = @"PUT";
        [self.editarRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.editarRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.editarRequest setValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
        [self.editarRequest setHTTPBody: data];
        
        self.editarData = [[NSMutableData alloc] init];
        
        self.editarConexion = [[NSURLConnection alloc] initWithRequest:self.editarRequest delegate:self];
        [self.editarConexion start];
    }
}



- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if (connection == self.crearConexion) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"Error", NSLocalizedDescriptionKey, @"401", @"ebm-error", nil];
        NSError *error = [[NSError alloc] initWithDomain:@"Elefantes-Blancos" code:401 userInfo:userInfo];
        self.creacionBloque(nil, error);
    } else if (connection == self.agregarFotoConexion) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"Error", NSLocalizedDescriptionKey, @"401", @"ebm-error", nil];
        NSError *error = [[NSError alloc] initWithDomain:@"Elefantes-Blancos" code:401 userInfo:userInfo];
        self.agregadaFotoBloque(NO, error);
    } else if (connection == self.editarConexion) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"Error", NSLocalizedDescriptionKey, @"401", @"ebm-error", nil];
        NSError *error = [[NSError alloc] initWithDomain:@"Elefantes-Blancos" code:401 userInfo:userInfo];
        self.editarBloque(NO, error);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (connection == self.crearConexion) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"Error", NSLocalizedDescriptionKey, @"500", @"ebm-error", nil];
        NSError *error = [[NSError alloc] initWithDomain:@"Elefantes-Blancos" code:500 userInfo:userInfo];
        self.creacionBloque(nil, error);
    } else if (connection == self.agregarFotoConexion) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"Error", NSLocalizedDescriptionKey, @"500", @"ebm-error", nil];
        NSError *error = [[NSError alloc] initWithDomain:@"Elefantes-Blancos" code:500 userInfo:userInfo];
        self.agregadaFotoBloque(NO, error);
    } else if (connection == self.editarConexion) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"Error", NSLocalizedDescriptionKey, @"500", @"ebm-error", nil];
        NSError *error = [[NSError alloc] initWithDomain:@"Elefantes-Blancos" code:500 userInfo:userInfo];
        self.editarBloque(NO, error);
    }
}


- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    // Digest auth
    NSURLCredential *defaultCredential = [NSURLCredential credentialWithUser:@"elefantes" password:@"eb_moviles" persistence:NSURLCredentialPersistenceForSession];
    
    [[challenge sender] useCredential:defaultCredential forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == self.crearConexion) {
        [self.crearData appendData:data];
    } else if (connection == self.agregarFotoConexion) {
        [self.agregarFotoData appendData:data];
    } else if (connection == self.editarConexion) {
        [self.editarData appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == self.crearConexion) {
        NSString *str = [[NSString alloc] initWithData:self.crearData encoding:NSUTF8StringEncoding];
        
        NSLog(@"crear Data recibido: %@", str);
        
        NSError *error = nil;
        NSDictionary *elefanteResp = [NSJSONSerialization JSONObjectWithData:self.crearData options:NSJSONReadingAllowFragments error:&error];
        if (!error) {
            self.creacionBloque(elefanteResp, nil);
        } else {
            self.creacionBloque(nil, error);
        }
    } else if (connection == self.agregarFotoConexion) {
        self.agregadaFotoBloque(YES, nil);
    } else if (connection == self.editarConexion) {
        self.editarBloque(YES, nil);
    }
}




@end
