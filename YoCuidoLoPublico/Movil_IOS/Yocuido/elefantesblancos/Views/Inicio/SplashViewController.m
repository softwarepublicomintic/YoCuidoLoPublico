//
//  SplashViewController.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 25/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "SplashViewController.h"

#import "VistaInicialViewController.h"


@interface SplashViewController ()

@end

@implementation SplashViewController

@synthesize contenedorTotal;
@synthesize imagenSplash;

- (id)initSplashViewController
{
    NSString *nibName = @"";
    
    if (ES_IPAD) {
        nibName = @"SplashViewController";
    } else {
        nibName = @"SplashViewController";
    }
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self performSelector:@selector(cargarVistaInicial) withObject:nil afterDelay:2];
    
    if (ES_IPHONE_5) {
        self.imagenSplash.image = [UIImage imageNamed:@"splash_elefantes_blancos640x1136.png"];
    } else {
        self.imagenSplash.image = [UIImage imageNamed:@"splash_elefantes_blancos640x1136.png"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cargarVistaInicial
{
    VistaInicialViewController *vistaInicialVC = [[VistaInicialViewController alloc] initVistaInicialViewController];
    [self.navigationController pushViewController:vistaInicialVC animated:YES];
}

@end
