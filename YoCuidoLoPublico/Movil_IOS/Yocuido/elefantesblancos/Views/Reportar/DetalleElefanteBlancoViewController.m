//
//  DetalleElefanteBlancoViewController.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 2/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "DetalleElefanteBlancoViewController.h"

#import "FotoDetalleView.h"
#import "Servicios.h"
#import "CargandoView.h"
#import "LectorLocalJson.h"
#import "ServiciosGeoLocalizacion.h"

#import "ListaElefantesViewController.h"


@interface DetalleElefanteBlancoViewController ()

@property(assign) CGFloat contenedorY;
@property(strong) NSDictionary *detalleElefanteBlanco;

@property(assign) MasInformacionEstado tipoEstadoMasInfo;

@property(strong) CargandoView *cargando;
@property(strong) AlertaMensajeView *alerta;

@property(assign) int fotoActual;
@property(strong) NSMutableArray *fotos;
@property(strong) NSMutableArray *fotosVistas;

@property(strong) NSDictionary *rangoTiempoElefante;
@property(strong) NSDictionary *razonElefante;

@property(assign) BOOL esElefanteMio;
@property(assign) CGFloat alturaContenidoScroller;

@property(strong) UIImage *fotoParaAgregar;

@property(assign) CLLocationCoordinate2D coordenadasUsuario;

@property(strong) ServiciosConnection *miServicioConexion;
@property(assign) agregarFotoBloque miBloqueAgregar;
@property(assign) agregarFotoBloque miBloqueEditar;

@property(strong) UIImage *iconoPendiente;
@property(strong) UIImage *iconoAprobado;
@property(strong) UIImage *iconoRechazado;

@property(strong) UIImage *manoAbajoHab;
@property(strong) UIImage *manoAbajoDes;



@property(strong) NSMutableArray *tiemposArray;


@end

@implementation DetalleElefanteBlancoViewController

@synthesize contenedorTotal;
@synthesize imagenFondo;
@synthesize atrasButton;
@synthesize barraSuperiorImage;
@synthesize superiorContenedor;
@synthesize elefanteBlancoLabel;
@synthesize nombreElefanteLabel;
@synthesize fechaElefanteLabel;
@synthesize contenidoScroller;
@synthesize fotoContenedor;
@synthesize fotoScroller;
@synthesize controlPaginacion;
@synthesize cantidadRechazosLabel;
@synthesize cantidadFotosLabel;
@synthesize rechazarContenedor;
@synthesize rechazarButton;
@synthesize rechazarLabel;
@synthesize departamentoUbicacionLabel;
@synthesize entidadTituloLabel;
@synthesize nombreEntidadLabel;
@synthesize razonTituloLabel;
@synthesize razonLabel;
@synthesize masInfoTituloLabel;
@synthesize masInfoView;
@synthesize notificacionesContenedor;
@synthesize notificacionesTituloLabel;
@synthesize notificacionesLabel;
@synthesize botonesContenedor;
@synthesize actualizarButton;
@synthesize agregarFotoContenedor;
@synthesize agregarRechazoButton;
@synthesize fotoSiButton;
@synthesize estadisticasContenedor;
@synthesize cantidadSeparadorLabel;
@synthesize masInfoContenedor;
@synthesize accionesContenedor;
@synthesize accionesImage;
@synthesize esAgregarFoto;
@synthesize estadoElefanteContenedor;
@synthesize estadoElefanteImage;
@synthesize estadoElefanteLabel;

@synthesize contenedorY;
@synthesize detalleElefanteBlanco;
@synthesize tipoEstadoMasInfo;
@synthesize fotoActual;
@synthesize fotos;
@synthesize fotosVistas;
@synthesize rangoTiempoElefante;
@synthesize razonElefante;
@synthesize esElefanteMio;
@synthesize cargando;
@synthesize alerta;
@synthesize fotoParaAgregar;
@synthesize alturaContenidoScroller;
@synthesize coordenadasUsuario;
@synthesize miServicioConexion;
@synthesize miBloqueAgregar;
@synthesize miBloqueEditar;
@synthesize iconoAprobado;
@synthesize iconoPendiente;
@synthesize iconoRechazado;
@synthesize manoAbajoHab;
@synthesize manoAbajoDes;
@synthesize razonesArray;
@synthesize tiemposArray;
@synthesize cerrarTecladoButtonsArray;



