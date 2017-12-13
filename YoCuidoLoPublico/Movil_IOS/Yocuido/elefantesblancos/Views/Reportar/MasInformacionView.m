//
//  MasInformacionView.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 2/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "MasInformacionView.h"

#import "Servicios.h"


@interface MasInformacionView()

@property(strong) NSDictionary *datos;

@property(strong) NSArray *tiemposArray;

- (void)iniciarVistaParaEdicionConDatos:(NSDictionary *)nuevosDatos;
- (void)iniciarVistaParaDespliegueEditandoConDatos:(NSDictionary *)nuevosDatos;
- (void)iniciarVistaParaDespliegueConDatos:(NSDictionary *)nuevosDatos;

- (void)obtenerTiempoConIDTiempo:(int)idTiempo;

@end

@implementation MasInformacionView

@synthesize edicionView;
@synthesize tiempoText;
@synthesize costoText;
@synthesize contratistaText;

@synthesize despliegueView;
@synthesize tiempoTituloLabel;
@synthesize tiempoLabel;
@synthesize tiempoDespliegueText;
@synthesize costoTituloLabel;
@synthesize costoLabel;
@synthesize costoDespliegueText;
@synthesize contratistaTituloLabel;
@synthesize contratistaLabel;
@synthesize contratistaDespliegueText;

@synthesize pickerContenedor;
@synthesize picker;
@synthesize seleccionarButton;
@synthesize cancelarSeleccionButton;
@synthesize desplegarTiempoFlechaImage;
@synthesize tiempoFlechaImage;
@synthesize yaNoEsElefanteLabel;
@synthesize yaNoEsElefanteDespliegueLabel;

@synthesize delegado;
@synthesize tiempoSeleccionado;

@synthesize tamanoOriginal;

@synthesize datos;
@synthesize tiemposArray;
@synthesize estaEditando;
@synthesize tiempoDesplegable;


+ (MasInformacionView *)initMasInformacionViewParaEdicionConDatos:(NSDictionary *)nuevosDatos
{
    NSString *nibName = nil;
    if (ES_IPAD) {
        nibName = @"MasInformacionView";
    } else {
        nibName = @"MasInformacionView";
    }
    
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    if (xibsArray && xibsArray.count) {
        MasInformacionView *view = [xibsArray objectAtIndex:0];
        
        [view iniciarVistaParaEdicionConDatos:nuevosDatos];
        
        return view;
    }
    
    return nil;
}

+ (MasInformacionView *)initMasInformacionViewParaDespliegueEditandoConDatos:(NSDictionary *)nuevosDatos
{
    NSString *nibName = nil;
    if (ES_IPAD) {
        nibName = @"MasInformacionView";
    } else {
        nibName = @"MasInformacionView";
    }
    
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    if (xibsArray && xibsArray.count) {
        MasInformacionView *view = [xibsArray objectAtIndex:0];
        
        [view iniciarVistaParaDespliegueEditandoConDatos:nuevosDatos];
        
        return view;
    }
    
    return nil;
}

+ (MasInformacionView *)initMasInformacionViewParaDespliegueConDatos:(NSDictionary *)nuevosDatos
{
    NSString *nibName = nil;
    if (ES_IPAD) {
        nibName = @"MasInformacionView";
    } else {
        nibName = @"MasInformacionView";
    }
    
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    if (xibsArray && xibsArray.count) {
        MasInformacionView *view = [xibsArray objectAtIndex:0];
        
        [view iniciarVistaParaDespliegueConDatos:nuevosDatos];
        
        return view;
    }
    
    return nil;
}


- (void)iniciarVistaParaEdicionConDatos:(NSDictionary *)nuevosDatos
{
    self.estaEditando = YES;
    
    self.datos = nuevosDatos;
    [self.despliegueView removeFromSuperview];
    [self addSubview:self.edicionView];
    self.tamanoOriginal = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    self.tiempoText.delegate = self;
    self.costoText.delegate = self;
    self.contratistaText.delegate = self;
    
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    self.costoText.text = [self.datos objectForKey:@"costo"];
    self.contratistaText.text = [self.datos objectForKey:@"contratista"];
    
    int idTiempo = [[self.datos objectForKey:@"tiempo"] intValue];
    [self obtenerTiempoConIDTiempo:idTiempo];
    
    self.yaNoEsElefanteLabel.hidden = YES;
    self.yaNoEsElefanteDespliegueLabel.hidden = YES;
    
    self.tiempoDesplegable = YES;
    
    [self fondoBotones];
    [self botonesCerrarTeclados];
}

