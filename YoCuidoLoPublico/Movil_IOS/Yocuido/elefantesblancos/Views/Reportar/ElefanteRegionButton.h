//
//  ElefanteRegionButton.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 26/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"


@protocol ElefanteRegionButtonDelegado;

@interface ElefanteRegionButton : UIView

@property(strong) IBOutlet UIView *contenedorTotal;
@property(strong) IBOutlet UIButton *elefanteButton;
@property(strong) IBOutlet UIImageView *cantidadImage;
@property(strong) IBOutlet UILabel *cantidadLabel;

@property(weak) id<ElefanteRegionButtonDelegado> delegado;


- (IBAction)irAElefante:(id)sender;

+ (ElefanteRegionButton *)initElefanteRegionButtonConCantidad:(int)nuevaCant yDelegado:(id<ElefanteRegionButtonDelegado>)nuevoDel;

@end


@protocol ElefanteRegionButtonDelegado <NSObject>

@optional
- (void)elefanteRegionButtonInvocado:(ElefanteRegionButton *)vista;

@end