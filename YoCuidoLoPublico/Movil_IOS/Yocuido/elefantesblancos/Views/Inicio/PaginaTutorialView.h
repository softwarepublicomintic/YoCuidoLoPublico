//
//  PaginaTutorialView.h
//  SAC
//
//  Created by Ihonahan Buitrago on 9/6/13.
//  Copyright (c) 2013 Ministerio de Educacion Nacional. All rights reserved.
//
//  Vista contenedora de la información a desplegar en cada elemento
//  del tutorial de la aplicación.
//

#import <UIKit/UIKit.h>

@interface PaginaTutorialView : UIView

@property(strong) IBOutlet UIView *contenedorTotal;
@property(strong) IBOutlet UILabel *numeroLabel;
@property(strong) IBOutlet UILabel *textoLabel;
@property(strong) IBOutlet UIImageView *imagenView;


+ (PaginaTutorialView *)initPaginaTutorialViewConNumero:(int)numero yTexto:(NSString *)texto eImagen:(NSString *)nombreImagen;


@end