- (void)iniciarVistaParaDespliegueEditandoConDatos:(NSDictionary *)nuevosDatos
{
    self.estaEditando = NO;
    
    self.datos = nuevosDatos;
    [self.edicionView removeFromSuperview];
    [self addSubview:self.despliegueView];
    self.tiempoDespliegueText.hidden = NO;
    self.tiempoLabel.hidden = YES;
    self.tamanoOriginal = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    self.tiempoDespliegueText.delegate = self;
    self.costoDespliegueText.delegate = self;
    self.contratistaDespliegueText.delegate = self;
    
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    self.costoLabel.text = [self.datos objectForKey:@"costo"];
    self.contratistaLabel.text = [self.datos objectForKey:@"contratista"];
    self.costoDespliegueText.text = [self.datos objectForKey:@"costo"];
    self.contratistaDespliegueText.text = [self.datos objectForKey:@"contratista"];
    
    int idTiempo = [[self.datos objectForKey:@"tiempo"] intValue];
    [self obtenerTiempoConIDTiempo:idTiempo];
    if (idTiempo) {
        self.tiempoLabel.hidden = NO;
        self.tiempoDespliegueText.hidden = YES;
        self.desplegarTiempoFlechaImage.hidden = YES;
    } else {
        self.tiempoLabel.hidden = YES;
        self.tiempoDespliegueText.hidden = NO;
        self.estaEditando = YES;
        self.desplegarTiempoFlechaImage.hidden = NO;
    }
    
    NSString *costo = [self.datos objectForKey:@"costo"];
    if (costo && ![costo isEqualToString:@""]) {
        self.costoLabel.hidden = NO;
        self.costoDespliegueText.hidden = YES;
    } else {
        self.costoDespliegueText.text = costo;
        self.costoDespliegueText.hidden = NO;
        self.costoLabel.hidden = YES;
        self.estaEditando = YES;
    }
    
    NSString *contratista = [self.datos objectForKey:@"contratista"];
    if (contratista && ![contratista isEqualToString:@""]) {
        self.contratistaDespliegueText.hidden = YES;
        self.contratistaLabel.hidden = NO;
    } else {
        self.contratistaDespliegueText.hidden = NO;
        self.contratistaDespliegueText.text = contratista;
        self.contratistaLabel.hidden = YES;
        self.estaEditando = YES;
    }
    
    self.yaNoEsElefanteLabel.hidden = YES;
    self.yaNoEsElefanteDespliegueLabel.hidden = YES;
    
    self.tiempoDesplegable = YES;
    
    [self fondoBotones];
    [self botonesCerrarTeclados];
}

- (void)iniciarVistaParaDespliegueConDatos:(NSDictionary *)nuevosDatos
{
    self.estaEditando = NO;
    
    self.datos = nuevosDatos;
    [self.edicionView removeFromSuperview];
    [self addSubview:self.despliegueView];
    self.tiempoDespliegueText.hidden = YES;
    self.tiempoLabel.hidden = NO;
    self.tamanoOriginal = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    self.costoLabel.text = [self.datos objectForKey:@"costo"];
    self.contratistaLabel.text = [self.datos objectForKey:@"contratista"];
    
    int idTiempo = [[self.datos objectForKey:@"tiempo"] intValue];
    [self obtenerTiempoConIDTiempo:idTiempo];
    if (idTiempo) {
        self.tiempoLabel.hidden = NO;
        self.tiempoDespliegueText.hidden = YES;
    } else {
        self.tiempoLabel.hidden = YES;
        self.tiempoDespliegueText.hidden = NO;
        self.estaEditando = YES;
    }
    
    NSString *costo = [self.datos objectForKey:@"costo"];
    if (costo && ![costo isEqualToString:@""]) {
        self.costoLabel.hidden = NO;
        self.costoDespliegueText.hidden = YES;
    } else {
        self.costoDespliegueText.text = costo;
        self.costoDespliegueText.hidden = NO;
        self.costoLabel.hidden = YES;
        self.estaEditando = YES;
    }
    
    NSString *contratista = [self.datos objectForKey:@"contratista"];
    if (contratista && ![contratista isEqualToString:@""]) {
        self.contratistaDespliegueText.hidden = YES;
        self.contratistaLabel.hidden = NO;
    } else {
        self.contratistaDespliegueText.hidden = NO;
        self.contratistaDespliegueText.text = contratista;
        self.contratistaLabel.hidden = YES;
        self.estaEditando = YES;
    }
    
    self.yaNoEsElefanteLabel.hidden = YES;
    self.yaNoEsElefanteDespliegueLabel.hidden = YES;
        
    self.tiempoDesplegable = YES;
    
    [self fondoBotones];
    [self botonesCerrarTeclados];
}


