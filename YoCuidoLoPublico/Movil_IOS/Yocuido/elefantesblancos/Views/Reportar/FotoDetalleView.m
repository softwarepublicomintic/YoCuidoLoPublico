//
//  FotoDetalleView.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 3/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "FotoDetalleView.h"

@implementation FotoDetalleView

@synthesize imagenView;


- (id)initParaFoto:(UIImage *)nuevaImagen sobreVistaPadre:(UIView *)nuevoPadre
{
    CGRect miRect = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    
    self = [super initWithFrame:miRect];
    
    if (self) {
        self.vistaPadre = nuevoPadre;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        CGFloat w = (self.frame.size.width > self.frame.size.height) ? self.frame.size.height : self.frame.size.width;
        CGFloat h = w;
        CGFloat x = (self.frame.size.width / 2.0) - (w / 2.0);
        CGFloat y = (self.frame.size.height / 2.0) - (h / 2.0);
        CGRect imgRect = CGRectMake(x, y, w, h);
        self.imagenView = [[UIImageView alloc] initWithFrame:imgRect];
        self.imagenView.contentMode = UIViewContentModeScaleAspectFit;
        self.imagenView.backgroundColor = [UIColor blackColor];
        self.imagenView.image = nuevaImagen;
        [self addSubview:self.imagenView];
        self.alpha = 0;
        self.hidden = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        UIImage *atrasImage = [UIImage imageNamed:@"boton_retorno.png"];

        CGFloat y0 = 0;
        if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
            y0 = 20;
        } else {
            y0 = 0;
        }
        CGRect atrasRect = CGRectMake(0, y0, atrasImage.size.width, atrasImage.size.height);
        UIButton *botonOcultar = [[UIButton alloc] initWithFrame:atrasRect];
        [botonOcultar setImage:atrasImage forState:UIControlStateNormal];
        [botonOcultar addTarget:self action:@selector(ocultar) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:botonOcultar];
        
        [self.vistaPadre addSubview:self];
        [self.vistaPadre sendSubviewToBack:self];
    }
    
    return self;
}

- (void)mostrar
{
    [self.vistaPadre bringSubviewToFront:self];
    self.hidden = NO;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)ocultar
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         self.imagenView = nil;
                     }];
}



@end
