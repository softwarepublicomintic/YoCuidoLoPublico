//
//  MapaRegionesViewController.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 26/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"

#import "ElefanteRegionButton.h"
#import "AlertaMensajeView.h"


@interface MapaRegionesViewController : UIViewController <ElefanteRegionButtonDelegado, AlertaMensajeViewDelegate>

@property(strong) IBOutlet UIView *contenedorTotal;
@property(strong) IBOutlet UIImageView *imagenFondo;
@property(strong) IBOutlet UIButton *atrasButton;
@property(strong) IBOutlet UIView *mapaContenedor;

@property(strong) IBOutlet UIImageView *barraSuperiorImage;
@property(strong) IBOutlet UIView *superiorContenedor;
@property(strong) IBOutlet UILabel *elefantesBlancosLabel;
@property(strong) IBOutlet UILabel *enColombiaLabel;

@property(strong) IBOutlet UIImageView *regionInsularImage;
@property(strong) IBOutlet UIImageView *regionCaribeImage;
@property(strong) IBOutlet UIImageView *regionAndinaImage;
@property(strong) IBOutlet UIImageView *regionPacificaImage;
@property(strong) IBOutlet UIImageView *regionOrinoquiaImage;
@property(strong) IBOutlet UIImageView *regionAmazoniaImage;

@property(strong) IBOutlet UIView *regionInsularContenedor;
@property(strong) IBOutlet UIView *regionCaribeContenedor;
@property(strong) IBOutlet UIView *regionAndinaContenedor;
@property(strong) IBOutlet UIView *regionPacificaContenedor;
@property(strong) IBOutlet UIView *regionOrinoquiaContenedor;
@property(strong) IBOutlet UIView *regionAmazoniaContenedor;


- (IBAction)irAtras:(id)sender;


- (id)initMapaRegionesViewControllerConRegiones:(NSArray *)nuevasRegiones;

@end