- (void)fondoBotones
{
    // Fondo botones
    UIImage *botonRojoRaw = [UIImage imageNamed:@"boton_rojo1.png"];
    UIEdgeInsets botonRojoEdges;
    botonRojoEdges.top = 12;
    botonRojoEdges.bottom = 24;
    botonRojoEdges.left = 18;
    botonRojoEdges.right = 18;
    UIImage *botonRojoImg = [botonRojoRaw resizableImageWithCapInsets:botonRojoEdges resizingMode:UIImageResizingModeTile];
    [self.seleccionarButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    [self.cancelarSeleccionButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
}

- (void)botonesCerrarTeclados
{
    self.cerrarTecladoButtonsArray = [NSArray arrayWithObjects:self.cerrarTecladoButton1,
                                      self.cerrarTecladoButton2,
                                      self.cerrarTecladoButton3,
                                      self.cerrarTecladoButton4,
                                      nil];
    for (UIButton *boton in self.cerrarTecladoButtonsArray) {
        boton.hidden = YES;
    }
}

- (void)allResignResponder
{
    [self.tiempoText resignFirstResponder];
    [self.costoText resignFirstResponder];
    [self.contratistaText resignFirstResponder];
    [self.costoDespliegueText resignFirstResponder];
    [self.contratistaDespliegueText resignFirstResponder];
    for (UIButton *boton in self.cerrarTecladoButtonsArray) {
        boton.hidden = YES;
    }
}


- (void)obtenerTiempoConIDTiempo:(int)idTiempo
{
    [Servicios consultarRangosDeTiempoConBloque:^(NSArray *rangosArray, NSError *error) {
        if (error) {
            if (error.code >= 500) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error en el servidor"
                                                                message:@"Por favor intente más tarde"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                
                [alert show];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                
                [alert show];
            }
        } else {
            if (rangosArray && rangosArray.count) {
                self.tiemposArray = rangosArray;
                self.tiempoSeleccionado = nil;
                
                for (NSDictionary *tiempo in rangosArray) {
                    int idT = [[tiempo objectForKey:@"id"] intValue];
                    if (idT == idTiempo) {
                        if (self.tiempoDesplegable) {
                            self.tiempoDespliegueText.text = [tiempo objectForKey:@"texto"];
                            self.tiempoText.text = [tiempo objectForKey:@"texto"];
                            self.tiempoLabel.text = [tiempo objectForKey:@"texto"];
                        }
                        self.tiempoSeleccionado = tiempo;
                        break;
                    }
                }
                
                [self.picker reloadAllComponents];
            }
        }
    }];
}


- (IBAction)irASeleccionar:(id)sender
{
    int i = [self.picker selectedRowInComponent:0];
    NSDictionary *item = [self.tiemposArray objectAtIndex:i];
    
    self.tiempoSeleccionado = item;
    
    self.tiempoDespliegueText.text = [self.tiempoSeleccionado objectForKey:@"texto"];
    self.tiempoText.text = [self.tiempoSeleccionado objectForKey:@"texto"];
    
    [self.pickerContenedor removeFromSuperview];

    if (self.delegado) {
        if ([self.delegado respondsToSelector:@selector(masInformacionViewTerminaEditar:)]) {
            [self.delegado masInformacionViewTerminaEditar:self];
        }
    }
}

- (IBAction)irACancelarSeleccion:(id)sender
{
    [self.pickerContenedor removeFromSuperview];
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

    if (self.delegado) {
        if ([self.delegado respondsToSelector:@selector(masInformacionViewIniciaEditar:)]) {
            [self.delegado masInformacionViewIniciaEditar:self];
        }
    }
    
    if (textField == self.costoText || textField == self.costoDespliegueText) {
        NSString *costoStr = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        costoStr = [costoStr stringByReplacingOccurrencesOfString:@"." withString:@""];
        costoStr = [costoStr stringByReplacingOccurrencesOfString:@"," withString:@""];
        costoStr = [costoStr stringByReplacingOccurrencesOfString:@"'" withString:@""];
        NSNumberFormatter *formato = [[NSNumberFormatter alloc] init];
        [formato setNumberStyle:NSNumberFormatterCurrencyStyle];
        NSNumber *costoNumb = [formato numberFromString:costoStr];
        double costoDbl = [costoNumb doubleValue];
        textField.text = [NSString stringWithFormat:@"%.0f", costoDbl];
    }
    
    if (textField == self.tiempoDespliegueText || textField == self.tiempoText) {
        [self addSubview:self.pickerContenedor];
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.contratistaText || textField == self.contratistaDespliegueText) {
        if ((textField.text.length + string.length) > 255) {
            return NO;
        }
        BOOL validar = [Definiciones validarCadenaCaracteresValidos:string];
        return validar;
    } else if (textField == self.costoText || textField == self.costoDespliegueText) {
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
    [textField resignFirstResponder];
    if (self.delegado) {
        if ([self.delegado respondsToSelector:@selector(masInformacionViewTerminaEditar:)]) {
            [self.delegado masInformacionViewTerminaEditar:self];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (self.delegado) {
        if ([self.delegado respondsToSelector:@selector(masInformacionViewTerminaEditar:)]) {
            [self.delegado masInformacionViewTerminaEditar:self];
        }
    }

    for (UIButton *boton in self.cerrarTecladoButtonsArray) {
        boton.hidden = YES;
    }

    return YES;
}



#pragma mark - UIPickerVideDelegate métodos
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.tiemposArray && self.tiemposArray.count) {
        return self.tiemposArray.count;
    } else {
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *item = [self.tiemposArray objectAtIndex:row];
    
    NSString *titulo = [item objectForKey:@"texto"];
    
    return titulo;
}





@end
