//
//  FotoDetalleView.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 3/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"


@interface FotoDetalleView : UIView

@property(strong) UIImageView *imagenView;

@property(strong) UIView *vistaPadre;


- (void)mostrar;
- (void)ocultar;

- (id)initParaFoto:(UIImage *)nuevaImagen sobreVistaPadre:(UIView *)nuevoPadre;

@end
