//
//  MasInformacionView.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 2/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"


typedef enum {
    MasInformacionEstadoEdicion,
    MasInformacionEstadoDespliegueEditando,
    MasInformacionEstadoDespliegue
} MasInformacionEstado;

@protocol MasInformacionViewDelegate;

@interface MasInformacionView : UIView <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property(strong) IBOutlet UIView *edicionView;
@property(strong) IBOutlet UITextField *tiempoText;
@property(strong) IBOutlet UITextField *costoText;
@property(strong) IBOutlet UITextField *contratistaText;

@property(strong) IBOutlet UIView *despliegueView;
@property(strong) IBOutlet UILabel *tiempoTituloLabel;
@property(strong) IBOutlet UILabel *tiempoLabel;
@property(strong) IBOutlet UITextField *tiempoDespliegueText;
@property(strong) IBOutlet UILabel *costoTituloLabel;
@property(strong) IBOutlet UILabel *costoLabel;
@property(strong) IBOutlet UITextField *costoDespliegueText;
@property(strong) IBOutlet UILabel *contratistaTituloLabel;
@property(strong) IBOutlet UILabel *contratistaLabel;
@property(strong) IBOutlet UITextField *contratistaDespliegueText;

@property(strong) IBOutlet UIView *pickerContenedor;
@property(strong) IBOutlet UIPickerView *picker;
@property(strong) IBOutlet UIButton *seleccionarButton;
@property(strong) IBOutlet UIButton *cancelarSeleccionButton;

@property(strong) IBOutlet UIImageView *desplegarTiempoFlechaImage;
@property(strong) IBOutlet UIImageView *tiempoFlechaImage;

@property(strong) IBOutlet UILabel *yaNoEsElefanteLabel;
@property(strong) IBOutlet UILabel *yaNoEsElefanteDespliegueLabel;

@property(strong) IBOutlet UIButton *cerrarTecladoButton1;
@property(strong) IBOutlet UIButton *cerrarTecladoButton2;
@property(strong) IBOutlet UIButton *cerrarTecladoButton3;
@property(strong) IBOutlet UIButton *cerrarTecladoButton4;
@property(strong) NSArray *cerrarTecladoButtonsArray;


@property(assign) CGSize tamanoOriginal;

@property(weak) id<MasInformacionViewDelegate> delegado;

@property(strong) NSDictionary *tiempoSeleccionado;

@property(assign) BOOL estaEditando;

@property(assign) BOOL tiempoDesplegable;


- (IBAction)irASeleccionar:(id)sender;
- (IBAction)irACancelarSeleccion:(id)sender;

- (IBAction)irACerrarTeclados:(id)sender;


+ (MasInformacionView *)initMasInformacionViewParaEdicionConDatos:(NSDictionary *)nuevosDatos;
+ (MasInformacionView *)initMasInformacionViewParaDespliegueEditandoConDatos:(NSDictionary *)nuevosDatos;
+ (MasInformacionView *)initMasInformacionViewParaDespliegueConDatos:(NSDictionary *)nuevosDatos;


- (void)allResignResponder;


@end

@protocol MasInformacionViewDelegate <NSObject>

@optional
- (void)masInformacionViewIniciaEditar:(MasInformacionView *)vista;
- (void)masInformacionViewTerminaEditar:(MasInformacionView *)vista;

@end