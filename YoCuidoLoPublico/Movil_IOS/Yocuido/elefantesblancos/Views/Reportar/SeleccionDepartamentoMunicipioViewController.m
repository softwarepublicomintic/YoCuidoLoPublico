//
//  SeleccionDepartamentoMunicipioViewController.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 27/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "SeleccionDepartamentoMunicipioViewController.h"

#import "MapaElefantesViewController.h"
#import "CargandoView.h"

#import "LectorLocalJson.h"
#import "Servicios.h"
#import "ServiciosGeoLocalizacion.h"


@interface SeleccionDepartamentoMunicipioViewController ()

@property(assign) CGFloat contenedorY;
@property(assign) NSArray *listaDepartamentos;
@property(strong) NSString *nombreRegion;

@property(strong) NSMutableArray *departamentosArray;
@property(strong) NSMutableArray *ciudadesArray;

@property(strong) CargandoView *cargando;
@property(strong) AlertaMensajeView *alerta;

@property(strong) NSDictionary *deptoSeleccionado;
@property(strong) NSDictionary *municSeleccionado;

@end

@implementation SeleccionDepartamentoMunicipioViewController

@synthesize contenedorTotal;
@synthesize imagenFondo;
@synthesize atrasButton;
@synthesize datosContenedor;
@synthesize barraSuperiorImage;
@synthesize superiorContenedor;
@synthesize elefantesBlancosLabel;
@synthesize regionLabel;
@synthesize mensajeLabel;
@synthesize departamentoText;
@synthesize municipioText;
@synthesize departamentosContenedor;
@synthesize departamentoPicker;
@synthesize seleccionarDepartamentoButton;
@synthesize municipiosContenedor;
@synthesize municipioPicker;
@synthesize seleccionarMunicipioButton;
@synthesize cancelarDepartamentoButton;
@synthesize cancelarMunicipioButton;

@synthesize contenedorY;
@synthesize cargando;
@synthesize nombreRegion;
@synthesize alerta;
@synthesize listaDepartamentos;
@synthesize departamentosArray;
@synthesize ciudadesArray;
@synthesize deptoSeleccionado;
@synthesize municSeleccionado;


