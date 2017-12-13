//
//  SeleccionDepartamentoMunicipioViewController.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 27/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"
#import "AlertaMensajeView.h"


@interface SeleccionDepartamentoMunicipioViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, AlertaMensajeViewDelegate>

@property(strong) IBOutlet UIView *contenedorTotal;
@property(strong) IBOutlet UIImageView *imagenFondo;
@property(strong) IBOutlet UIButton *atrasButton;
@property(strong) IBOutlet UIView *datosContenedor;

@property(strong) IBOutlet UIImageView *barraSuperiorImage;
@property(strong) IBOutlet UIView *superiorContenedor;
@property(strong) IBOutlet UILabel *elefantesBlancosLabel;
@property(strong) IBOutlet UILabel *regionLabel;

@property(strong) IBOutlet UILabel *mensajeLabel;
@property(strong) IBOutlet UITextField *departamentoText;
@property(strong) IBOutlet UITextField *municipioText;
@property(strong) IBOutlet UIButton *consultarButton;

@property(strong) IBOutlet UIView *departamentosContenedor;
@property(strong) IBOutlet UIPickerView *departamentoPicker;
@property(strong) IBOutlet UIButton *seleccionarDepartamentoButton;
@property(strong) IBOutlet UIButton *cancelarDepartamentoButton;

@property(strong) IBOutlet UIView *municipiosContenedor;
@property(strong) IBOutlet UIPickerView *municipioPicker;
@property(strong) IBOutlet UIButton *seleccionarMunicipioButton;
@property(strong) IBOutlet UIButton *cancelarMunicipioButton;

- (IBAction)irAtras:(id)sender;

- (IBAction)irAConsultar:(id)sender;


- (IBAction)irASeleccionarDepartamento:(id)sender;
- (IBAction)irASeleccionarMunicipio:(id)sender;

- (IBAction)irACancelarDepartamento:(id)sender;
- (IBAction)irACancelarMunicipio:(id)sender;


- (id)initSeleccionDepartamentoMunicipioViewControllerParaRegion:(NSArray *)deptos nombreRegion:(NSString *)nuevaRegion;


@end
