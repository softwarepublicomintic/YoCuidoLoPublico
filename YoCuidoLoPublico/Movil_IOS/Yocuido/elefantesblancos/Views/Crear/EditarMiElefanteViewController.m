//
//  DetalleElefanteBlancoViewController.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 2/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "EditarMiElefanteViewController.h"

#import "FotoDetalleView.h"
#import "Servicios.h"
#import "CargandoView.h"
#import "LectorLocalJson.h"


@interface EditarMiElefanteViewController ()

@property(assign) CGFloat contenedorY;
@property(strong) NSDictionary *detalleElefanteBlanco;

@property(assign) MasInformacionEstado tipoEstadoMasInfo;

@property(strong) CargandoView *cargando;
@property(strong) AlertaMensajeView *alerta;

@property(strong) NSMutableArray *razonesArray;
@property(strong) NSMutableArray *tiemposArray;

@property(assign) int fotoActual;
@property(strong) NSMutableArray *fotos;
@property(strong) NSMutableArray *fotosVistas;

@property(strong) NSDictionary *rangoTiempoElefante;
@property(strong) NSDictionary *razonElefante;

@property(assign) BOOL esElefanteMio;
@property(assign) CGFloat alturaContenidoScroller;

@property(strong) UIImage *fotoParaAgregar;

@property(strong) UIImage *iconoPendiente;
@property(strong) UIImage *iconoAprobado;
@property(strong) UIImage *iconoRechazado;

@property(strong) ServiciosConnection *miServicioConexion;
@property(assign) agregarFotoBloque miBloqueEditar;

@end

@implementation EditarMiElefanteViewController

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
@synthesize departamentoUbicacionLabel;
@synthesize nombreElefanteText;
@synthesize entidadTituloText;
@synthesize razonElefanteText;
@synthesize masInfoTituloLabel;
@synthesize masInfoView;
@synthesize notificacionesContenedor;
@synthesize notificacionesTituloLabel;
@synthesize notificacionesLabel;
@synthesize botonesContenedor;
@synthesize actualizarButton;
@synthesize estadisticasContenedor;
@synthesize cantidadSeparadorLabel;
@synthesize masInfoContenedor;
@synthesize accionesContenedor;
@synthesize accionesImage;
@synthesize razonesContenedor;
@synthesize razonesButton;
@synthesize razonesPicker;
@synthesize tiemposContenedor;
@synthesize tiemposButton;
@synthesize tiemposPicker;
@synthesize esAgregarFoto;
@synthesize estadoElefanteImage;
@synthesize estadoElefanteLabel;
@synthesize cerrarTecladoButton1;
@synthesize cerrarTecladoButton2;
@synthesize cerrarTecladoButtonsArray;

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
@synthesize razonesArray;
@synthesize tiemposArray;
@synthesize iconoPendiente;
@synthesize iconoAprobado;
@synthesize iconoRechazado;
@synthesize miServicioConexion;
@synthesize miBloqueEditar;


