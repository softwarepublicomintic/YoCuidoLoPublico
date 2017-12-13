//
//  ElefanteRegionButton.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 26/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "ElefanteRegionButton.h"


@interface ElefanteRegionButton()

@property(assign) int cantidad;

- (void)iniciarElefanteRegionButtonConCantidad:(int)nuevaCant yDelegado:(id<ElefanteRegionButtonDelegado>)nuevoDel;

@end


@implementation ElefanteRegionButton

@synthesize contenedorTotal;
@synthesize elefanteButton;
@synthesize cantidadImage;
@synthesize cantidadLabel;
@synthesize delegado;


+ (ElefanteRegionButton *)initElefanteRegionButtonConCantidad:(int)nuevaCant yDelegado:(id<ElefanteRegionButtonDelegado>)nuevoDel
{
    NSString *nibName = nil;
    if (ES_IPAD) {
        nibName = @"ElefanteRegionButton";
    } else {
        nibName = @"ElefanteRegionButton";
    }
    
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    if (xibsArray && xibsArray.count) {
        ElefanteRegionButton *view = [xibsArray objectAtIndex:0];
        
        [view iniciarElefanteRegionButtonConCantidad:nuevaCant yDelegado:nuevoDel];
        
        return view;
    }
    
    return nil;
}

- (void)iniciarElefanteRegionButtonConCantidad:(int)nuevaCant yDelegado:(id<ElefanteRegionButtonDelegado>)nuevoDel
{
    self.delegado = nuevoDel;
    self.cantidad = nuevaCant;
    
    self.cantidadLabel.text = [NSString stringWithFormat:@"%d", self.cantidad];
}


- (int)devolverCantidad
{
    return self.cantidad;
}


- (IBAction)irAElefante:(id)sender
{
    if (self.delegado) {
        if ([self.delegado respondsToSelector:@selector(elefanteRegionButtonInvocado:)]) {
            [self.delegado elefanteRegionButtonInvocado:self];
        }
    }
}


@end
