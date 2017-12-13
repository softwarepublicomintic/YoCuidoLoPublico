//
//  CargandoView.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 3/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "CargandoView.h"


@interface CargandoView()

@property(assign) BOOL girando;
@property(assign) CGFloat grados;


- (void)girarCargando;

@end

@implementation CargandoView

@synthesize cargandoImage;
@synthesize cargandoLabel;
@synthesize girando;
@synthesize grados;


+ (CargandoView *)initCargandoView
{
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:@"CargandoView" owner:nil options:nil];
    if (xibsArray && [xibsArray count]) {
        CargandoView *view = [xibsArray objectAtIndex:0];
        
        return view;
    }
    
    return nil;
}


- (void)ocultarSinAnimacion
{
    self.alpha = 0;
    self.hidden = YES;
    [self.superview sendSubviewToBack:self];
    self.girando = NO;
}

- (void)ocultar
{
    [UIView animateWithDuration:0.1
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         self.hidden = YES;
                         [self.superview sendSubviewToBack:self];
                         self.girando = NO;
                     }];
    
}

- (void)mostrar
{
    self.alpha = 0;
    self.hidden = NO;
    [self.superview bringSubviewToFront:self];
    
    //CGFloat hVent = (CGFloat)ALTURA_VENTANA;
    
    CGFloat hVent = [UIScreen mainScreen].bounds.size.height;
    //hVent -= 60; // La altura del título
    CGFloat y = (hVent / 2.0) - (self.cargandoImage.frame.size.height / 2.0);
    CGFloat x = (self.frame.size.width / 2.0) - (self.cargandoImage.frame.size.width / 2.0);
    
    self.cargandoImage.frame = CGRectMake(x, y, 65, 65);
    self.cargandoLabel.frame = CGRectMake(self.cargandoLabel.frame.origin.x,
                                          (self.cargandoImage.frame.origin.y + self.cargandoImage.frame.size.height + 10),
                                          258,
                                          21);
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         self.girando = YES;
                         self.grados = 5;
                         [self girarCargando];
                     }];
}

- (void)girarCargando
{
    [UIView animateWithDuration:0.001
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.cargandoImage.transform = CGAffineTransformMakeRotation(GRADOS_A_RADIANES(self.grados));
                     }
                     completion:^(BOOL finished) {
                         if (self.girando) {
                             self.grados += 5;
                             [self girarCargando];
                         }
                     }];
    
}


@end
