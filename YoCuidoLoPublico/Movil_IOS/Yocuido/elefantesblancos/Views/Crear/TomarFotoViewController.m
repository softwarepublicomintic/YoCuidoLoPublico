//
//  TomarFotoViewController.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 16/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "TomarFotoViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>

#import "CrearElefanteViewController.h"


@interface TomarFotoViewController ()

@property(assign) BOOL esCrearElefante;

@end

@implementation TomarFotoViewController

@synthesize esCrearElefante;


- (id)initTomarFotoViewControllerParaCrearElefante
{
    NSString *nibName = @"";
    
    if (ES_IPAD) {
        nibName = @"TomarFotoViewController";
    } else {
        nibName = @"TomarFotoViewController";
    }
    
    if (ES_IPHONE_5) {
    } else {
    }
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        self.esCrearElefante = YES;
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
    
    UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
    pickerView.delegate = self;
    pickerView.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
    pickerView.allowsEditing = NO;
    pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerView.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    [self.navigationController presentViewController:pickerView animated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}



#pragma mark - UIImagePickerViewControllerDelegate métodos
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imagen = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (imagen) {
        CGFloat w = imagen.size.width;
        CGFloat h = imagen.size.height;
        
        CGFloat maxW = [[Definiciones sharedImagenAncho] floatValue];
        CGFloat maxH = [[Definiciones sharedImagenAlto] floatValue];
        
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            maxH /= [UIScreen mainScreen].scale;
            maxW /= [UIScreen mainScreen].scale;
        }
        
        if (w > maxW) {
            h *= (maxW / w);
            w = maxW;
        }
        if (h > maxH) {
            w *= (maxH / h);
            h = maxH;
        }
        
        UIImage *imagen2 = [Definiciones imagenDesdeImagen:imagen conNuevoTamano:CGSizeMake(w, h)];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            if (self.esCrearElefante) {
                CrearElefanteViewController *crearVC = [[CrearElefanteViewController alloc] initCrearElefanteViewControllerConFoto:imagen2];
                [self.navigationController pushViewController:crearVC animated:YES];
            }
        }];
    }
}


@end
