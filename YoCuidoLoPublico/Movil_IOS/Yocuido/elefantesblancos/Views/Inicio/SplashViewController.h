//
//  SplashViewController.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 25/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"


@interface SplashViewController : UIViewController

@property(strong) IBOutlet UIView *contenedorTotal;
@property(strong) IBOutlet UIImageView *imagenSplash;

- (id)initSplashViewController;

@end
