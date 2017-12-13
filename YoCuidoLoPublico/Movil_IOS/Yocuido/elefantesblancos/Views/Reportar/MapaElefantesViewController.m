//
//  MapaElefantesViewController.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 28/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "MapaElefantesViewController.h"

#import "Servicios.h"
#import "ServiciosGeoLocalizacion.h"
#import "TomarFotoViewController.h"

#import "CargandoView.h"
#import "DetalleElefanteBlancoViewController.h"
#import "EditarMiElefanteViewController.h"
#import "LectorLocalJson.h"

#import "CrearElefanteViewController.h"

@interface MapaElefantesViewController ()

@property(assign) CGFloat contenedorY;
@property(assign) BOOL mostrarBotonReportar;
@property(strong) NSDictionary *miMunicipio;

@property(strong) CargandoView *cargando;
@property(strong) AlertaMensajeView *alerta;

@property(strong) NSMutableArray *elefantesBlancos;
@property(strong) NSMutableArray *elefantesMarkers;

@property(strong) GMSCameraPosition *camara;

@property(assign) CGFloat latitud;
@property(assign) CGFloat longitud;
@property(assign) CGFloat latitudMunicipio;
@property(assign) CGFloat longitudMunicipio;
@property(assign) BOOL esParaUbicacionPersonal;

@property(strong) UIImage *elefanteAprobadoImage;
@property(strong) UIImage *elefantePendienteImage;
@property(strong) UIImage *elefanteRechazadoImage;
@property(strong) UIImage *elefanteEdificioImage;

@property(strong) UIImage *posicionImage;

@property(strong) NSDictionary *elefanteSeleccionado;

@property(strong) GMSMarker *miPosicionMarker;

@property(assign) CLLocationCoordinate2D posicionCamaraAnterior;

@end

@implementation MapaElefantesViewController

@synthesize contenedorTotal;
@synthesize mapaContendor;
@synthesize atrasButton;
@synthesize ubicarmeButton;
@synthesize reportarButton;
@synthesize mapaGoogle;

@synthesize burbujaContenedor;
@synthesize burbujaImage;
@synthesize detalleElefanteButton;
@synthesize burbujaTituloLabel;

@synthesize contenedorY;
@synthesize cargando;
@synthesize mostrarBotonReportar;
@synthesize miMunicipio;
@synthesize elefantesBlancos;
@synthesize elefantesMarkers;
@synthesize camara;
@synthesize latitud;
@synthesize longitud;
@synthesize esParaUbicacionPersonal;
@synthesize elefanteAprobadoImage;
@synthesize elefantePendienteImage;
@synthesize elefanteRechazadoImage;
@synthesize elefanteEdificioImage;
@synthesize alerta;
@synthesize miPosicionMarker;
@synthesize posicionCamaraAnterior;


- (id)initMapaElefantesViewControllerConElefantes:(NSArray *)nuevosElefantes municipioLatitud:(CGFloat)municipioLatitud municipioLongitud:(CGFloat)municipioLongitud
{
    NSString *nibName = @"";

    // Custom initialization
    if (ES_IPAD) {
        nibName = @"MapaElefantesViewController";
    } else {
        nibName = @"MapaElefantesViewController";
    }

    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {

        if (ES_IPAD) {
            self.contenedorY = 20;
        } else {
            self.contenedorY = 20;
        }
        self.elefantesBlancos = [NSMutableArray arrayWithArray:nuevosElefantes];
        
        
        if(self.elefantesBlancos &&  self.elefantesBlancos.count){
            
            
            NSDictionary *elefante = [self.elefantesBlancos objectAtIndex:0];
            NSDictionary *posicion = [elefante objectForKey:@"posicion"];
            
            self.latitudMunicipio  = [[posicion objectForKey:@"latitud"] doubleValue];
            self.longitudMunicipio = [[posicion objectForKey:@"longitud"] doubleValue];
            
        }
        
        numeroElefantes=(int)elefantesBlancos.count;
        self.elefantesMarkers = [[NSMutableArray alloc] init];
        self.miMunicipio = nil;
        self.mostrarBotonReportar = NO;
        self.latitud = 0;
        self.longitud = 0;
        
        self.esParaUbicacionPersonal = NO;
        self.miPosicionMarker = nil;
    }
    return self;
}