- (id)initEditarMiElefanteViewControllerParaElefante:(NSDictionary *)infoElefante estadoEdicion:(MasInformacionEstado)estadoEdicion esMiElefante:(BOOL)esMio
{
    NSString *nibName = @"";
    
    if (ES_IPAD) {
        nibName = @"EditarMiElefanteViewController";
    } else {
        nibName = @"EditarMiElefanteViewController";
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
    
    // Íconos
    self.iconoPendiente = [UIImage imageNamed:@"icono_pendiente.png"];
    self.iconoAprobado = [UIImage imageNamed:@"icono_aprobado.png"];
    self.iconoRechazado = [UIImage imageNamed:@"icono_rechazado"];


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
    
    self.miServicioConexion = [[ServiciosConnection alloc] init];

    self.cerrarTecladoButtonsArray = [NSArray arrayWithObjects:self.cerrarTecladoButton1,
                                      self.cerrarTecladoButton2,
                                      nil];
    for (UIButton *boton in self.cerrarTecladoButtonsArray) {
        boton.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)llenarCampos
{
    // Llenar campos
    long long idElefante = [[self.detalleElefanteBlanco objectForKey:@"id"] longLongValue];
    NSArray *fotosArray = [self.detalleElefanteBlanco objectForKey:@"miniaturas"];
    self.fotos = [NSMutableArray arrayWithArray:fotosArray];
    self.nombreElefanteLabel.text = [self.detalleElefanteBlanco objectForKey:@"titulo"];
    self.nombreElefanteText.text = [self.detalleElefanteBlanco objectForKey:@"titulo"];
    self.fechaElefanteLabel.text = [NSString stringWithFormat:@"Fecha de Reporte: %@", [self.detalleElefanteBlanco objectForKey:@"fechaReporte"]];
    int rechazos = [[self.detalleElefanteBlanco objectForKey:@"rechazos"] intValue];
    self.cantidadRechazosLabel.text = [NSString stringWithFormat:@"%d", rechazos];
    self.cantidadFotosLabel.text = [NSString stringWithFormat:@"%d", fotosArray.count];
    self.entidadTituloText.text = [self.detalleElefanteBlanco objectForKey:@"entidad"];
    
    int estadoElefante = [[self.detalleElefanteBlanco objectForKey:@"estado"] intValue];
    
    int municipio = [[self.detalleElefanteBlanco objectForKey:@"municipio"] intValue];
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
    [Servicios consultarRazonesDeElefantesConBloque:^(NSArray *razonesRespArray, NSError *error) {
        if (error) {
            if (error.code >= 500) {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
            } else {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
            }
        } else {
            if (razonesRespArray && razonesRespArray.count) {
                int idRazonEB = [[self.detalleElefanteBlanco objectForKey:@"idMotivo"] intValue];
                for (NSDictionary *razon in razonesRespArray) {
                    self.razonesArray = [NSMutableArray arrayWithArray:razonesRespArray];
                    
                    [self.razonesPicker reloadAllComponents];
                    
                    int idRazon = [[razon objectForKey:@"id"] intValue];
                    if (idRazon == idRazonEB) {
                        self.razonElefante = razon;
                        self.razonElefanteText.text = [self.razonElefante objectForKey:@"texto"];
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
    //    switch (self.tipoEstadoMasInfo) {
    //        case MasInformacionEstadoEdicion:
    //        {
    //            self.masInfoView = [MasInformacionView initMasInformacionViewParaEdicionConDatos:masInfoDatos];
    //            [self.accionesContenedor addSubview:self.agregarFotoContenedor];
    //            [self.rechazarContenedor removeFromSuperview];
    //        }
    //            break;
    //
    //        case MasInformacionEstadoDespliegueEditando:
    //        {
    //            self.masInfoView = [MasInformacionView initMasInformacionViewParaDespliegueEditandoConDatos:masInfoDatos];
    //            [self.accionesContenedor addSubview:self.agregarFotoContenedor];
    //            [self.rechazarContenedor removeFromSuperview];
    //        }
    //            break;
    //
    //        case MasInformacionEstadoDespliegue:
    //        {
    //            self.masInfoView = [MasInformacionView initMasInformacionViewParaDespliegueConDatos:masInfoDatos];
    //            [self.accionesContenedor addSubview:self.rechazarContenedor];
    //            [self.agregarFotoContenedor removeFromSuperview];
    //        }
    //            break;
    //
    //        default:
    //            break;
    //    }
    if (estadoElefante == ESTADO_ELEFANTE_NO_APROBADO) {
        self.masInfoView = [MasInformacionView initMasInformacionViewParaDespliegueConDatos:masInfoDatos];
        self.masInfoView.delegado = self;
    } else {
        self.masInfoView = [MasInformacionView initMasInformacionViewParaDespliegueEditandoConDatos:masInfoDatos];
        self.masInfoView.delegado = self;
    }
    
    //    if (self.tipoEstadoMasInfo == MasInformacionEstadoDespliegue) {
    //        [self.accionesContenedor addSubview:self.rechazarContenedor];
    //        [self.agregarFotoContenedor removeFromSuperview];
    //    } else if (self.tipoEstadoMasInfo == MasInformacionEstadoEdicion) {
    //        [self.accionesContenedor addSubview:self.agregarFotoContenedor];
    //        [self.rechazarContenedor removeFromSuperview];
    //    }
    
    
    if (self.masInfoView) {
        [self.masInfoContenedor addSubview:self.masInfoView];
    }
    
    if (self.esElefanteMio && estadoElefante != ESTADO_ELEFANTE_NO_APROBADO) {
        self.masInfoView.tiempoDespliegueText.hidden = NO;
        self.masInfoView.costoDespliegueText.hidden = NO;
        self.masInfoView.contratistaDespliegueText.hidden = NO;
        self.masInfoView.tiempoLabel.hidden = YES;
        self.masInfoView.costoLabel.hidden = YES;
        self.masInfoView.contratistaLabel.hidden = YES;
        self.notificacionesContenedor.hidden = NO;
    } else {
        self.notificacionesContenedor.hidden = NO;
    }
    
    if (self.esElefanteMio && estadoElefante != ESTADO_ELEFANTE_PENDIENTE) {
        self.notificacionesContenedor.hidden = NO;
    } else {
        self.notificacionesContenedor.hidden = YES;
    }
    
    // Contenedor de notificaciones
    NSString *mensaje = [self.detalleElefanteBlanco objectForKey:@"comentario"];
    if ([mensaje isKindOfClass:[NSNull class]]) {
        mensaje = @" ";
    }
    NSString *razon = [self.detalleElefanteBlanco objectForKey:@"razon"];
    if (razon && [razon isKindOfClass:[NSString class]]) {
        mensaje = [NSString stringWithFormat:@"%@\r%@", mensaje, razon];
    }
    mensaje = [mensaje stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
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
    //self.notificacionesContenedor.frame = CGRectMake(0, y, 320, h);
    
    // Contenedor de botones
    if (self.notificacionesContenedor.hidden) {
        y = self.notificacionesContenedor.frame.origin.y;
    } else {
        y = self.notificacionesContenedor.frame.origin.y + self.notificacionesContenedor.frame.size.height + 6;
    }
    self.botonesContenedor.frame = CGRectMake(0, y, 320, self.botonesContenedor.frame.size.height);
    
    y = self.botonesContenedor.frame.origin.y + self.botonesContenedor.frame.size.height + 10;
    y = 840;
    self.contenidoScroller.contentSize = CGSizeMake(320, y);
    self.alturaContenidoScroller = y;
    
    if (!self.masInfoView.estaEditando) {
        self.botonesContenedor.hidden = YES;
    } else {
        self.botonesContenedor.hidden = NO;
    }
    
    // Contenedor de estadísticas
    if (estadoElefante == ESTADO_ELEFANTE_APROBADO) {  // diferente a estado aprobado
        self.estadisticasContenedor.hidden = NO;
        self.estadoElefanteImage.image = self.iconoAprobado;
        self.estadoElefanteLabel.text = TEXTO_APROBADO;
        self.nombreElefanteText.enabled = NO;
        self.entidadTituloText.enabled = NO;
        self.razonElefanteText.enabled = NO;
    }else if (estadoElefante == ESTADO_ELEFANTE_PENDIENTE) {
        self.estadisticasContenedor.hidden = NO;
        self.estadoElefanteImage.image = self.iconoPendiente;
        self.estadoElefanteLabel.text = TEXTO_PENDIENTE;
        self.actualizarButton.hidden = NO;
        self.nombreElefanteText.enabled = YES;
        self.entidadTituloText.enabled = YES;
        self.razonElefanteText.enabled = YES;
    } else {
        self.estadisticasContenedor.hidden = NO;
        self.estadoElefanteImage.image = self.iconoRechazado;
        self.estadoElefanteLabel.text = TEXTO_RECHAZADO;
        self.actualizarButton.hidden = YES;
        self.nombreElefanteText.enabled = NO;
        self.entidadTituloText.enabled = NO;
        self.razonElefanteText.enabled = NO;
    }
    
    self.alturaContenidoScroller = self.contenidoScroller.contentSize.height; // 690;
    
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
    [self cargarFotosVisibles];
    
    // Zona de acciones
    if (self.esElefanteMio) {
        self.botonesContenedor.hidden = NO;
    }
    
    if (estadoElefante == ESTADO_ELEFANTE_APROBADO) {
        if (estadoTiempo == 1 && estadoCosto == 1 && estadoContratista == 1) {
            self.botonesContenedor.hidden = YES;
        }
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
}


- (IBAction)irAtras:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
                NSString *imgBase64 = imagenBase64;
                NSData *imgData = [NSData dataFromBase64String:imgBase64];
                if (imgData) {
                    UIImage *imagenVw = [UIImage imageWithData:imgData];
                    FotoDetalleView *fotoDetalle = [[FotoDetalleView alloc] initParaFoto:imagenVw sobreVistaPadre:self.view];
                    [fotoDetalle mostrar];
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
        }
        
        [self.cargando ocultar];
    }];
}


- (IBAction)irAAgregarFoto:(id)sender
{
    UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
    pickerView.delegate = self;
    pickerView.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
    pickerView.allowsEditing = NO;
    pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerView.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    [self.navigationController presentViewController:pickerView animated:YES completion:^{
    }];
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
    
    int motivo = [[self.razonElefante objectForKey:@"id"] intValue];
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
                        self.alerta.bandera = 0;
                        [self.alerta mostrarMensajeConLetrero:@"Esta información pasará a un proceso de validación, el administrador se reserva el derecho de modificar, complementar o eliminar total o parcialmente la información falsa,  de carácter ofensivo o agraviante."];
                    }
                }];
            }
            
            [self.cargando ocultar];
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
    
    CGFloat y = self.masInfoView.frame.origin.y + (self.masInfoView.frame.size.height * 1.7)  + ALTURA_TECLADO;
    CGRect rect = CGRectMake(0, y, 320, self.masInfoView.frame.size.height);
    [self.contenidoScroller scrollRectToVisible:rect animated:YES];
    
}

- (void)masInformacionViewTerminaEditar:(MasInformacionView *)vista
{
    self.contenidoScroller.contentSize = CGSizeMake(self.contenidoScroller.frame.size.width, self.alturaContenidoScroller);
    [self.contenidoScroller scrollRectToVisible:CGRectMake(0, 0, 320, 2) animated:YES];
    
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


- (IBAction)irASeleccionarTiempo:(id)sender
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.tiemposContenedor.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                     }];
}


- (IBAction)irACancelarRazon:(id)sender
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
                     }];
}