- (id)initDetalleElefanteBlancoViewControllerParaElefante:(NSDictionary *)infoElefante estadoEdicion:(MasInformacionEstado)estadoEdicion esMiElefante:(BOOL)esMio
{
    NSString *nibName = @"";
    
    if (ES_IPAD) {
        nibName = @"DetalleElefanteBlancoViewController";
    } else {
        nibName = @"DetalleElefanteBlancoViewController";
    }
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        if (ES_IPHONE_5) {
            self.contenedorY = 86;
        } else {
            self.contenedorY = 86;
        }
        
        self.detalleElefanteBlanco = infoElefante;
        self.tipoEstadoMasInfo = estadoEdicion;
        self.esElefanteMio = esMio;
        self.esAgregarFoto = NO;
        
//        int estadoElefante = [[self.detalleElefanteBlanco objectForKey:@"estado"] intValue];
//        if (estadoElefante == ESTADO_ELEFANTE_APROBADO) {   // Estado Aprobado
//            self.tipoEstadoMasInfo = MasInformacionEstadoDespliegue;
//        } else if (estadoElefante == ESTADO_ELEFANTE_PENDIENTE) {    // Estado Pendiente
//            self.tipoEstadoMasInfo = MasInformacionEstadoEdicion;
//        }
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

    if (ES_IPHONE_5) {
        self.contenedorTotal.frame = CGRectMake(0, self.contenedorY, self.contenedorTotal.frame.size.width, self.contenedorTotal.frame.size.height);
    }
    
    if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
        self.contenedorTotal.frame = CGRectMake(0, 20, self.contenedorTotal.frame.size.width, self.contenedorTotal.frame.size.height);
    } else {
        self.contenedorTotal.frame = CGRectMake(0, 0, self.contenedorTotal.frame.size.width, self.contenedorTotal.frame.size.height);
    }
    
    self.razonesPicker.dataSource = self;
    self.razonesPicker.delegate = self;
    self.tiemposPicker.dataSource = self;
    self.tiemposPicker.delegate = self;
    self.nombreElefanteText.delegate = self;
    self.entidadTituloText.delegate = self;
    self.razonElefanteText.delegate = self;
    
    
    [self llenarCampos];

    // Vista de Cargando
    self.cargando = [CargandoView initCargandoView];
    [self.view addSubview:self.cargando];
    [self.cargando ocultarSinAnimacion];
    
    // Alerta y Mensajes
    self.alerta = [AlertaMensajeView initAlertaMensajeViewConDelegado:self];
    [self.view addSubview:self.alerta];
    self.alerta.hidden = YES;
    [self.view sendSubviewToBack:self.alerta];
    
    // Matricularse para estar pendiende de la ubicación
    AGREGAR_OBSERVADOR_UBICACION(self, @selector(recibirUbicacionGPS));
    AGREGAR_OBSERVADOR_ERROR_UBICACION(self, @selector(recibirErrorGPS));
    [[ServiciosGeoLocalizacion sharedServiciosGeoLicalizacion] iniciarUbicacionGPS];
    
    self.miServicioConexion = [[ServiciosConnection alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)llenarCampos
{
    
    self.manoAbajoHab = [UIImage imageNamed:@"icono_mano_abajo.png"];
    self.manoAbajoDes = [UIImage imageNamed:@"icono_mano_abajo_des.png"];

    // Llenar campos
    long long idElefante = [[self.detalleElefanteBlanco objectForKey:@"id"] longLongValue];
    int estadoElefante = [[self.detalleElefanteBlanco objectForKey:@"estado"] intValue];
    NSNumber *idMiniPrinc = [self.detalleElefanteBlanco objectForKey:@"idMiniaturaPrincipal"];
    long long idMiniaturaPrincipal = 0;
    if (idMiniPrinc && [idMiniPrinc isKindOfClass:[NSNumber class]]) {
        idMiniaturaPrincipal = [idMiniPrinc longLongValue];
    }
    NSArray *fotosTArray = [self.detalleElefanteBlanco objectForKey:@"miniaturas"];
    NSMutableArray *fotosArray = [[NSMutableArray alloc] init];
    if ([fotosArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary *foto in fotosTArray) {
            long long idFoto = [[foto objectForKey:@"id"] longLongValue];
            if (idFoto == idMiniaturaPrincipal) {
                [fotosArray insertObject:foto atIndex:0];
            } else {
                [fotosArray addObject:foto];
            }
        }
        self.fotos = [NSMutableArray arrayWithArray:fotosArray];
        self.cantidadFotosLabel.text = [NSString stringWithFormat:@"%d", fotosArray.count];
    }
    NSString *titulo = [self.detalleElefanteBlanco objectForKey:@"titulo"];
    if (titulo && [titulo isKindOfClass:[NSString class]]) {
       // self.nombreElefanteLabel.text = titulo;
        self.nombreElefanteText.text = titulo;
    }
    NSString *fechaReporte = [self.detalleElefanteBlanco objectForKey:@"fechaReporte"];
    if (fechaReporte && [fechaReporte isKindOfClass:[NSString class]]) {
        self.fechaElefanteLabel.text = [NSString stringWithFormat:@"Fecha de Reporte: %@", fechaReporte];
    }
    NSNumber *rechazosNumb = [self.detalleElefanteBlanco objectForKey:@"rechazos"];
    if (rechazosNumb && [rechazosNumb isKindOfClass:[NSNumber class]]) {
        int rechazos = [rechazosNumb intValue];
        self.cantidadRechazosLabel.text = [NSString stringWithFormat:@"%d", rechazos];
        self.rechazarLabel.text = [NSString stringWithFormat:@"%d", rechazos];
    }
    NSString *entidad = [self.detalleElefanteBlanco objectForKey:@"entidad"];
    if (entidad && [entidad isKindOfClass:[NSString class]]) {
       // self.nombreEntidadLabel.text = entidad;
        self.entidadTituloText.text = entidad;
    }
    
    NSObject *municipioObj = [self.detalleElefanteBlanco objectForKey:@"municipio"];
    NSNumber *municipioNumb = nil;
    if (municipioObj && [municipioObj isKindOfClass:[NSNumber class]]) {
        municipioNumb = (NSNumber *)municipioObj;
    } else if (municipioObj && [municipioObj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)municipioObj;
        int val = [str intValue];
        municipioNumb = [NSNumber numberWithInt:val];
    }
    
    if (municipioNumb && [municipioNumb isKindOfClass:[NSNumber class]]) {
        int municipio = [municipioNumb intValue];
        int depto = municipio / 1000;
        NSArray *deptos = [LectorLocalJson obtenerElementosJsonDeArchivo:@"departamentos"];
        NSArray *munics = [LectorLocalJson obtenerElementosJsonDeArchivo:@"municipios"];
        NSString *deptoStr = @"";
        for (NSDictionary *item in deptos) {
            int iDp = [[item objectForKey:@"codigo"] intValue];
            if (iDp == depto) {
                deptoStr = [item objectForKey:@"nombre"];
                break;
            }
        }
        NSString *municStr = @"";
        for (NSDictionary *item in munics) {
            int iMn = [[item objectForKey:@"codigo"] intValue];
            if (iMn == municipio) {
                municStr = [item objectForKey:@"nombre"];
                break;
            }
        }
        NSString *deptoMunicStr = [NSString stringWithFormat:@"%@ / %@", deptoStr, municStr];
        self.departamentoUbicacionLabel.text = deptoMunicStr;
    }
    
    [Servicios consultarRangosDeTiempoConBloque:^(NSArray *rangosArray, NSError *error) {
        if (error) {
            if (error.code >= 500) {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
            } else {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
            }
        } else {
            if (rangosArray && rangosArray.count) {
                
                self.tiemposArray = [NSMutableArray arrayWithArray:rangosArray];
                
                [self.tiemposPicker reloadAllComponents];
                
                int idTiempoEB = [[self.detalleElefanteBlanco objectForKey:@"rangoTiempo"] intValue];
                for (NSDictionary *tiempo in rangosArray) {
                    int idTiempo = [[tiempo objectForKey:@"id"] intValue];
                    if (idTiempo == idTiempoEB) {
                        self.rangoTiempoElefante = tiempo;
                        break;
                    }
                }
            }
        }
    }];
    [Servicios consultarRazonesDeElefantesConBloque:^(NSArray *razonesResArray, NSError *error) {
        if (error) {
            if (error.code >= 500) {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
            } else {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
            }
        } else {
            if (razonesResArray && razonesResArray.count) {
                int idRazonEB = [[self.detalleElefanteBlanco objectForKey:@"idMotivo"] intValue];
                for (NSDictionary *razon in razonesResArray) {
                    
                    self.razonesArray = [NSMutableArray arrayWithArray:razonesResArray];
                    
                    [self.razonesPicker reloadAllComponents];
                    
                    int idRazon = [[razon objectForKey:@"id"] intValue];
                    if (idRazon == idRazonEB) {
                        self.razonElefante = razon;
                        self.razonElefanteText.text = [self.razonElefante objectForKey:@"texto"];
                        //self.razonLabel.text = [self.razonElefante objectForKey:@"texto"];
                        break;
                    }
                }
            }
        }
    }];
    
    int estadoCosto = [[self.detalleElefanteBlanco objectForKey:@"costoEstado"] intValue];
    int estadoContratista = [[self.detalleElefanteBlanco objectForKey:@"contratistaEstado"] intValue];
    int estadoTiempo = [[self.detalleElefanteBlanco objectForKey:@"rangoTiempoEstado"] intValue];
    
    
    double costoDbl = [[self.detalleElefanteBlanco objectForKey:@"costo"] doubleValue];
    NSNumber *costoNumb = [NSNumber numberWithDouble:costoDbl];
    NSNumberFormatter *precioFormatter = [[NSNumberFormatter alloc] init];
    precioFormatter.formatterBehavior = NSNumberFormatterBehavior10_4;
    precioFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    precioFormatter.maximumFractionDigits = 0;
    NSString *costoStr = [precioFormatter stringFromNumber:costoNumb];
    NSString *contratistaStr = [self.detalleElefanteBlanco objectForKey:@"contratista"];
    if ([contratistaStr isKindOfClass:[NSNull class]]) {
        contratistaStr = @" ";
    }
    NSNumber *rangoTiempo = [NSNumber numberWithInt:[[self.detalleElefanteBlanco objectForKey:@"idRangoTiempo"] intValue]];
    NSDictionary *masInfoDatos = @{@"tiempo": rangoTiempo, @"costo" : costoStr, @"contratista" : contratistaStr};
    
    self.masInfoView = [MasInformacionView initMasInformacionViewParaDespliegueEditandoConDatos:masInfoDatos];
    self.masInfoView.delegado = self;
    
    if (self.esAgregarFoto) {
        if (fotosArray.count < 10) {
            [self.accionesContenedor addSubview:self.agregarFotoContenedor];
            [self.rechazarContenedor removeFromSuperview];
        } else {
            [self.accionesContenedor addSubview:self.rechazarContenedor];
            [self.agregarFotoContenedor removeFromSuperview];
        }
    } else {
        [self.accionesContenedor addSubview:self.rechazarContenedor];
        [self.agregarFotoContenedor removeFromSuperview];
    }
    
    
    if (self.masInfoView) {
        [self.masInfoContenedor addSubview:self.masInfoView];
    }
    

    
    if (self.esElefanteMio) {
        if (estadoTiempo != 1) {
            self.masInfoView.tiempoDespliegueText.hidden = NO;
            self.masInfoView.tiempoLabel.hidden = YES;
            self.masInfoView.tiempoDesplegable = YES;
        }
        
        if (estadoContratista != 1) {
            self.masInfoView.contratistaDespliegueText.hidden = NO;
            self.masInfoView.contratistaLabel.hidden = YES;
        }
        
        if (estadoCosto != 1) {
            self.masInfoView.costoDespliegueText.hidden = NO;
            self.masInfoView.costoLabel.hidden = YES;
        }
        if (estadoElefante != ESTADO_ELEFANTE_PENDIENTE) {
            self.notificacionesContenedor.hidden = NO;
        } else {
            self.notificacionesContenedor.hidden = YES;
        }
    } else {
        self.notificacionesContenedor.hidden = YES;
        
        self.botonesContenedor.frame = CGRectMake(self.botonesContenedor.frame.origin.x, self.notificacionesContenedor.frame.origin.y, self.botonesContenedor.frame.size.width, self.botonesContenedor.frame.size.height);
        
        self.masInfoView.estaEditando = YES;
        
        if (estadoTiempo != 1) {
            self.masInfoView.tiempoDespliegueText.hidden = NO;
            self.masInfoView.tiempoLabel.hidden = YES;
            self.masInfoView.estaEditando = YES;
            //self.actualizarButton.enabled = NO;
            //self.masInfoView.tiempoDespliegueText.text = @"";
            //self.masInfoView.tiempoText.text = @"";
            //self.masInfoView.tiempoDesplegable = NO;
            //self.masInfoView.desplegarTiempoFlechaImage.hidden = NO;
            //self.masInfoView.tiempoFlechaImage.hidden = NO;
        } else if ([rangoTiempo intValue] == 0) {
            self.masInfoView.tiempoDespliegueText.hidden = NO;
            self.masInfoView.tiempoLabel.hidden = YES;
            self.masInfoView.estaEditando = YES;
            self.actualizarButton.enabled = NO;
            //self.masInfoView.tiempoDespliegueText.text = @"";
            //self.masInfoView.tiempoText.text = @"";
            self.masInfoView.tiempoDesplegable = NO;
            self.masInfoView.desplegarTiempoFlechaImage.hidden = NO;
            self.masInfoView.tiempoFlechaImage.hidden = NO;
        } else {
            self.masInfoView.tiempoDespliegueText.hidden = YES;
            self.masInfoView.tiempoText.hidden = YES;
            self.masInfoView.tiempoLabel.hidden = NO;
            self.masInfoView.desplegarTiempoFlechaImage.hidden = YES;
            self.masInfoView.tiempoFlechaImage.hidden = YES;
        }
        
        if (estadoCosto != 1) {
            self.masInfoView.costoDespliegueText.hidden = NO;
            self.masInfoView.costoLabel.hidden = YES;
            self.masInfoView.estaEditando = YES;
            self.actualizarButton.enabled = NO;
            //self.masInfoView.costoDespliegueText.text = @"";
        } else {
            self.masInfoView.costoDespliegueText.hidden = YES;
            self.masInfoView.costoLabel.hidden = NO;
        }
        
        if (estadoContratista != 1) {
            self.masInfoView.contratistaDespliegueText.hidden = NO;
            self.masInfoView.contratistaLabel.hidden = YES;
            self.masInfoView.estaEditando = YES;
            self.actualizarButton.enabled = NO;
            //self.masInfoView.contratistaDespliegueText.text = @"";
        } else {
            self.masInfoView.contratistaDespliegueText.hidden = YES;
            self.masInfoView.contratistaLabel.hidden = NO;
        }
    }
    
    // Contenedor de notificaciones
    NSString *mensaje = [self.detalleElefanteBlanco objectForKey:@"comentario"];
    if ([mensaje isKindOfClass:[NSNull class]]) {
        mensaje = @" ";
    }
    UIFont *mensajeFuente = FUENTE_ACERCA_DE_ELEMENTO(13);
    CGSize mensajeSize = [mensaje sizeWithFont:mensajeFuente
                             constrainedToSize:CGSizeMake(270, 5000)
                                 lineBreakMode:NSLineBreakByWordWrapping];
    mensajeSize.height *= 1.8;
    int nLineas = (mensajeSize.height / 21);
    CGRect mensajeRect = CGRectMake(20, 41, mensajeSize.width, mensajeSize.height);
    self.notificacionesLabel.numberOfLines = nLineas;
    self.notificacionesLabel.frame = mensajeRect;
    self.notificacionesLabel.text = mensaje;
    
    CGFloat y = self.masInfoContenedor.frame.origin.y + self.masInfoContenedor.frame.size.height + 6;
    CGFloat h = 41 + mensajeRect.size.height + 4;
    self.notificacionesContenedor.frame = CGRectMake(0, y, 320, h);
    
    // Contenedor de botones
    if (!self.notificacionesContenedor.hidden) {
        y = self.notificacionesContenedor.frame.origin.y + self.notificacionesContenedor.frame.size.height + 6;
        self.botonesContenedor.frame = CGRectMake(0, y, 320, self.botonesContenedor.frame.size.height);
    } else {
        y = self.notificacionesContenedor.frame.origin.y;
        self.botonesContenedor.frame = CGRectMake(0, y, 320, self.botonesContenedor.frame.size.height);
    }
    
    y = self.botonesContenedor.frame.origin.y + self.botonesContenedor.frame.size.height + 10;
    y = 700;
    self.contenidoScroller.contentSize = CGSizeMake(320, y);
    
    if (!self.masInfoView.estaEditando) {
        self.botonesContenedor.hidden = YES;
    } else {
        self.botonesContenedor.hidden = NO;
    }
    
    
    // Contenedor de estadísticas
    if (estadoElefante != ESTADO_ELEFANTE_APROBADO) {  // diferente a estado aprobado
        self.estadisticasContenedor.hidden = NO;
    } else {
        self.estadisticasContenedor.hidden = NO;
    }
    
    self.alturaContenidoScroller = self.contenidoScroller.contentSize.height; // 690;
    
    // Íconos
    self.iconoPendiente = [UIImage imageNamed:@"icono_pendiente.png"];
    self.iconoAprobado = [UIImage imageNamed:@"icono_aprobado.png"];
    self.iconoRechazado = [UIImage imageNamed:@"icono_rechazado"];
    
    // Contenedor de estadísticas
    if (estadoElefante == ESTADO_ELEFANTE_APROBADO) {  // diferente a estado aprobado
        self.estadoElefanteContenedor.hidden = NO;
        self.estadoElefanteImage.image = self.iconoAprobado;
        self.estadoElefanteLabel.text = TEXTO_APROBADO;
    }else if (estadoElefante == ESTADO_ELEFANTE_PENDIENTE) {
        self.estadisticasContenedor.hidden = NO;
        self.estadoElefanteImage.image = self.iconoPendiente;
        self.estadoElefanteLabel.text = TEXTO_PENDIENTE;
    } else {
        self.estadisticasContenedor.hidden = NO;
        self.estadoElefanteImage.image = self.iconoRechazado;
        self.estadoElefanteLabel.text = TEXTO_RECHAZADO;
    }
    
    if (self.esElefanteMio) {
        [self.accionesContenedor addSubview:self.estadoElefanteContenedor];
        [self.rechazarContenedor removeFromSuperview];
    } else {
        [self.estadoElefanteContenedor removeFromSuperview];
    }
    
    // Fondo botones
    UIImage *botonRojoRaw = [UIImage imageNamed:@"boton_rojo1.png"];
    UIEdgeInsets botonRojoEdges;
    botonRojoEdges.top = 12;
    botonRojoEdges.bottom = 24;
    botonRojoEdges.left = 18;
    botonRojoEdges.right = 18;
    UIImage *botonRojoImg = [botonRojoRaw resizableImageWithCapInsets:botonRojoEdges resizingMode:UIImageResizingModeTile];
    [self.actualizarButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    
    [self.razonesButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    [self.cancelarRazonButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    [self.tiemposButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    [self.cancelarTiempoButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    
    // Fotos
    self.contenidoScroller.delegate = self;
    self.fotoScroller.delegate = self;
    self.fotosVistas = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.fotos.count; i++) {
        [self.fotosVistas addObject:[NSNull null]];
    }
    self.controlPaginacion.numberOfPages = self.fotos.count;
    [self cargarFotosVisibles];
    
    // Zona de acciones
    if (self.esElefanteMio) {
        self.botonesContenedor.hidden = NO;
    }
    
    // Ya No es Un Elefante?
    NSNumber *noEsElefanteNumb = [self.detalleElefanteBlanco objectForKey:@"noEsUnElefante"];
    if (noEsElefanteNumb && [noEsElefanteNumb isKindOfClass:[NSNumber class]]) {
        BOOL yaNoEsElefante = [noEsElefanteNumb boolValue];
        if (yaNoEsElefante) {
            self.masInfoView.yaNoEsElefanteLabel.hidden = NO;
            self.masInfoView.yaNoEsElefanteDespliegueLabel.hidden = NO;
        } else {
            self.masInfoView.yaNoEsElefanteLabel.hidden = YES;
            self.masInfoView.yaNoEsElefanteDespliegueLabel.hidden = YES;
        }
    }
 
    // Validar si ya se votó por este elefante
    [self.agregarRechazoButton setImage:self.manoAbajoHab forState:UIControlStateNormal];
    [self.rechazarButton setImage:self.manoAbajoHab forState:UIControlStateNormal];
    [self.agregarRechazoButton setImage:self.manoAbajoHab forState:UIControlStateDisabled];
    [self.rechazarButton setImage:self.manoAbajoHab forState:UIControlStateDisabled];
    self.agregarRechazoButton.enabled = YES;
    self.rechazarButton.enabled = YES;
    NSString *elefantesVotados = GET_USERDEFAULTS(USUARIO_ELEFANTES_VOTADOS);
    NSArray *votosArray = [elefantesVotados componentsSeparatedByString:@","];
    for (NSString *voto in votosArray) {
        long long idVoto = [voto longLongValue];
        if (idVoto == idElefante) {
            [self.agregarRechazoButton setImage:self.manoAbajoDes forState:UIControlStateNormal];
            [self.rechazarButton setImage:self.manoAbajoDes forState:UIControlStateNormal];
            [self.agregarRechazoButton setImage:self.manoAbajoDes forState:UIControlStateDisabled];
            [self.rechazarButton setImage:self.manoAbajoDes forState:UIControlStateDisabled];
            self.agregarRechazoButton.enabled = NO;
            self.rechazarButton.enabled = NO;
            break;
        }
    }

}



- (IBAction)irAtras:(id)sender
{
    REMOVER_OBERVADOR_UBICACION(self);
    
    NSArray *controllers = [self.navigationController viewControllers];
    
    UIViewController *listaVC = [controllers objectAtIndex:(controllers.count - 2)];
    if ([listaVC isKindOfClass:[ListaElefantesViewController class]]) {
        ListaElefantesViewController *listaElefantesVC = (ListaElefantesViewController *)listaVC;
        if (listaElefantesVC.esMasVotados) {
            [listaElefantesVC recargarListaMasVotados];
            [self.navigationController popToViewController:listaVC animated:YES];
        } else {
            [listaElefantesVC regargarMisElefantes];
            [self.navigationController popToViewController:listaVC animated:YES];
        }
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (IBAction)irADetalleFoto:(id)sender
{
    [self.cargando mostrar];
    NSDictionary *foto = [self.fotos objectAtIndex:self.controlPaginacion.currentPage];
    long long idFoto = [[foto objectForKey:@"idImagenGrande"] longLongValue];
    
    [Servicios obtenerImagenGrande:idFoto conBloque:^(NSString *imagenBase64, NSError *error) {
        if (error) {
            if (error.code >= 500) {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
            } else {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
            }
        } else {
            if (imagenBase64 && [imagenBase64 isKindOfClass:[NSString class]]) {
                if (imagenBase64.length) {
                    NSString *imgBase64 = imagenBase64;
                    NSData *imgData = [NSData dataFromBase64String:imgBase64];
                    if (imgData) {
                        UIImage *imagenVw = [UIImage imageWithData:imgData];
                        FotoDetalleView *fotoDetalle = [[FotoDetalleView alloc] initParaFoto:imagenVw sobreVistaPadre:self.view];
                        [fotoDetalle mostrar];
                    }
                }
            }
        }
        
        [self.cargando ocultar];
    }];
    
}



- (IBAction)irAActualizar:(id)sender
{
    [self enviarDatosParaActualizacion];
}


- (IBAction)irARechazar:(id)sender
{
    [self.cargando mostrar];
    long long idElefante = [[self.detalleElefanteBlanco objectForKey:@"id"] longLongValue];
    [Servicios votarRechazoAElefante:idElefante conBloque:^(int nuevosVotos, NSError *error) {
        if (error || !nuevosVotos) {
            if (error.code >= 500) {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
            } else {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
            }
        } else {
            [self.alerta mostrarMensajeConLetrero:@"Su voto fue registrado"];
            self.cantidadRechazosLabel.text = [NSString stringWithFormat:@"%d", nuevosVotos];
            
            // Guardar ID de elefante votado
            NSString *idElefanteStr = [NSString stringWithFormat:@"%lld", idElefante];
            NSString *elefantesVotados = GET_USERDEFAULTS(USUARIO_ELEFANTES_VOTADOS);
            if (elefantesVotados && [elefantesVotados isKindOfClass:[NSString class]]) {
                NSArray *votosArray = [elefantesVotados componentsSeparatedByString:@","];
                NSMutableArray *misVotos = [NSMutableArray arrayWithArray:votosArray];
                [misVotos addObject:idElefanteStr];
                elefantesVotados = [misVotos componentsJoinedByString:@","];
                SET_USERDEFAULTS(USUARIO_ELEFANTES_VOTADOS, elefantesVotados);
                SYNC_USERDEFAULTS;
            } else {
                NSMutableArray *misVotos = [[NSMutableArray alloc] init];
                [misVotos addObject:idElefanteStr];
                elefantesVotados = [misVotos componentsJoinedByString:@","];
                SET_USERDEFAULTS(USUARIO_ELEFANTES_VOTADOS, elefantesVotados);
                SYNC_USERDEFAULTS;
            }
            
            [self.agregarRechazoButton setImage:self.manoAbajoDes forState:UIControlStateNormal];
            [self.rechazarButton setImage:self.manoAbajoDes forState:UIControlStateNormal];
            [self.agregarRechazoButton setImage:self.manoAbajoDes forState:UIControlStateDisabled];
            [self.rechazarButton setImage:self.manoAbajoDes forState:UIControlStateDisabled];
            self.agregarRechazoButton.enabled = NO;
            self.rechazarButton.enabled = NO;
        }
        
        [self.cargando ocultar];
    }];
}


- (IBAction)irAAgregarFoto:(id)sender
{
    NSDictionary *posicion = [self.detalleElefanteBlanco objectForKey:@"posicion"];
    CGFloat lat = [[posicion objectForKey:@"latitud"] floatValue];
    CGFloat lon = [[posicion objectForKey:@"longitud"] floatValue];
    CLLocationCoordinate2D elefantePunto = CLLocationCoordinate2DMake(lat, lon);
    CLLocation *punto1 = [[CLLocation alloc] initWithLatitude:elefantePunto.latitude longitude:elefantePunto.longitude];
    CLLocation *punto2 = [[CLLocation alloc] initWithLatitude:self.coordenadasUsuario.latitude longitude:self.coordenadasUsuario.longitude];
    CLLocationDistance distancia = [punto1 distanceFromLocation:punto2];
    int distanciaMinima = DISTANCIA_MINIMA_FOTO;
    if (distancia > distanciaMinima) {
        NSString *distanciaMsg = [NSString stringWithFormat:@"Debe estar a menos de %d metros del elefante para poder agregar una foto.", distanciaMinima];
        [self.alerta mostrarMensajeConLetrero:distanciaMsg];
    }
    else {
        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        pickerView.delegate = self;
        pickerView.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
        pickerView.allowsEditing = NO;
        pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerView.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        [self.navigationController presentViewController:pickerView animated:YES completion:^{
        }];
    }
}


- (IBAction)irAAgregarRechazo:(id)sender
{
    [self.cargando mostrar];
    long long idElefante = [[self.detalleElefanteBlanco objectForKey:@"id"] longLongValue];
    [Servicios votarRechazoAElefante:idElefante conBloque:^(int nuevosVotos, NSError *error) {
        if (error || !nuevosVotos) {
            if (error.code >= 500) {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
            } else {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
            }
        } else {
            [self.alerta mostrarMensajeConLetrero:@"Su voto fue registrado"];
            self.cantidadRechazosLabel.text = [NSString stringWithFormat:@"%d", nuevosVotos];
            
            // Guardar ID de elefante votado
            NSString *idElefanteStr = [NSString stringWithFormat:@"%lld", idElefante];
            NSString *elefantesVotados = GET_USERDEFAULTS(USUARIO_ELEFANTES_VOTADOS);
            if (elefantesVotados && [elefantesVotados isKindOfClass:[NSString class]]) {
                NSArray *votosArray = [elefantesVotados componentsSeparatedByString:@","];
                NSMutableArray *misVotos = [NSMutableArray arrayWithArray:votosArray];
                [misVotos addObject:idElefanteStr];
                elefantesVotados = [misVotos componentsJoinedByString:@","];
                SET_USERDEFAULTS(USUARIO_ELEFANTES_VOTADOS, elefantesVotados);
                SYNC_USERDEFAULTS;
            } else {
                NSMutableArray *misVotos = [[NSMutableArray alloc] init];
                [misVotos addObject:idElefanteStr];
                elefantesVotados = [misVotos componentsJoinedByString:@","];
                SET_USERDEFAULTS(USUARIO_ELEFANTES_VOTADOS, elefantesVotados);
                SYNC_USERDEFAULTS;
            }
            
            [self.agregarRechazoButton setImage:self.manoAbajoDes forState:UIControlStateNormal];
            [self.rechazarButton setImage:self.manoAbajoDes forState:UIControlStateNormal];
            [self.agregarRechazoButton setImage:self.manoAbajoDes forState:UIControlStateDisabled];
            [self.rechazarButton setImage:self.manoAbajoDes forState:UIControlStateDisabled];
            self.agregarRechazoButton.enabled = NO;
            self.rechazarButton.enabled = NO;
        }
        
        [self.cargando ocultar];
    }];
}



- (void)enviarDatosParaActualizacion
{
    NSString *nombreStr = [self.nombreElefanteText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *entidadStr = [self.entidadTituloText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [self.cargando mostrar];
      NSString *razonStr = [self.razonElefanteText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (!nombreStr) {
        nombreStr = @"";
    }
    if (!entidadStr) {
        entidadStr = @"";
    }
    if (!razonStr) {
        razonStr = @"";
    }
    
    NSString *mensaje = @"";
    
    if ([nombreStr isEqualToString:@""]) {
        mensaje = [NSString stringWithFormat:@"%@%@", mensaje, @"Campo de Nombre es requerido.\r"];
    }
    if ([entidadStr isEqualToString:@""]) {
        mensaje = [NSString stringWithFormat:@"%@%@", mensaje, @"Campo de Entidad es requerido.\r"];
    }
    if ([razonStr isEqualToString:@""]) {
        mensaje = [NSString stringWithFormat:@"%@%@", mensaje, @"Debe seleccionar una razón.\r"];
    }
    
    if (![mensaje isEqualToString:@""]) {
        mensaje = @"por favor diligencie los campos marcados con asterisco.";
        self.alerta.bandera = 0;
        [self.alerta mostrarMensajeConLetrero:mensaje];
        
        [self.cargando ocultar];
        
        return;
    }
    
    
    // Si están todos los campos requeridos, crear reporte
    NSString *costoStr = [self.masInfoView.costoDespliegueText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    costoStr = [costoStr stringByReplacingOccurrencesOfString:@"." withString:@""];
    costoStr = [costoStr stringByReplacingOccurrencesOfString:@"," withString:@""];
    costoStr = [costoStr stringByReplacingOccurrencesOfString:@"'" withString:@""];
    NSNumberFormatter *formato = [[NSNumberFormatter alloc] init];
    [formato setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber *costoNumb = [formato numberFromString:costoStr];
    if (!costoNumb) {
        double costoDbl = [costoStr doubleValue];
        costoNumb = [NSNumber numberWithDouble:costoDbl];
    }
    
    NSString *contratistaStr = [self.masInfoView.contratistaDespliegueText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSNumber *idTiempo = [NSNumber numberWithInt:0];
    if (self.masInfoView.tiempoSeleccionado) {
        int idT = [[self.masInfoView.tiempoSeleccionado objectForKey:@"id"] intValue];
        idTiempo = [NSNumber numberWithInt:idT];
    }
    
    int motivo = [[self.detalleElefanteBlanco objectForKey:@"idMotivo"] intValue];
    NSNumber *idRazon = [NSNumber numberWithInt:motivo];
    
    NSDictionary *nuevoElefante = @{@"entidad" : entidadStr,
                                    @"idRangoTiempo" : idTiempo,
                                    @"titulo" : nombreStr,
                                    @"idMotivo" : idRazon,
                                    @"costo" : costoNumb,
                                    @"contratista" : contratistaStr};
    long long idElefante = [[self.detalleElefanteBlanco objectForKey:@"id"] longLongValue];
    
    if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
        [Servicios modificarMiElefante:nuevoElefante conIdElefante:idElefante conBloque:^(BOOL modificado, NSError *error) {
            if (error || !modificado) {
                if (error.code >= 500) {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
                } else {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
                }
                
                [self.cargando ocultar];
            } else if (modificado) {
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
                        self.detalleElefanteBlanco = elefanteDiccionario;
                        [self llenarCampos];
                        self.alerta.bandera = 10;
                        [self.alerta mostrarMensajeConLetrero:@"Esta información pasará a un proceso de validación, el administrador se reserva el derecho de modificar, complementar o eliminar total o parcialmente la información falsa,  de carácter ofensivo o agraviante."];
                    }
                    
                    [self.cargando ocultar];
                }];
            }
        }];
    } else {
        self.miBloqueEditar = ^(BOOL modificado, NSError *error) {
            if (error || !modificado) {
                if (error.code >= 500) {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
                } else {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
                }
                
                [self.cargando ocultar];
            } else if (modificado) {
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
                        self.detalleElefanteBlanco = elefanteDiccionario;
                        [self llenarCampos];
                        self.alerta.bandera = 10;
                        [self.alerta mostrarMensajeConLetrero:@"Esta información pasará a un proceso de validación, el administrador se reserva el derecho de modificar, complementar o eliminar total o parcialmente la información falsa,  de carácter ofensivo o agraviante."];
                    }
                    
                    [self.cargando ocultar];
                }];
            }
        };
        [self.miServicioConexion iniciarEditarElefante:nuevoElefante conIdElefante:idElefante conBloque:self.miBloqueEditar];
    }
    
    
}


#pragma mark - MasInformacionViewDelegate métodos
- (void)masInformacionViewIniciaEditar:(MasInformacionView *)vista
{
    self.contenidoScroller.contentSize = CGSizeMake(self.contenidoScroller.frame.size.width, self.alturaContenidoScroller + ALTURA_TECLADO);
    
    CGFloat y = self.masInfoView.frame.origin.y + self.masInfoView.frame.size.height + ALTURA_TECLADO;
    CGRect rect = CGRectMake(0, y, 320, self.masInfoView.frame.size.height);
    [self.contenidoScroller scrollRectToVisible:rect animated:YES];

}

- (void)masInformacionViewTerminaEditar:(MasInformacionView *)vista
{
    self.contenidoScroller.contentSize = CGSizeMake(self.contenidoScroller.frame.size.width, self.alturaContenidoScroller);
    [self.contenidoScroller scrollRectToVisible:CGRectMake(0, 0, 320, 2) animated:YES];

    if (self.masInfoView.tiempoSeleccionado) {
        int rangoTmp = [[self.detalleElefanteBlanco objectForKey:@"idRangoTiempo"] intValue];
        int idT = [[self.masInfoView.tiempoSeleccionado objectForKey:@"id"] intValue];
        
        if (rangoTmp != idT) {
            self.actualizarButton.enabled = YES;
        }
    }
    NSString *costoStr = [self.masInfoView.costoDespliegueText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *contratistaStr = [self.masInfoView.costoDespliegueText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![costoStr isEqualToString:@""]) {
        self.actualizarButton.enabled = YES;
    }
    if (![contratistaStr isEqualToString:@""]) {
        self.actualizarButton.enabled = YES;
    }
}


- (IBAction)irASeleccionarRazon:(id)sender
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.razonesContenedor.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.view sendSubviewToBack:self.razonesContenedor];
                         self.razonesContenedor.hidden = YES;
                         
                         int i = [self.razonesPicker selectedRowInComponent:0];
                         NSDictionary *itemDic = [self.razonesArray objectAtIndex:i];
                         
                         self.razonElefante = itemDic;
                         
                         self.razonElefanteText.text = [itemDic objectForKey:@"texto"];
                     }];
}

-(IBAction)irASeleccionarTiempo:(id)sender{
    [UIView animateWithDuration:0.3
                          delay:0
                         options:(UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.tiemposContenedor.alpha = 0;
                     }
                     completion:^(BOOL finished){
                     }];
     
}


-(IBAction)irACancelarRazon:(id)sender{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.razonesContenedor.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.view sendSubviewToBack:self.razonesContenedor];
                         self.razonesContenedor.hidden = YES;
                     }];
}