- (id)initMapaElefantesViewControllerReportando
{
    NSString *nibName = @"";
    
    if (ES_IPAD) {
        nibName = @"MapaElefantesViewController";
    } else {
        nibName = @"MapaElefantesViewController";
    }
    
    if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
        self.contenedorY = 20;
    } else {
        self.contenedorY = 20;
    }
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        self.miMunicipio = nil;
        self.elefantesMarkers = [[NSMutableArray alloc] init];
        self.mostrarBotonReportar = YES;
        self.latitud = 0;
        self.longitud = 0;
        self.esParaUbicacionPersonal = YES;
        self.miPosicionMarker = nil;
    }
    return self;
}

- (id)initMapaElefantesViewControllerConsultandoLatitud:(CGFloat)nuevaLat yLongitud:(CGFloat)nuevaLon
{
    NSString *nibName = @"";
    
    if (ES_IPAD) {
        nibName = @"MapaElefantesViewController";
        self.contenedorY = 20;
    } else {
        nibName = @"MapaElefantesViewController";
        self.contenedorY = 20;
    }
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        self.latitud = nuevaLat;
        self.longitud = nuevaLon;
        self.elefantesMarkers = [[NSMutableArray alloc] init];
        self.mostrarBotonReportar = YES;
        self.miMunicipio = nil;
        self.esParaUbicacionPersonal = YES;
        self.miPosicionMarker = nil;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
        self.contenedorTotal.frame = CGRectMake(0, self.contenedorY, self.contenedorTotal.frame.size.width, self.contenedorTotal.frame.size.height);
    }
    
    self.elefanteAprobadoImage = [UIImage imageNamed:@"icono_ubicacion_elefante.png"];
    self.elefantePendienteImage = [UIImage imageNamed:@"icono_ubicacion_elefante_pendiente.png"];
    self.elefanteRechazadoImage = [UIImage imageNamed:@"icono_ubicacion_elefante_pendiente.png"];
    self.elefanteEdificioImage = [UIImage imageNamed:@"icono_edificio.png"];
    
    self.posicionImage = [UIImage imageNamed:@"icono_posicion.png"];
    
    // Vista de Cargando
    self.cargando = [CargandoView initCargandoView];
    [self.view addSubview:self.cargando];
    [self.cargando ocultarSinAnimacion];

    // Alerta y Mensajes
    self.alerta = [AlertaMensajeView initAlertaMensajeViewConDelegado:self];
    [self.view addSubview:self.alerta];
    self.alerta.hidden = YES;
    [self.view sendSubviewToBack:self.alerta];


    CGFloat zoom = 17;
    AGREGAR_OBSERVADOR_UBICACION(self, @selector(recibirUbicacionGPS));
    AGREGAR_OBSERVADOR_ERROR_UBICACION(self, @selector(recibirErrorGPS));
    CGFloat latInicial = 0;
    CGFloat lonInicial = 0;
    if (self.esParaUbicacionPersonal) {
        [[ServiciosGeoLocalizacion sharedServiciosGeoLicalizacion] iniciarUbicacionGPS];
        zoom = 17;
        /*latInicial = BOGOTA_CENTRO_LAT;
        lonInicial = BOGOTA_CENTRO_LON;*/
        
      
        
    } else {
        zoom = 12;
        self.latitud = self.latitudMunicipio;
        self.longitud = self.longitudMunicipio;
    }
    
    
   /* self.latitud = latInicial;
    self.longitud = lonInicial;*/
    self.reportarButton.hidden = !self.esParaUbicacionPersonal;
    
    CGRect mapaFrame = CGRectMake(0, 0, self.mapaContendor.frame.size.width, self.mapaContendor.frame.size.height);
   self.camara = [GMSCameraPosition cameraWithLatitude:self.latitud longitude:self.longitud zoom:zoom];
    self.mapaGoogle = [GMSMapView mapWithFrame:mapaFrame camera:self.camara];
    self.mapaGoogle.mapType = kGMSTypeNormal;
    self.mapaGoogle.delegate = self;
    [self.mapaContendor addSubview:self.mapaGoogle];

    
    
    if (self.elefantesBlancos && self.elefantesBlancos.count) {
         [self poblarMapaConElefantes:self.elefantesBlancos];
        
    } else if (self.latitud && self.longitud ) {
    //} else  {
        [Servicios consultarElefantesPorLatitud:self.latitud yLongitud:self.longitud conBloque:^(NSArray *elefantesArray, NSError *error) {
            if (error) {
                if (error.code >= 500) {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
                } else {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
                }
            } else if (elefantesArray && elefantesArray.count) {
                self.elefantesBlancos = [[NSMutableArray alloc] init];
                for (NSDictionary *elefante in elefantesArray) {
                    int estado = [[elefante objectForKey:@"estado"] intValue];
                    if (estado == ESTADO_ELEFANTE_APROBADO) {
                        [self.elefantesBlancos addObject:elefante];
                    } else if (estado == ESTADO_ELEFANTE_APROBADO) {
                        int idElefante = [[elefante objectForKey:@"id"] intValue];
                        NSString *idsGuardados = GET_USERDEFAULTS(USUARIO_MIS_ELEFANTES);
                        NSArray *comps = [idsGuardados componentsSeparatedByString:@"|"];
                        for (int i = 0; i < comps.count; i++) {
                            NSString *comp = [comps objectAtIndex:i];
                            int idMio = [comp intValue];
                            if (idElefante == idMio) {
                                [self.elefantesBlancos addObject:elefante];
                                break;
                            }
                        }
                    }
                }
                [self poblarMapaConElefantes:self.elefantesBlancos];
            }
        }];
        
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)irAtras:(id)sender
{
    REMOVER_OBERVADOR_UBICACION(self);
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)irAUbicarme:(id)sender
{
    [[ServiciosGeoLocalizacion sharedServiciosGeoLicalizacion] iniciarUbicacionGPS];
    //self.recibirUbicacionGPS;
    
    /* AGREGAR_OBSERVADOR_UBICACION(self, @selector(recibirUbicacionGPS));
   
    
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker = [GMSMarker markerWithPosition:GL_POSITION]
    marker.draggable = NO;
    marker.groundAnchor = CGPointMake(0.5, 1);
    marker.infoWindowAnchor = CGPointMake(0.5, 0);
    marker.tappable = YES;
    //        marker.title = [elefante objectForKey:@"titulo"];
    marker.position = CLLocationCoordinate2DMake(self.latitud, self.longitud);
    marker.icon = self.elefanteAprobadoImage;
    

    
    //marker.userData = elefante;
    marker.map = self.mapaGoogle;
    [self.elefantesMarkers addObject:marker];*/
    
    
}