- (id)initSeleccionDepartamentoMunicipioViewControllerParaRegion:(NSArray *)deptos nombreRegion:(NSString *)nuevaRegion
{
    NSString *nibName = @"";
    
    if (ES_IPAD) {
        nibName = @"SeleccionDepartamentoMunicipioViewController";
    } else {
        nibName = @"SeleccionDepartamentoMunicipioViewController";
    }
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        
        if (ES_IPHONE_5) {
            self.contenedorY = 132;
        } else {
            self.contenedorY = 86;
        }

        self.listaDepartamentos = deptos;
        self.nombreRegion = nuevaRegion;
        
        self.departamentosArray = [[NSMutableArray alloc] init];
        
        NSArray *deptosTotal = [LectorLocalJson obtenerElementosJsonDeArchivo:@"departamentos"];
        for (NSString *listaDepto in self.listaDepartamentos) {
            int idDeptoLista = [listaDepto intValue];
            for (NSDictionary *item in deptosTotal) {
                int itemIdDepto = [[item objectForKey:@"codigo"] intValue];
                if (itemIdDepto == idDeptoLista) {
                    [self.departamentosArray addObject:item];
                    break;
                }
            }
            
        }
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
        self.datosContenedor.frame = CGRectMake(0, self.contenedorY, self.datosContenedor.frame.size.width, self.datosContenedor.frame.size.height);
    }
    
    if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
        self.superiorContenedor.frame = CGRectMake(0, 20, self.superiorContenedor.frame.size.width, self.superiorContenedor.frame.size.height);
    } else {
        self.superiorContenedor.frame = CGRectMake(0, 0, self.superiorContenedor.frame.size.width, self.superiorContenedor.frame.size.height);
    }

    UIImage *botonRojoRaw = [UIImage imageNamed:@"boton_rojo1.png"];
    UIEdgeInsets botonRojoEdges;
    botonRojoEdges.top = 12;
    botonRojoEdges.bottom = 24;
    botonRojoEdges.left = 18;
    botonRojoEdges.right = 18;
    UIImage *botonRojoImg = [botonRojoRaw resizableImageWithCapInsets:botonRojoEdges resizingMode:UIImageResizingModeTile];
    [self.consultarButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    [self.seleccionarDepartamentoButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    [self.seleccionarMunicipioButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    [self.cancelarDepartamentoButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    [self.cancelarMunicipioButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    
    self.departamentoText.delegate = self;
    self.municipioText.delegate = self;
    
    self.departamentoPicker.delegate = self;
    self.departamentoPicker.dataSource = self;
    self.municipioPicker.delegate = self;
    self.municipioPicker.dataSource = self;
    
    self.deptoSeleccionado = nil;
    self.municSeleccionado = nil;
    
    [self.departamentoPicker reloadAllComponents];

    [self.view sendSubviewToBack:self.departamentosContenedor];
    self.departamentosContenedor.hidden = YES;
    self.departamentosContenedor.alpha = 0;
    [self.view sendSubviewToBack:self.municipiosContenedor];
    self.municipiosContenedor.hidden = YES;
    self.municipiosContenedor.alpha = 0;
    
    self.regionLabel.text = [NSString stringWithFormat:@"Región %@", self.nombreRegion];
    
    // Vista de Cargando
    self.cargando = [CargandoView initCargandoView];
    [self.view addSubview:self.cargando];
    [self.cargando ocultarSinAnimacion];

    // Alerta y Mensajes
    self.alerta = [AlertaMensajeView initAlertaMensajeViewConDelegado:self];
    [self.view addSubview:self.alerta];
    self.alerta.hidden = YES;
    [self.view sendSubviewToBack:self.alerta];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)irAtras:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)irAConsultar:(id)sender
{
    if (self.deptoSeleccionado && self.municSeleccionado) {
        [self.cargando mostrar];
        
        NSString *codMunic = [self.municSeleccionado objectForKey:@"codigo"];
        
        [Servicios consultarElefantesPorCodigoMunicipio:codMunic conBloque:^(NSArray *elefantesArray, NSError *error) {
            if (error || !elefantesArray || !elefantesArray.count) {
                if (error.code >= 500) {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
                } else {
                    self.alerta.bandera = 0;
                    [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
                }
            } else {
                CGFloat municLat = [[self.municSeleccionado objectForKey:@"latitud"] floatValue];
                CGFloat municLon = [[self.municSeleccionado objectForKey:@"longitud"] floatValue];
                MapaElefantesViewController *mapaVC = [[MapaElefantesViewController alloc] initMapaElefantesViewControllerConElefantes:elefantesArray municipioLatitud:municLat municipioLongitud:municLon];
                [self.navigationController pushViewController:mapaVC animated:YES];
            }
            
            [self.cargando ocultar];
        }];
    }
    
}


- (void)cargarMunicipiosDeDepartamento:(int)depto
{
    
    [self.cargando mostrar];
    
    [self.ciudadesArray removeAllObjects];
    self.ciudadesArray = nil;
    self.ciudadesArray = [[NSMutableArray alloc] init];
    
    self.municipioText.text = @"";
    
    [Servicios consultarMunicipiosPorDepartamento:depto conBloque:^(NSArray *municipiosArray, NSError *error) {
        if (error) {
            if (error.code >= 500) {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
            } else {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
            }
        } else if (municipiosArray && municipiosArray.count) {
            
            NSArray *municipiosTotal = [LectorLocalJson obtenerElementosJsonDeArchivo:@"municipios"];
            
            for (NSDictionary *municDic in municipiosArray) {
                NSString *municStr = [municDic objectForKey:@"municipio"];
                int idMunic = [municStr intValue];
                
                for (NSDictionary *item in municipiosTotal) {
                    int idMunicipio = [[item objectForKey:@"codigo"] intValue];
                    if (idMunicipio == idMunic) {
                        NSDictionary *posicion = [municDic objectForKey:@"posicion"];
                        NSMutableDictionary *itemMunic = [NSMutableDictionary dictionaryWithDictionary:item];
                        [itemMunic setValue:[posicion objectForKey:@"latitud"] forKey:@"latitud"];
                        [itemMunic setValue:[posicion objectForKey:@"longitud"] forKey:@"longitud"];
                        [self.ciudadesArray addObject:itemMunic];
                        break;
                    }
                }
            }
        }

        [self.municipioPicker reloadAllComponents];
        self.municSeleccionado = nil;
        
        [self.cargando ocultar];
    }];
    
}


- (IBAction)irASeleccionarDepartamento:(id)sender
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.departamentosContenedor.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.view sendSubviewToBack:self.departamentosContenedor];
                         self.departamentosContenedor.hidden = YES;
                         
                         if (self.departamentosArray && self.departamentosArray.count) {
                             int i = [self.departamentoPicker selectedRowInComponent:0];
                             NSDictionary *deptoDic = [self.departamentosArray objectAtIndex:i];
                             
                             int idDepto = [[deptoDic objectForKey:@"codigo"] intValue];
                             [self cargarMunicipiosDeDepartamento:idDepto];
                             
                             self.deptoSeleccionado = deptoDic;
                             
                             self.departamentoText.text = [deptoDic objectForKey:@"nombre"];
                         }
                     }];
}

