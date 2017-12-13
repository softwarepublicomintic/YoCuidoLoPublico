//
//  CrearElefanteViewController.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 14/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "CrearElefanteViewController.h"

#import "Servicios.h"

#import "MapaElefantesViewController.h"
#import "CargandoView.h"
#import "ServiciosGeoLocalizacion.h"
#import "LectorLocalJson.h"


@interface CrearElefanteViewController ()

@property(assign) CGFloat contenedorY;

@property(strong) NSMutableArray *razonesArray;
@property(strong) NSMutableArray *tiemposArray;

@property(strong) UIImage *foto;

@property(strong) CargandoView *cargando;
@property(strong) AlertaMensajeView *alerta;

@property(strong) NSDictionary *razonUsuario;
@property(strong) NSDictionary *tiempoUsuario;

@property(strong) NSDictionary *municipioUsuario;

@property(assign) CLLocationCoordinate2D coordenadasUsuario;

@property(strong) ServiciosConnection *miServicioConexion;
@property(assign) crearBloque miBloqueCreacion;

@end

@implementation CrearElefanteViewController

@synthesize contenedorTotal;
@synthesize imagenFondo;
@synthesize atrasButton;
@synthesize barraSuperiorImage;
@synthesize superiorContenedor;
@synthesize elefanteBlancoLabel;
@synthesize nombreElefanteLabel;
@synthesize contenidoScroller;
@synthesize requeridosLabel;
@synthesize asterisco1Label;
@synthesize asterisco2Label;
@synthesize asterisco3Label;
@synthesize asterisco4Label;
@synthesize nombreText;
@synthesize entidadText;
@synthesize razonText;
@synthesize masInformacionLabel;
@synthesize tiempoText;
@synthesize costoText;
@synthesize contratistaText;
@synthesize reportarButton;
@synthesize razonesContenedor;
@synthesize razonesButton;
@synthesize razonesPicker;
@synthesize tiemposContenedor;
@synthesize tiemposButton;
@synthesize tiemposPicker;
@synthesize departamentoLabel;
@synthesize cancelarRazonButton;
@synthesize cancelarTiempoButton;
@synthesize cerrarTecladoButton1;
@synthesize cerrarTecladoButton2;
@synthesize cerrarTecladoButton3;
@synthesize cerrarTecladoButton4;
@synthesize cerrarTecladoButtonsArray;

@synthesize contenedorY;
@synthesize cargando;
@synthesize razonesArray;
@synthesize tiemposArray;
@synthesize foto;
@synthesize razonUsuario;
@synthesize tiempoUsuario;
@synthesize alerta;
@synthesize municipioUsuario;
@synthesize coordenadasUsuario;

@synthesize miServicioConexion;
@synthesize miBloqueCreacion;


