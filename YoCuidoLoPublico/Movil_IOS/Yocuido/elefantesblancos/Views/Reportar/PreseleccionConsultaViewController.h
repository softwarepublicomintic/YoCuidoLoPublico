//
//  PreseleccionConsultaViewController.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 26/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"
#import "Servicios.h"
#import "AlertaMensajeView.h"


@interface PreseleccionConsultaViewController : UIViewController <AlertaMensajeViewDelegate>

@property(strong) IBOutlet UIView *contenedorTotal;
@property(strong) IBOutlet UIImageView *imagenFondo;
@property(strong) IBOutlet UIButton *verElefantesButton;
@property(strong) IBOutlet UIButton *top5Button;
@property(strong) IBOutlet UIButton *atrasButton;
@property(strong) IBOutlet UIView *superiorContenedor;

- (IBAction)irAtras:(id)sender;

- (IBAction)irAVerElefantes:(id)sender;
- (IBAction)irATop5:(id)sender;


- (id)initWithPreseleccionConsultaViewController;

@end