- (IBAction)irAReportar:(id)sender
{
    if (self.latitud == 0 && self.longitud == 0) {
        self.alerta.bandera = 1;
        [self.alerta mostrarMensajeConLetrero:@"Para generar el reporte se debe activar el GPS del dispositivo" textoBoton:@"Continuar"];
    } else {
        TomarFotoViewController *tomarFotoVC = [[TomarFotoViewController alloc] initTomarFotoViewControllerParaCrearElefante];
        [self.navigationController pushViewController:tomarFotoVC animated:YES];
        
    }
}



- (void)poblarMapaConElefantes:(NSArray *)elefantesArray
{
    for (GMSMarker *marker in self.elefantesMarkers) {
        marker.map = nil;
    }
    [self.elefantesMarkers removeAllObjects];
    
    for (int i = 0; i < elefantesArray.count; i++) {
        NSDictionary *elefante = [elefantesArray objectAtIndex:i];
        NSDictionary *posicion = [elefante objectForKey:@"posicion"];
        
        self.latitud = [[posicion objectForKey:@"latitud"] doubleValue];
        self.longitud  = [[posicion objectForKey:@"longitud"] doubleValue];
        
        CLLocationDegrees lat = [[posicion objectForKey:@"latitud"] doubleValue];
        CLLocationDegrees lon = [[posicion objectForKey:@"longitud"] doubleValue];
        int estado = [[elefante objectForKey:@"idEstado"] intValue];
        if (!estado) {
            estado = [[elefante objectForKey:@"estado"] intValue];
        }
        int noEsElefante = [[elefante objectForKey:@"noEsUnElefante"] intValue];
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.draggable = NO;
        marker.groundAnchor = CGPointMake(0.5, 1);
        marker.infoWindowAnchor = CGPointMake(0.5, 0);
        marker.tappable = YES;
//        marker.title = [elefante objectForKey:@"titulo"];
        marker.position = CLLocationCoordinate2DMake(lat, lon);
        if (estado == ESTADO_ELEFANTE_APROBADO) {
            marker.icon = self.elefanteAprobadoImage;
        } else if (estado == ESTADO_ELEFANTE_PENDIENTE) {
            marker.icon = self.elefantePendienteImage;
        } else if (estado == ESTADO_ELEFANTE_NO_APROBADO) {
            marker.icon = self.elefantePendienteImage;
        } else {
            marker.icon = self.elefantePendienteImage;
        }
        
        if (noEsElefante) {
            marker.icon = self.elefanteEdificioImage;
        }
        
        marker.userData = elefante;
        marker.map = self.mapaGoogle;
        
        [self.elefantesMarkers addObject:marker];
    }
    
    if (!self.miPosicionMarker) {
        self.miPosicionMarker = [[GMSMarker alloc] init];
        self.miPosicionMarker.draggable = NO;
        self.miPosicionMarker.groundAnchor = CGPointMake(0.5, 0.5);
        self.miPosicionMarker.infoWindowAnchor = CGPointMake(0.5, 0.5);
        self.miPosicionMarker.tappable = NO;
        //        marker.title = [elefante objectForKey:@"titulo"];
        self.miPosicionMarker.position = CLLocationCoordinate2DMake(self.latitud, self.longitud);
        self.miPosicionMarker.icon = self.posicionImage;
        self.miPosicionMarker.map = self.mapaGoogle;
        
        
        
    } else {
        self.miPosicionMarker.map = self.mapaGoogle;
    }
}


