//
//  InformacionViewController.h
//  SAC
//
//  Created by Ihonahan Buitrago on 9/6/13.
//  Copyright (c) 2013 Ministerio de Educacion Nacional. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"


@interface InformacionViewController : UIViewController

@property(strong) IBOutlet UIView *contenedorTotal;
@property(strong) IBOutlet UIView *contenedorTitulo;
@property(strong) IBOutlet UIButton *atrasButton;
@property(strong) IBOutlet UILabel *tituloLabel;
@property(strong) IBOutlet UIWebView *contenidoWebView;


- (IBAction)irAtras:(id)sender;

- (id)initInformacionAvisoLegalViewController;
- (id)initInformacionSobreAplicacionViewController;

@end
