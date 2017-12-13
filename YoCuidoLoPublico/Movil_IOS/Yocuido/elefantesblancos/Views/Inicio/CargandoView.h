//
//  CargandoView.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 3/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"


@interface CargandoView : UIView

@property(strong) IBOutlet UIImageView *cargandoImage;
@property(strong) IBOutlet UILabel *cargandoLabel;


+ (CargandoView *)initCargandoView;

- (void)ocultarSinAnimacion;
- (void)ocultar;
- (void)mostrar;


@end