#pragma mark - ServiciosGeoLocalizacion métodos
- (void)recibirUbicacionGPS
{
    CLLocationCoordinate2D punto2D = [ServiciosGeoLocalizacion sharedServiciosGeoLicalizacion].ultimaUbicacion;
    self.latitud = punto2D.latitude;
    self.longitud = punto2D.longitude;

    if (!self.miPosicionMarker) {
        self.miPosicionMarker = [[GMSMarker alloc] init];
        self.miPosicionMarker.draggable = NO;
        self.miPosicionMarker.groundAnchor = CGPointMake(0.5, 0.5);
        self.miPosicionMarker.infoWindowAnchor = CGPointMake(0.5, 0.5);
        self.miPosicionMarker.tappable = NO;
        //        marker.title = [elefante objectForKey:@"titulo"];
        self.miPosicionMarker.position = CLLocationCoordinate2DMake(self.latitud, self.longitud);
        self.miPosicionMarker.icon = self.posicionImage;
        self.miPosicionMarker.map = self.mapaGoogle;
    } else {
        self.miPosicionMarker.map = self.mapaGoogle;
        self.miPosicionMarker.position = CLLocationCoordinate2DMake(self.latitud, self.longitud);
    }
    
    if (self.esParaUbicacionPersonal) {
        [self.mapaGoogle animateToLocation:punto2D];
        self.posicionCamaraAnterior = punto2D;
        [self obtenerElefantesPorUbicacion:punto2D];
    }

}


- (void)recibirErrorGPS
{
    self.alerta.bandera = 1;
    [self.alerta mostrarMensajeConLetrero:@"Para generar el reporte se debe activar el GPS del dispositivo" textoBoton:@"Continuar"];
}



- (void)obtenerElefantesPorUbicacion:(CLLocationCoordinate2D)ubicacion
{
    
    [Servicios consultarElefantesPorLatitud:ubicacion.latitude yLongitud:ubicacion.longitude conBloque:^(NSArray *elefantesArray, NSError *error) {
        
        if (error) {
            self.alerta.bandera = 0;
//            [self.alerta mostrarMensajeConLetrero:@"Revise su conexión a internet e intente nuevamente"];
        } else if (elefantesArray && elefantesArray.count) {
            
            //NSLog(@"Elefantes Obtenidos en bruto: %d", elefantesArray.count);
            
            self.elefantesBlancos = [[NSMutableArray alloc] init];
            for (NSDictionary *elefante in elefantesArray) {
                int estado = [[elefante objectForKey:@"idEstado"] intValue];
                if (estado == ESTADO_ELEFANTE_APROBADO) {
                    [self.elefantesBlancos addObject:elefante];
                } else if (estado == ESTADO_ELEFANTE_PENDIENTE) {
                    int idElefante = [[elefante objectForKey:@"id"] intValue];
                    NSString *idsGuardados = GET_USERDEFAULTS(USUARIO_MIS_ELEFANTES);
                    NSArray *comps = [idsGuardados componentsSeparatedByString:@"|"];
                    for (int i = 0; i < comps.count; i++) {
                        NSString *comp = [comps objectAtIndex:i];
                        int idMio = [comp intValue];
                        if (idElefante == idMio) {
                            [self.elefantesBlancos addObject:elefante];
                            break;
                        }
                    }
                }
            }
            
            //NSLog(@"Elefantes Obtenidos a mostrar: %d", self.elefantesBlancos.count);
            
            [self poblarMapaConElefantes:self.elefantesBlancos];
        }
    }];
    [ServiciosGeoLocalizacion obtenerDireccionParaCoordenadas:ubicacion conBloque:^(NSDictionary *ubicacionRespuesta, NSError *error) {
        if (error) {
            self.alerta.bandera = 0;
//            [self.alerta mostrarMensajeConLetrero:@"Revise su conexión a internet e intente nuevamente"];
        } else if (ubicacionRespuesta) {
            int codigoMunicipio = [[ubicacionRespuesta objectForKey:@"codigo_municipio"] intValue];
            int codigoDepartamento = [[ubicacionRespuesta objectForKey:@"codigo_departamento"] intValue];
            NSArray *deptos = [LectorLocalJson obtenerElementosJsonDeArchivo:@"departamentos"];
            NSArray *munics = [LectorLocalJson obtenerElementosJsonDeArchivo:@"municipios"];
            NSString *deptoStr = @"";
            for (NSDictionary *item in deptos) {
                int iDp = [[item objectForKey:@"codigo"] intValue];
                if (iDp == codigoDepartamento) {
                    deptoStr = [item objectForKey:@"nombre"];
                    break;
                }
            }
            NSString *municStr = @"";
            for (NSDictionary *item in munics) {
                int iMn = [[item objectForKey:@"codigo"] intValue];
                if (iMn == codigoMunicipio) {
                    municStr = [item objectForKey:@"nombre"];
                    break;
                }
            }
        }
    }];

}