-(IBAction)irACancelarTiempo:(id)sender{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.tiemposContenedor.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.view sendSubviewToBack:self.tiemposContenedor];
                         self.tiemposContenedor.hidden = YES;
                     }];
}

-(IBAction)irACerrarTeclados:(id)sender{
    [self allResignResponder];
}


- (void)allResignResponder
{
    [self.nombreElefanteText resignFirstResponder];
    [self.entidadTituloText resignFirstResponder];
    [self.razonElefanteText resignFirstResponder];
    
    for (UIButton *boton in self.cerrarTecladoButtonsArray) {
        boton.hidden = YES;
    }
}


#pragma mark - UITextFieldDelegate métodos
-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    for(UIButton *boton in self.cerrarTecladoButtonsArray){
        boton.hidden = NO;
    }
    
    
    if (textField == self.razonElefanteText) {
    self.razonesContenedor.hidden = NO;
    [self.view bringSubviewToFront:self.razonesContenedor];
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.razonesContenedor.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                     }];
    
    return NO;
    }
    
    
    [self allResignResponder];
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.nombreElefanteText) {
        if ((textField.text.length + string.length) > 80) {
            return NO;
        }
        BOOL validar = [Definiciones validarCadenaCaracteresValidos:string];
        return validar;
    } else if (textField == self.entidadTituloText) {
        if ((textField.text.length + string.length) > 80) {
            return NO;
        }
        BOOL validar = [Definiciones validarCadenaCaracteresValidos:string];
        return validar;
    }
    
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.contenidoScroller.contentSize = CGSizeMake(self.contenidoScroller.frame.size.width, self.alturaContenidoScroller);
    [self.contenidoScroller scrollRectToVisible:CGRectMake(0, 0, 320, 2) animated:YES];
    
    [self allResignResponder];
}