- (IBAction)irACancelarTiempo:(id)sender
{
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


- (IBAction)irACerrarTeclados:(id)sender
{
    [self allResignResponder];
}



#pragma mark - UITextFieldDelegate métodos
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    for (UIButton *boton in self.cerrarTecladoButtonsArray) {
        boton.hidden = NO;
    }
    
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
    
    [self allResignResponder];
    return NO;

    /*if (textField == self.razonElefanteText) {
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
        [self allResignResponder];
        return NO;
    } else {
        self.contenidoScroller.contentSize = CGSizeMake(self.contenidoScroller.frame.size.width, self.alturaContenidoScroller + ALTURA_TECLADO);
        
        CGFloat y = textField.frame.origin.y + textField.frame.size.height + ALTURA_TECLADO;
        CGRect rect = CGRectMake(0, y, 320, textField.frame.size.height);
        [self.contenidoScroller scrollRectToVisible:rect animated:YES];
        
        return YES;
    }*/
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self allResignResponder];
    
    return YES;
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



#pragma mark - UIPickerVideDelegate métodos
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.razonesPicker) {
        if (self.razonesArray) {
            return self.razonesArray.count;
        } else {
            return 0;
        }
    } else if (pickerView == self.tiemposPicker) {
        if (self.tiemposArray) {
            return self.tiemposArray.count;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *itemsArray = nil;
    if (pickerView == self.razonesPicker) {
        itemsArray = self.razonesArray;
    } else if (pickerView == self.tiemposPicker) {
        itemsArray = self.tiemposArray;
    }
    
    if (itemsArray && itemsArray.count) {
        NSDictionary *item = [itemsArray objectAtIndex:row];
        NSString *nombre = [item objectForKey:@"texto"];
        return nombre;
    } else {
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
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"Está imagen pasará a un proceso de validación, el administrador se reserva el derecho de modificar, complementar o eliminar  total o parcialmente imágenes falsas,  de carácter ofensivo o agraviante."];
                }
                
                [self.cargando ocultar];
            }];
        }];
    }
}



#pragma mark - Alerta métodos
- (void)alertaMensajeViewSeleccionaTerminar:(AlertaMensajeView *)vista
{
    if (vista.bandera == 10) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}




@end