#pragma mark - GMSMapViewDelegate métodos
- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    NSDictionary *elefante = (NSDictionary *)marker.userData;
    self.elefanteSeleccionado = elefante;
    self.burbujaTituloLabel.text = [elefante objectForKey:@"titulo"];
    return self.burbujaContenedor;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    NSDictionary *elefante = (NSDictionary *)marker.userData;
    if (elefante) {
        long long idElefante = [[elefante objectForKey:@"id"] longLongValue];
        
        [self.cargando mostrar];
        [Servicios consultarDetalleElefantes:idElefante conBloque:^(NSDictionary *elefanteDiccionario, NSError *error) {
            [self.cargando ocultar];
            if (error) {
                if (error.code >= 500) {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
                } else {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
                }
            } else if (elefanteDiccionario) {
                int estado = [[elefanteDiccionario objectForKey:@"estado"] intValue];
                if (estado == ESTADO_ELEFANTE_PENDIENTE) {
                    EditarMiElefanteViewController *editarElefanteVC = [[EditarMiElefanteViewController alloc] initEditarMiElefanteViewControllerParaElefante:elefanteDiccionario estadoEdicion:MasInformacionEstadoDespliegueEditando esMiElefante:YES];
                    [self.navigationController pushViewController:editarElefanteVC animated:YES];
                } else {
                    DetalleElefanteBlancoViewController *detalleVC = [[DetalleElefanteBlancoViewController alloc] initDetalleElefanteBlancoViewControllerParaElefante:elefanteDiccionario estadoEdicion:MasInformacionEstadoDespliegue esMiElefante:NO];
                    detalleVC.esAgregarFoto = self.esParaUbicacionPersonal;
                    [self.navigationController pushViewController:detalleVC animated:YES];
                }
            }
        }];
    }
}

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    if (self.esParaUbicacionPersonal || 1) {
        
        CLLocationCoordinate2D punto2D = CLLocationCoordinate2DMake(position.target.latitude, position.target.longitude);
        CLLocation *punto1 = [[CLLocation alloc] initWithLatitude:punto2D.latitude longitude:punto2D.longitude];
        CLLocation *punto2 = [[CLLocation alloc] initWithLatitude:self.posicionCamaraAnterior.latitude longitude:self.posicionCamaraAnterior.longitude];
        CLLocationDistance distancia = [punto1 distanceFromLocation:punto2];
        
        if (distancia > 3000 && numeroElefantes>2) {
            [self obtenerElefantesPorUbicacion:punto2D];
        }
    }
}


#pragma mark - AlertaMensajeViewDelegate métodos
- (void)alertaMensajeViewSeleccionaTerminar:(AlertaMensajeView *)vista
{
    
}

- (void)alertaMensajeViewSeleccionaNo:(AlertaMensajeView *)vista
{
    
}

- (void)alertaMensajeViewSeleccionaSi:(AlertaMensajeView *)vista
{
}


@end