#pragma mark - UIPickerVideDelegate métodos
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    if(pickerView == self.razonesPicker){
        if(self.razonesArray){
            return self.razonesArray.count;
        }else{
            return 0;
        }
    }else if(pickerView == self.tiemposPicker){
        if(self.tiemposArray){
            return self.tiemposArray.count;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSArray *itemsArray = nil;
    
    if(pickerView == self.razonesPicker){
        itemsArray = self.razonesArray;
    }else if(pickerView== self.tiemposPicker){
        itemsArray= self.tiemposArray;
    }
    
    if(itemsArray && itemsArray.count){
        NSDictionary *item = [itemsArray objectAtIndex:row];
        NSString *nombre = [item objectForKey:@"texto"];
        return nombre;
    }else{
        return @"";
    }
    
}


#pragma mark - UIScrollViewDelegate methods
- (void)cargarFotosVisibles
{
    CGFloat pageWidth = self.fotoScroller.frame.size.width;
    NSInteger pagina = (NSInteger)floor((self.fotoScroller.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0));
    
    self.controlPaginacion.currentPage = pagina;
    
    int primera = pagina - 1;
    int ultima = pagina + 1;
    int i = 0;
    
    for (i = 0; i < primera; i++) {
        [self purgarPagina:i];
    }
    for (i = primera; i <= ultima; i++) {
        [self cargarPagina:i];
    }
    for (i = ultima+1; i < self.fotos.count; i++) {
        [self purgarPagina:i];
    }
    
    self.fotoScroller.contentSize = CGSizeMake(self.fotoScroller.frame.size.width * self.fotos.count, self.fotoScroller.frame.size.height);
}

- (void)cargarPagina:(int)pagina
{
    if (pagina < 0 || pagina >= self.fotos.count) {
        return;
    }
    
    UIView *fotoView = [self.fotosVistas objectAtIndex:pagina];
    if ((NSNull*)fotoView == [NSNull null]) {
        CGRect frameVw = CGRectMake(self.fotoScroller.frame.origin.x, self.fotoScroller.frame.origin.y, self.fotoScroller.frame.size.width, self.fotoScroller.frame.size.height);
        frameVw.origin.x = frameVw.size.width * pagina;
        frameVw.origin.y = 0.0;
        CGFloat insetX = frameVw.size.width - (frameVw.size.width * 0.95);
        CGFloat insetY = frameVw.size.height - (frameVw.size.height * 0.95);
        frameVw = CGRectInset(frameVw, insetX, insetY);
        
        NSDictionary *foto = [self.fotos objectAtIndex:pagina];
        NSString *imgBase64 = [foto objectForKey:@"miniatura"];
        if ([imgBase64 isKindOfClass:[NSNull class]]) {
            return;
        }
        NSData *imgData = [NSData dataFromBase64String:imgBase64];
        UIImage *imagenVw = [UIImage imageWithData:imgData];
        UIView *imagenContenedor = [[UIView alloc] initWithFrame:frameVw];
        CGFloat minVal = (frameVw.size.width < frameVw.size.height) ? frameVw.size.width : frameVw.size.height;
        CGRect imgRect = CGRectMake(0, 0, minVal, minVal);
        imgRect.origin.x = (frameVw.size.width / 2) - (imgRect.size.width / 2);
        imgRect.origin.y = (frameVw.size.height / 2) - (imgRect.size.height / 2);
        UIImageView *imagenView = [[UIImageView alloc] initWithFrame:imgRect];
        imagenView.contentMode = UIViewContentModeScaleAspectFit;
        imagenView.backgroundColor = [UIColor clearColor];
        imagenContenedor.backgroundColor = [UIColor clearColor];
        imagenView.image = imagenVw;
        [imagenContenedor addSubview:imagenView];
        
        UIButton *fotoDetalleButton = [[UIButton alloc] initWithFrame:imgRect];
        [fotoDetalleButton addTarget:self action:@selector(irADetalleFoto:) forControlEvents:UIControlEventTouchUpInside];
        [imagenContenedor addSubview:fotoDetalleButton];
        
        [self.fotosVistas replaceObjectAtIndex:pagina withObject:imagenContenedor];
        [self.fotoScroller addSubview:imagenContenedor];
        
        NSLog(@"foto %d agregada", pagina);
    }
}

- (void)purgarPagina:(int)pagina
{
    if (pagina < 0 || pagina >= self.fotosVistas.count) {
        return;
    }
    
    UIView *paginaView = [self.fotosVistas objectAtIndex:pagina];
    if ((NSNull*)paginaView != [NSNull null]) {
        [paginaView removeFromSuperview];
        [self.fotosVistas replaceObjectAtIndex:pagina withObject:[NSNull null]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.fotoScroller) {
        if (self.fotos) {
            if (self.fotos.count) {
                [self cargarFotosVisibles];
            }
        }
    }
}


#pragma mark - Métodos Picker




#pragma mark - UIImagePickerViewControllerDelegate métodos
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imagen = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (imagen) {
        CGFloat w = imagen.size.width;
        CGFloat h = imagen.size.height;

        CGFloat maxW = [[Definiciones sharedImagenAncho] floatValue];
        CGFloat maxH = [[Definiciones sharedImagenAlto] floatValue];
        
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            maxH /= [UIScreen mainScreen].scale;
            maxW /= [UIScreen mainScreen].scale;
        }
        
        if (w > maxW) {
            h *= (maxW / w);
            w = maxW;
        }
        if (h > maxH) {
            w *= (maxH / h);
            h = maxH;
        }
        
        
        UIImage *imagen2 = [Definiciones imagenDesdeImagen:imagen conNuevoTamano:CGSizeMake(w, h)];
        self.fotoParaAgregar = imagen2;
        
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            [self.cargando mostrar];
            NSData *imgData = UIImagePNGRepresentation(self.fotoParaAgregar);
            NSString *idElefante = [NSString stringWithFormat:@"%lld", [[self.detalleElefanteBlanco objectForKey:@"id"] longLongValue]];
            NSString *base64Img = [Definiciones base64DeData:imgData];
            NSDictionary *paraFoto = @{@"idElefante" : idElefante, @"imagen" : base64Img};
            
            if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
                [Servicios agregarFotoAElefante:paraFoto conBloque:^(BOOL agregado, NSError *error) {
                    if (error || !agregado) {
                        if (error.code >= 500) {
                            self.alerta.bandera = 0;
                            [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
                        } else {
                            self.alerta.bandera = 0;
                            [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
                        }
                    } else {
                        [self.alerta mostrarMensajeConLetrero:@"Está imagen pasará a un proceso de validación, el administrador se reserva el derecho de modificar, complementar o eliminar  total o parcialmente imágenes falsas,  de carácter ofensivo o agraviante."];
                    }
                    
                    [self.cargando ocultar];
                }];
            } else {
                self.miBloqueAgregar = ^(BOOL agregado, NSError *error) {
                    if (error || !agregado) {
                        if (error.code >= 500) {
                            self.alerta.bandera = 0;
                            [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
                        } else {
                            self.alerta.bandera = 0;
                            [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
                        }
                    } else {
                        [self.alerta mostrarMensajeConLetrero:@"Está imagen pasará a un proceso de validación, el administrador se reserva el derecho de modificar, complementar o eliminar  total o parcialmente imágenes falsas,  de carácter ofensivo o agraviante."];
                    }
                    
                    [self.cargando ocultar];
                };
                
                [self.miServicioConexion iniciarAgregarFotoElefante:paraFoto conBloque:self.miBloqueAgregar];
            }
        }];
    }
}






#pragma mark - ServiciosGeoLocalizacion métodos
- (void)recibirUbicacionGPS
{
    self.coordenadasUsuario = [ServiciosGeoLocalizacion sharedServiciosGeoLicalizacion].ultimaUbicacion;
}

- (void)recibirErrorGPS
{
    [self.alerta mostrarMensajeConLetrero:@"Para generar el reporte se debe activar el GPS del dispositivo"];
}





#pragma mark - Alerta métodos
- (void)alertaMensajeViewSeleccionaTerminar:(AlertaMensajeView *)vista
{
    if (vista.bandera == 10) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}




@end
