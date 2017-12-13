//
//  CrearElefanteViewController.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 14/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"
#import "AlertaMensajeView.h"
#import "ServiciosConnection.h"


@interface CrearElefanteViewController : UIViewController  <UIScrollViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, AlertaMensajeViewDelegate>

@property(strong) IBOutlet UIView *contenedorTotal;
@property(strong) IBOutlet UIImageView *imagenFondo;
@property(strong) IBOutlet UIButton *atrasButton;

@property(strong) IBOutlet UIImageView *barraSuperiorImage;
@property(strong) IBOutlet UIView *superiorContenedor;
@property(strong) IBOutlet UILabel *elefanteBlancoLabel;
@property(strong) IBOutlet UILabel *nombreElefanteLabel;
@property(strong) IBOutlet UILabel *departamentoLabel;

@property(strong) IBOutlet UIScrollView *contenidoScroller;

@property(strong) IBOutlet UILabel *requeridosLabel;
@property(strong) IBOutlet UILabel *asterisco1Label;
@property(strong) IBOutlet UILabel *asterisco2Label;
@property(strong) IBOutlet UILabel *asterisco3Label;
@property(strong) IBOutlet UILabel *asterisco4Label;

@property(strong) IBOutlet UITextField *nombreText;
@property(strong) IBOutlet UITextField *entidadText;
@property(strong) IBOutlet UITextField *razonText;

@property(strong) IBOutlet UILabel *masInformacionLabel;

@property(strong) IBOutlet UITextField *tiempoText;
@property(strong) IBOutlet UITextField *costoText;
@property(strong) IBOutlet UITextField *contratistaText;

@property(strong) IBOutlet UIView *razonesContenedor;
@property(strong) IBOutlet UIButton *razonesButton;
@property(strong) IBOutlet UIButton *cancelarRazonButton;
@property(strong) IBOutlet UIPickerView *razonesPicker;

@property(strong) IBOutlet UIView *tiemposContenedor;
@property(strong) IBOutlet UIButton *tiemposButton;
@property(strong) IBOutlet UIButton *cancelarTiempoButton;
@property(strong) IBOutlet UIPickerView *tiemposPicker;

@property(strong) IBOutlet UIButton *reportarButton;

@property(strong) IBOutlet UIButton *cerrarTecladoButton1;
@property(strong) IBOutlet UIButton *cerrarTecladoButton2;
@property(strong) IBOutlet UIButton *cerrarTecladoButton3;
@property(strong) IBOutlet UIButton *cerrarTecladoButton4;
@property(strong) NSArray *cerrarTecladoButtonsArray;

- (IBAction)irAtras:(id)sender;

- (IBAction)irAReportar:(id)sender;

- (IBAction)irASeleccionarRazon:(id)sender;
- (IBAction)irASeleccionarTiempo:(id)sender;
- (IBAction)irACancelarRazon:(id)sender;
- (IBAction)irACancelarTiempo:(id)sender;

- (IBAction)irACerrarTeclados:(id)sender;

- (id)initCrearElefanteViewControllerConFoto:(UIImage *)nuevaFoto;



@end
