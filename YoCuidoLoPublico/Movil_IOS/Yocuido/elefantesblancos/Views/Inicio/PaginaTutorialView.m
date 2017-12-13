//
//  PaginaTutorialView.m
//  SAC
//
//  Created by Ihonahan Buitrago on 9/6/13.
//  Copyright (c) 2013 Ministerio de Educacion Nacional. All rights reserved.
//

#import "PaginaTutorialView.h"


@interface PaginaTutorialView()


/*!
 @method iniciarPaginaTutorialViewConNumero: yTexto: eImagen:
 @abstract
 Método que se encarga de iniciar y configurar la vista para desplegar
 pasos o elementos del tutorial.
 
 @param numero
 Número del paso o elemento a desplegar
 
 @param texto
 Texto descriptivo que va junto al número y sirve para explicar el paso o elemento.
 
 @param nombreImagen
 Nombre de la imagen en el bundle que se muestra como parte del paso o elemento.
 */
- (void)iniciarPaginaTutorialViewConNumero:(int)numero yTexto:(NSString *)texto eImagen:(NSString *)nombreImagen;

@end

@implementation PaginaTutorialView

@synthesize contenedorTotal;
@synthesize numeroLabel;
@synthesize textoLabel;
@synthesize imagenView;


+ (PaginaTutorialView *)initPaginaTutorialViewConNumero:(int)numero yTexto:(NSString *)texto eImagen:(NSString *)nombreImagen
{
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:@"PaginaTutorialView" owner:nil options:nil];
    if (xibsArray && [xibsArray count]) {
        PaginaTutorialView *view = [xibsArray objectAtIndex:0];
        
        [view iniciarPaginaTutorialViewConNumero:numero yTexto:texto eImagen:nombreImagen];
        
        return view;
    }
    
    return nil;
}


- (void)iniciarPaginaTutorialViewConNumero:(int)numero yTexto:(NSString *)texto eImagen:(NSString *)nombreImagen
{
    if (numero) {
        self.numeroLabel.text = [NSString stringWithFormat:@"%d", numero];
        self.textoLabel.text = texto;
    } else {
        self.numeroLabel.text = @" ";
        self.textoLabel.text = @" ";
    }

    
    UIImage *imagen = [UIImage imageNamed:nombreImagen];
    self.imagenView.image = imagen;
}

@end
