//
//  VistaInicialViewController.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 25/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"
#import "AlertaMensajeView.h"
#import "AcercaDeMenuView.h"


@interface VistaInicialViewController : UIViewController <AlertaMensajeViewDelegate, AcercaDeMenuViewDelegate>

@property(strong) IBOutlet UIView *contenedorTotal;
@property(strong) IBOutlet UIImageView *imagenFondo;
@property(strong) IBOutlet UIView *fondoArriba;
@property(strong) IBOutlet UIView *fondoAbajo;
@property(strong) IBOutlet UIButton *acercaDeButton;

@property(strong) IBOutlet UIImageView *elefanteImage;
@property(strong) IBOutlet UIButton *reportarElefanteButton;
@property(strong) IBOutlet UILabel *reportarElefanteLabel;
@property(strong) IBOutlet UIButton *consultarElefantesButton;
@property(strong) IBOutlet UILabel *consultarElefantesLabel;
@property(strong) IBOutlet UIButton *misElefantesButton;
@property(strong) IBOutlet UILabel *misElefantesLabel;
@property(strong) IBOutlet UIImageView *secretariaImage;

@property(strong) AcercaDeMenuView *acercaDeMenuView;


- (IBAction)irAAcercaDe:(id)sender;

- (IBAction)irAReportarElefante:(id)sender;
- (IBAction)irAConsultarElefantes:(id)sender;
- (IBAction)irAMisElefantes:(id)sender;

- (id)initVistaInicialViewController;

@end