- (id)initCrearElefanteViewControllerConFoto:(UIImage *)nuevaFoto
{
    NSString *nibName = @"";
    
    if (ES_IPAD) {
        nibName = @"CrearElefanteViewController";
    } else {
        nibName = @"CrearElefanteViewController";
    }
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        if (ES_IPHONE_5) {
            self.contenedorY = 86;
        } else {
            self.contenedorY = 86;
        }
        
        self.foto = nuevaFoto;
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
    
    self.nombreText.delegate = self;
    self.entidadText.delegate = self;
    self.razonText.delegate = self;
    self.tiempoText.delegate = self;
    self.costoText.delegate = self;
    self.contratistaText.delegate = self;
    
    self.contenidoScroller.delegate = self;
    
    self.razonesPicker.dataSource = self;
    self.razonesPicker.delegate = self;
    self.tiemposPicker.dataSource = self;
    self.tiemposPicker.delegate = self;
    
    // Vista de Cargando
    self.cargando = [CargandoView initCargandoView];
    [self.view addSubview:self.cargando];
    [self.cargando ocultarSinAnimacion];
    
    // Alerta y Mensajes
    self.alerta = [AlertaMensajeView initAlertaMensajeViewConDelegado:self];
    [self.view addSubview:self.alerta];
    self.alerta.hidden = YES;
    [self.view sendSubviewToBack:self.alerta];
    
    
    // Fondo Botones
    UIImage *botonRojoRaw = [UIImage imageNamed:@"boton_rojo1.png"];
    UIEdgeInsets botonRojoEdges;
    botonRojoEdges.top = 12;
    botonRojoEdges.bottom = 24;
    botonRojoEdges.left = 18;
    botonRojoEdges.right = 18;
    UIImage *botonRojoImg = [botonRojoRaw resizableImageWithCapInsets:botonRojoEdges resizingMode:UIImageResizingModeTile];
    [self.reportarButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    [self.razonesButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    [self.tiemposButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    [self.cancelarRazonButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    [self.cancelarTiempoButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    
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
                self.razonesArray = [NSMutableArray arrayWithArray:razonesRespArray];
                
                [self.razonesPicker reloadAllComponents];
            }
        }
    }];
    
    
    if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
        self.superiorContenedor.frame = CGRectMake(0, 20, self.superiorContenedor.frame.size.width, self.superiorContenedor.frame.size.height);
    } else {
        self.superiorContenedor.frame = CGRectMake(0, 0, self.superiorContenedor.frame.size.width, self.superiorContenedor.frame.size.height);
    }
    
    self.contenidoScroller.contentSize = CGSizeMake(self.contenidoScroller.frame.size.width, 520);

    // Matricularse para estar pendiende de la ubicación
    AGREGAR_OBSERVADOR_UBICACION(self, @selector(recibirUbicacionGPS));
    AGREGAR_OBSERVADOR_ERROR_UBICACION(self, @selector(recibirErrorGPS));
    [[ServiciosGeoLocalizacion sharedServiciosGeoLicalizacion] iniciarUbicacionGPS];
    
    self.miServicioConexion = [[ServiciosConnection alloc] init];
    
    self.cerrarTecladoButtonsArray = [NSArray arrayWithObjects:self.cerrarTecladoButton1,
                                      self.cerrarTecladoButton2,
                                      self.cerrarTecladoButton3,
                                      self.cerrarTecladoButton4,
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


- (IBAction)irAtras:(id)sender
{
    REMOVER_OBERVADOR_UBICACION(self);
    [self allResignResponder];
    MapaElefantesViewController *mapaAtras = nil;
    for (UIViewController *view in self.navigationController.viewControllers) {
        if ([view isKindOfClass:[MapaElefantesViewController class]]) {
            mapaAtras = (MapaElefantesViewController *)view;
        }
    }
    if (!mapaAtras) {
        mapaAtras = [[MapaElefantesViewController alloc] initMapaElefantesViewControllerReportando];
        [self.navigationController pushViewController:mapaAtras animated:YES];
    } else {
        [self.navigationController popToViewController:mapaAtras animated:YES];
    }
    

}


- (IBAction)irAReportar:(id)sender
{
    NSString *nombreStr = [self.nombreText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *entidadStr = [self.entidadText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *razonStr = [self.razonText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
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
        
        return;
    }
 
    [self.cargando ocultar];
    
   self.alerta.bandera = 1;
    [self.alerta mostrarMensajeConLetrero:@"La imagen e información enviada pasarán a un proceso de validación, el administrador se reserva el derecho de modificar, complementar, eliminar total o parcialmente y no publicar la información falsa, de carácter ofensivo o agraviante. Este reporte no constituye una denuncia, puede interponer su denuncia completa en www.contraloriagen.gov.co y www.procuraduria.gov.co"];
}



- (void)enviarDatosParaRegistro
{
    NSString *nombreStr = [self.nombreText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *entidadStr = [self.entidadText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    [self.cargando mostrar];
    
    // Si están todos los campos requeridos, crear reporte
    NSString *costoStr = [self.costoText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    double cs = [costoStr doubleValue];
    NSNumber *costoNumb = [NSNumber numberWithDouble:cs];
    
    NSString *contratistaStr = [self.contratistaText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!contratistaStr) {
        contratistaStr = @"";
    }
    
    NSObject *idTiempo = [NSNumber numberWithInt:0];
    if (self.tiempoUsuario) {
        int idT = [[self.tiempoUsuario objectForKey:@"id"] intValue];
        if (idT) {
            idTiempo = [NSNumber numberWithInt:idT];
        } else {
            idTiempo = [NSNumber numberWithInt:0];
        }
    }
    NSNumber *idRazon = [NSNumber numberWithInt:0];
    if (self.razonUsuario) {
        int idR = [[self.razonUsuario objectForKey:@"id"] intValue];
        idRazon = [NSNumber numberWithInt:idR];
    }
    
    int idMunicipio = [[self.municipioUsuario objectForKey:@"codigo"] intValue];
    int idDepto = idMunicipio / 1000;
    int idMunic = idMunicipio - (idDepto * 1000);
    
    NSData *imagenData = UIImagePNGRepresentation(self.foto);
    NSString *base64 = [Definiciones base64DeData:imagenData];

    NSString *idMunicTempStr = [NSString stringWithFormat:@"%d", idMunicipio];
    NSRange rango;
    rango.location = 0;
    rango.length = 2;
    //NSString *idDeptoStr = [idMunicTempStr substringWithRange:rango];
    
    NSString *idDeptoStr = @"11";
    rango.location = 0;
    rango.length = 5;
    //NSString *idMunicStr = [idMunicTempStr substringWithRange:rango];
    NSString *idMunicStr = @"11001";
    idMunicStr = [NSString stringWithFormat:@"%@", idMunicStr];
    idDeptoStr = [NSString stringWithFormat:@"%@", idDeptoStr];
    
    NSString *lat = [NSString stringWithFormat:@"%f", self.coordenadasUsuario.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f", self.coordenadasUsuario.longitude];
    
    NSDictionary *ubicacinJson = @{@"latitud" : lat, @"longitud" : lon};
    
    NSDictionary *nuevoElefante = @{@"idDepartamento" : idDeptoStr,
                                    @"idMunicipio" : idMunicStr,
                                    @"posicion" : ubicacinJson,
                                    @"imagen" : base64,
                                    @"entidad" : entidadStr,
                                    @"idRangoTiempo" : idTiempo,
                                    @"titulo" : nombreStr,
                                    @"idMotivo" : idRazon,
                                    @"costo" : costoNumb,
                                    @"contratista" : contratistaStr};
    
//    NSError *error = nil;
//    NSData *json = [NSJSONSerialization dataWithJSONObject:nuevoElefante options:NSJSONWritingPrettyPrinted error:&error];
//    if (!error) {
//        NSString *jsonStr = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
//        NSLog(@"DEBUG::CrearElefante JSON:\r%@", jsonStr);
//    }
    
    
    if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
        [Servicios crearElefanteConDiccionario:nuevoElefante conBloque:^(NSDictionary *elefanteDic, NSError *error) {
            [self.cargando ocultar];
            
            if (error) {
                if (error.code >= 500) {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
                } else {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
                }
                
                return;
            } else if (elefanteDic) {
                NSLog(@"elefante guardado: %@", elefanteDic);
                long long idE = [[elefanteDic objectForKey:@"id"] longLongValue];
                NSString *idElefante = [NSString stringWithFormat:@"%lld", idE];
                NSString *usuarioMisElefantes = GET_USERDEFAULTS(USUARIO_MIS_ELEFANTES);
                if (!usuarioMisElefantes || [usuarioMisElefantes isEqualToString:@""]) {
                    usuarioMisElefantes = idElefante;
                } else {
                    usuarioMisElefantes = [NSString stringWithFormat:@"%@|%@", usuarioMisElefantes, idElefante];
                }
                SET_USERDEFAULTS(USUARIO_MIS_ELEFANTES, usuarioMisElefantes);
                SYNC_USERDEFAULTS;
                
                [self irAtras:self.atrasButton];
            }
        }];
    } else {
        self.miBloqueCreacion = ^(NSDictionary *elefanteDic, NSError *error) {
            [self.cargando ocultar];
            
            if (error) {
                if (error.code >= 500) {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
                } else {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
                }
                
                return;
            } else if (elefanteDic) {
                NSLog(@"elefante guardado: %@", elefanteDic);
                long long idE = [[elefanteDic objectForKey:@"id"] longLongValue];
                NSString *idElefante = [NSString stringWithFormat:@"%lld", idE];
                NSString *usuarioMisElefantes = GET_USERDEFAULTS(USUARIO_MIS_ELEFANTES);
                if (!usuarioMisElefantes || [usuarioMisElefantes isEqualToString:@""]) {
                    usuarioMisElefantes = idElefante;
                } else {
                    usuarioMisElefantes = [NSString stringWithFormat:@"%@|%@", usuarioMisElefantes, idElefante];
                }
                SET_USERDEFAULTS(USUARIO_MIS_ELEFANTES, usuarioMisElefantes);
                SYNC_USERDEFAULTS;
                
                [self irAtras:self.atrasButton];
            }
        };
        
        [self.miServicioConexion iniciarCrearElefante:nuevoElefante conBloque:self.miBloqueCreacion];
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
                         
                         self.razonUsuario = itemDic;
                         
                         self.razonText.text = [itemDic objectForKey:@"texto"];
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
                         [self.view sendSubviewToBack:self.tiemposContenedor];
                         self.tiemposContenedor.hidden = YES;
                         
                         int i = [self.tiemposPicker selectedRowInComponent:0];
                         NSDictionary *itemDic = [self.tiemposArray objectAtIndex:i];
                         
                         self.tiempoUsuario = itemDic;
                         
                         self.tiempoText.text = [itemDic objectForKey:@"texto"];
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

    if (textField == self.razonText) {
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
    } else if (textField == self.tiempoText) {
        self.tiemposContenedor.hidden = NO;
        [self.view bringSubviewToFront:self.tiemposContenedor];
        [UIView animateWithDuration:0.3
                              delay:0
                            options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                         animations:^{
                             self.tiemposContenedor.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                         }];
        [self allResignResponder];
        return NO;
    } else {
        self.contenidoScroller.contentSize = CGSizeMake(self.contenidoScroller.frame.size.width, 520 + ALTURA_TECLADO);
        
        CGFloat y = textField.frame.origin.y + textField.frame.size.height + ALTURA_TECLADO;
        CGRect rect = CGRectMake(0, y, 320, textField.frame.size.height);
        [self.contenidoScroller scrollRectToVisible:rect animated:YES];
        
        return YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.nombreText) {
        if ((textField.text.length + string.length) > 80) {
            return NO;
        }
        BOOL validar = [Definiciones validarCadenaCaracteresValidos:string];
        return validar;
    } else if (textField == self.entidadText) {
        if ((textField.text.length + string.length) > 80) {
            return NO;
        }
        BOOL validar = [Definiciones validarCadenaCaracteresValidos:string];
        return validar;
    } else if (textField == self.contratistaText) {
        if ((textField.text.length + string.length) > 255) {
            return NO;
        }
        BOOL validar = [Definiciones validarCadenaCaracteresValidos:string];
        return validar;
    } else if (textField == self.costoText) {
        if ((textField.text.length + string.length) > 20) {
            return NO;
        }
        BOOL validar = [Definiciones validarCadenaNumerica:string];
        return validar;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.contenidoScroller.contentSize = CGSizeMake(self.contenidoScroller.frame.size.width, 520);
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
    [self.nombreText resignFirstResponder];
    [self.entidadText resignFirstResponder];
    [self.razonText resignFirstResponder];
    [self.tiempoText resignFirstResponder];
    [self.costoText resignFirstResponder];
    [self.contratistaText resignFirstResponder];

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



#pragma mark - AlertaMensajeViewDelegate métodos
- (void)alertaMensajeViewSeleccionaTerminar:(AlertaMensajeView *)vista
{
    if (vista.bandera == 1) {
        // Esto por ahora no va hasta que se implemente la VUD
//        [self.alerta mostrarAlertaConLetrero:@"¿Desea denunciar el Elefante Blanco? De ser así, usted será direccionado a la ventanilla Unificada de Denuncias VUD. Allí se le solicitará información adicional relacionada con la denuncia. ¿Desea continuar?"];
        
        // Por ahora lanzamos inmediatamente el proceso de envío de datos de nuevo elefante
        [self enviarDatosParaRegistro];
    }
}

- (void)alertaMensajeViewSeleccionaNo:(AlertaMensajeView *)vista
{
    
}

- (void)alertaMensajeViewSeleccionaSi:(AlertaMensajeView *)vista
{
    [self enviarDatosParaRegistro];
}



#pragma mark - ServiciosGeoLocalizacion métodos
- (void)recibirUbicacionGPS
{
    self.coordenadasUsuario = [ServiciosGeoLocalizacion sharedServiciosGeoLicalizacion].ultimaUbicacion;
    [ServiciosGeoLocalizacion obtenerDireccionParaCoordenadas:self.coordenadasUsuario conBloque:^(NSDictionary *ubicacionRespuesta, NSError *error) {
        if (error) {
            self.alerta.bandera = 0;
            [self.alerta mostrarMensajeConLetrero:@"Los servicios de geolocalización no están disponibles en este momento. Por favor intente más tarde."];
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
                    self.municipioUsuario = item;
                    break;
                }
            }
            
            self.departamentoLabel.text = [NSString stringWithFormat:@"%@ / %@", deptoStr, municStr];
        }
    }];
}

- (void)recibirErrorGPS
{
    [self.alerta mostrarMensajeConLetrero:@"Para generar el reporte se debe activar el GPS del dispositivo"];
}





@end
