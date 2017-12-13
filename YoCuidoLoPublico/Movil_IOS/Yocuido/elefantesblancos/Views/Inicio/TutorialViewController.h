//
//  TutorialViewController.h
//  SAC
//
//  Created by Ihonahan Buitrago on 9/6/13.
//  Copyright (c) 2013 Ministerio de Educacion Nacional. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"

@interface TutorialViewController : UIViewController <UIScrollViewDelegate>

@property(strong) IBOutlet UIView *contenedorTotal;
@property(strong) IBOutlet UIView *contenedorTitulo;
@property(strong) IBOutlet UIButton *atrasButton;
@property(strong) IBOutlet UILabel *tituloLabel;
@property(strong) IBOutlet UIScrollView *contenidoScrollView;
@property(strong) IBOutlet UIPageControl *controlPaginacion;


- (IBAction)irAtras:(id)sender;


- (id)initTutorialViewController;

- (void)cargarPaginasVisibles;


@end