- (IBAction)irASeleccionarMunicipio:(id)sender
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.municipiosContenedor.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.view sendSubviewToBack:self.municipiosContenedor];
                         self.municipiosContenedor.hidden = YES;
                         
                         if (self.ciudadesArray && self.ciudadesArray.count) {
                             int i = [self.municipioPicker selectedRowInComponent:0];
                             NSDictionary *muniDic = [self.ciudadesArray objectAtIndex:i];
                             NSLog(@"lista municuipios %@", muniDic);
                             self.municSeleccionado = muniDic;
                             self.municipioText.text = [muniDic objectForKey:@"nombre"];
                         }
                     }];
}



- (IBAction)irACancelarDepartamento:(id)sender
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.departamentosContenedor.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.view sendSubviewToBack:self.departamentosContenedor];
                         self.departamentosContenedor.hidden = YES;
                     }];
}

- (IBAction)irACancelarMunicipio:(id)sender
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.municipiosContenedor.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.view sendSubviewToBack:self.municipiosContenedor];
                         self.municipiosContenedor.hidden = YES;
                     }];
}





#pragma mark - UIPickerVideDelegate métodos
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.departamentoPicker) {
        if (self.departamentosArray) {
            return self.departamentosArray.count;
        } else {
            return 0;
        }
    } else if (pickerView == self.municipioPicker) {
        if (self.ciudadesArray) {
            return self.ciudadesArray.count;
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
    if (pickerView == self.departamentoPicker) {
        itemsArray = self.departamentosArray;
    } else if (pickerView == self.municipioPicker) {
        itemsArray = self.ciudadesArray;
    }
    
    if (itemsArray && itemsArray.count) {
        NSDictionary *item = [itemsArray objectAtIndex:row];
        NSString *nombre = [item objectForKey:@"nombre"];
        return nombre;
    } else {
        return @"";
    }
}



#pragma mark - UITextFieldDelegate métodos
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.departamentoText) {
        self.departamentosContenedor.hidden = NO;
        [self.view bringSubviewToFront:self.departamentosContenedor];
        [UIView animateWithDuration:0.3
                              delay:0
                            options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                         animations:^{
                             self.departamentosContenedor.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                         }];
    } else if (textField == self.municipioText) {
        self.municipiosContenedor.hidden = NO;
        [self.view bringSubviewToFront:self.municipiosContenedor];
        [UIView animateWithDuration:0.3
                              delay:0
                            options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                         animations:^{
                             self.municipiosContenedor.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                         }];
    }
    
    return NO;
}




@end
