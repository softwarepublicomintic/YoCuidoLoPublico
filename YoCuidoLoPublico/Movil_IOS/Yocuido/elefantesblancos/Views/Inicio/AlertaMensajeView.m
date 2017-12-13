//
//  AlertaMensajeView.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 20/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "AlertaMensajeView.h"

#import <QuartzCore/QuartzCore.h>


@implementation AlertaMensajeView


@synthesize alertaContenedor;
@synthesize alertaFondoRojo;
@synthesize alertaMensajeLabel;
@synthesize siButton;
@synthesize noButton;

@synthesize mensajeContenedor;
@synthesize mensajeFondoNegro;
@synthesize mensajeLabel;
@synthesize terminarButton;

@synthesize delegado;
@synthesize bandera;



+ (AlertaMensajeView *)initAlertaMensajeViewConDelegado:(id<AlertaMensajeViewDelegate>)nuevoDel
{
    NSString *nibName = nil;
    if (ES_IPAD) {
        nibName = @"AlertaMensajeView";
    } else {
        nibName = @"AlertaMensajeView";
    }
    
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    if (xibsArray && xibsArray.count) {
        AlertaMensajeView *view = [xibsArray objectAtIndex:0];
        
        view.delegado = nuevoDel;
        
        UIImage *botonGrisRaw = [UIImage imageNamed:@"boton_gris1.png"];
        UIEdgeInsets botonRojoEdges;
        botonRojoEdges.top = 12;
        botonRojoEdges.bottom = 24;
        botonRojoEdges.left = 18;
        botonRojoEdges.right = 18;
        UIImage *botonGrisImg = [botonGrisRaw resizableImageWithCapInsets:botonRojoEdges resizingMode:UIImageResizingModeTile];
        [view.siButton setBackgroundImage:botonGrisImg forState:UIControlStateNormal];
        [view.noButton setBackgroundImage:botonGrisImg forState:UIControlStateNormal];

        UIImage *botonRojoRaw = [UIImage imageNamed:@"boton_rojo1.png"];
        UIImage *botonRojoImg = [botonRojoRaw resizableImageWithCapInsets:botonRojoEdges resizingMode:UIImageResizingModeTile];
        [view.terminarButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
        
        view.mensajeFondoNegro.layer.masksToBounds = YES;
        view.mensajeFondoNegro.layer.cornerRadius = 14;
        view.alertaFondoRojo.layer.masksToBounds = YES;
        view.alertaFondoRojo.layer.cornerRadius = 14;
        
        return view;
    }
    
    return nil;
}


- (void)mostrarMensajeConLetrero:(NSString *)mensaje
{
    self.alpha = 0;
    self.hidden = NO;
    self.mensajeLabel.text = mensaje;
    [self.superview bringSubviewToFront:self];
    self.mensajeContenedor.hidden = NO;
    self.alertaContenedor.hidden = YES;
    
    int nLineas = mensaje.length / 32;
    nLineas += 2;
    int hMensaje = nLineas * 24;
    self.mensajeLabel.frame = CGRectMake(self.mensajeLabel.frame.origin.x,
                                         self.mensajeLabel.frame.origin.y,
                                         self.mensajeLabel.frame.size.width,
                                         hMensaje);
    self.mensajeLabel.numberOfLines = nLineas;
    
    int hFondo = 280;
    if (hMensaje < 205) hFondo = hMensaje + 30 + 36;
    if (hMensaje > hFondo) hFondo = hMensaje + 30 + 36;
    int yFondo = [UIScreen mainScreen].bounds.size.height - hFondo;
    yFondo /= 2;
    if (yFondo >= 140) {
        yFondo = 120;
    }
    self.terminarButton.frame = CGRectMake(self.terminarButton.frame.origin.x, (self.mensajeLabel.frame.origin.y + self.mensajeLabel.frame.size.height + 8), self.terminarButton.frame.size.width, self.terminarButton.frame.size.height);
    self.mensajeFondoNegro.frame = CGRectMake(25, yFondo, 270, hFondo);
    
    [self.terminarButton setTitle:@"Terminar" forState:UIControlStateNormal];
    [self.terminarButton setTitle:@"Terminar" forState:UIControlStateHighlighted];
    [self bringSubviewToFront:self.mensajeContenedor];
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}


- (void)mostrarAlertaConLetrero:(NSString *)mensaje
{
    self.alertaMensajeLabel.text = mensaje;
    self.alpha = 0;
    self.hidden = NO;
    [self.superview bringSubviewToFront:self];
    self.mensajeContenedor.hidden = YES;
    self.alertaContenedor.hidden = NO;
    [self.siButton setTitle:@"Sí" forState:UIControlStateNormal];
    [self.siButton setTitle:@"Sí" forState:UIControlStateHighlighted];
    [self.noButton setTitle:@"No" forState:UIControlStateNormal];
    [self.noButton setTitle:@"No" forState:UIControlStateHighlighted];
    [self bringSubviewToFront:self.alertaContenedor];
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}


- (void)mostrarMensajeConLetrero:(NSString *)mensaje textoBoton:(NSString *)textoBtn
{
    self.alpha = 0;
    self.hidden = NO;
    self.mensajeLabel.text = mensaje;
    [self.superview bringSubviewToFront:self];
    self.mensajeContenedor.hidden = NO;
    self.alertaContenedor.hidden = YES;
    
    int nLineas = mensaje.length / 34;
    nLineas += 1;
    int hMensaje = nLineas * 21;
    self.mensajeLabel.frame = CGRectMake(self.mensajeLabel.frame.origin.x,
                                         self.mensajeLabel.frame.origin.y,
                                         self.mensajeLabel.frame.size.width,
                                         hMensaje);
    
    int hFondo = 280;
    if (hMensaje < 205) hFondo = hMensaje + 30 + 36;
    self.terminarButton.frame = CGRectMake(self.terminarButton.frame.origin.x, (self.mensajeLabel.frame.origin.y + self.mensajeLabel.frame.size.height + 8), self.terminarButton.frame.size.width, self.terminarButton.frame.size.height);
    self.mensajeFondoNegro.frame = CGRectMake(25, 165, 270, hFondo);

    [self.terminarButton setTitle:textoBtn forState:UIControlStateNormal];
    [self.terminarButton setTitle:textoBtn forState:UIControlStateHighlighted];
    [self bringSubviewToFront:self.mensajeContenedor];
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}


- (void)mostrarAlertaConLetrero:(NSString *)mensaje textoAfirmativo:(NSString *)textoSi textoNegativo:(NSString *)textoNo
{
    self.alertaMensajeLabel.text = mensaje;
    self.alpha = 0;
    self.hidden = NO;
    [self.superview bringSubviewToFront:self];
    self.mensajeContenedor.hidden = YES;
    self.alertaContenedor.hidden = NO;
    [self.siButton setTitle:textoSi forState:UIControlStateNormal];
    [self.siButton setTitle:textoSi forState:UIControlStateHighlighted];
    [self.noButton setTitle:textoNo forState:UIControlStateNormal];
    [self.noButton setTitle:textoNo forState:UIControlStateHighlighted];
    [self bringSubviewToFront:self.alertaContenedor];
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}



- (IBAction)irATerminar:(id)sender
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.superview sendSubviewToBack:self];
                         self.hidden = YES;
                         
                         if (self.delegado) {
                             if ([self.delegado respondsToSelector:@selector(alertaMensajeViewSeleccionaTerminar:)]) {
                                 [self.delegado alertaMensajeViewSeleccionaTerminar:self];
                             }
                         }
                     }];
}


- (IBAction)irASi:(id)sender
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.superview sendSubviewToBack:self];
                         self.hidden = YES;
                         
                         if (self.delegado) {
                             if ([self.delegado respondsToSelector:@selector(alertaMensajeViewSeleccionaSi:)]) {
                                 [self.delegado alertaMensajeViewSeleccionaSi:self];
                             }
                         }
                     }];
}

- (IBAction)irANo:(id)sender
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.superview sendSubviewToBack:self];
                         self.hidden = YES;
                         
                         if (self.delegado) {
                             if ([self.delegado respondsToSelector:@selector(alertaMensajeViewSeleccionaNo:)]) {
                                 [self.delegado alertaMensajeViewSeleccionaNo:self];
                             }
                         }
                     }];
}




@end
