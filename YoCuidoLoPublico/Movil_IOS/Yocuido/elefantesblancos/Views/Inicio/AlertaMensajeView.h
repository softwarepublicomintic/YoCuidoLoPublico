//
//  AlertaMensajeView.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 20/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"


@protocol AlertaMensajeViewDelegate;


@interface AlertaMensajeView : UIView

@property(strong) IBOutlet UIView *alertaContenedor;
@property(strong) IBOutlet UIView *alertaFondoRojo;
@property(strong) IBOutlet UILabel *alertaMensajeLabel;
@property(strong) IBOutlet UIButton *siButton;
@property(strong) IBOutlet UIButton *noButton;


@property(strong) IBOutlet UIView *mensajeContenedor;
@property(strong) IBOutlet UIView *mensajeFondoNegro;
@property(strong) IBOutlet UILabel *mensajeLabel;
@property(strong) IBOutlet UIButton *terminarButton;

@property(weak) id<AlertaMensajeViewDelegate> delegado;

@property(assign) unsigned int bandera;

- (IBAction)irATerminar:(id)sender;

- (IBAction)irASi:(id)sender;
- (IBAction)irANo:(id)sender;


+ (AlertaMensajeView *)initAlertaMensajeViewConDelegado:(id<AlertaMensajeViewDelegate>)nuevoDel;


- (void)mostrarMensajeConLetrero:(NSString *)mensaje;
- (void)mostrarAlertaConLetrero:(NSString *)mensaje;

- (void)mostrarMensajeConLetrero:(NSString *)mensaje textoBoton:(NSString *)textoBtn;
- (void)mostrarAlertaConLetrero:(NSString *)mensaje textoAfirmativo:(NSString *)textoSi textoNegativo:(NSString *)textoNo;

@end


@protocol AlertaMensajeViewDelegate <NSObject>

@optional
- (void)alertaMensajeViewSeleccionaTerminar:(AlertaMensajeView *)vista;
- (void)alertaMensajeViewSeleccionaSi:(AlertaMensajeView *)vista;
- (void)alertaMensajeViewSeleccionaNo:(AlertaMensajeView *)vista;

@end