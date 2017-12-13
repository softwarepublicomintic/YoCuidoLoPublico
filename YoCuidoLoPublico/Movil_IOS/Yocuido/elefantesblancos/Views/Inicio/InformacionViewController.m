//
//  InformacionViewController.m
//  SAC
//
//  Created by Ihonahan Buitrago on 9/6/13.
//  Copyright (c) 2013 Ministerio de Educacion Nacional. All rights reserved.
//
//  Esta vista desplegará la información ubicada en los archivos JSon que contengan
//  información de interés o comunicación general, como acerca de la aplicación y
//  aviso legal entre otros.
//


#import "InformacionViewController.h"

#import "LectorLocalJson.h"


@interface InformacionViewController ()

@property(strong) NSString *nombreJson;
@property(strong) NSString *nombreHtml;
@property(strong) NSString *tituloVista;

@end

@implementation InformacionViewController

@synthesize contenedorTotal;
@synthesize contenedorTitulo;
@synthesize atrasButton;
@synthesize tituloLabel;
@synthesize contenidoWebView;
@synthesize nombreJson;
@synthesize nombreHtml;
@synthesize tituloVista;


- (id)initInformacionAvisoLegalViewController
{
    self = [super initWithNibName:@"InformacionViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        // Inicialización propia de este constructor
        self.nombreJson = @"legal";
        self.nombreHtml = @"legal";
        self.tituloVista = @"Aviso Legal";
    }
    return self;
}

- (id)initInformacionSobreAplicacionViewController
{
    self = [super initWithNibName:@"InformacionViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        // Inicialización propia de este constructor
        self.nombreJson = @"acerca";
        self.nombreHtml = @"acerca";
        self.tituloVista = @"Sobre esta aplicación";
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
    
    self.tituloLabel.text = self.tituloVista;
 
    NSDictionary *contenidoDiccionario = [LectorLocalJson obtenerPrimerElementoJsonDeArchivo:self.nombreJson];
    
    if (contenidoDiccionario) {
        NSError *error = nil;
        
        NSString *contenido = [contenidoDiccionario objectForKey:@"contenido"];
        NSString *version = [contenidoDiccionario objectForKey:@"version"];
        NSString *derechos = [contenidoDiccionario objectForKey:@"copyright"];
        NSString *pie = [contenidoDiccionario objectForKey:@"pie"];
        
        if (!contenido || [[contenido stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] ) {
            contenido = @" ";
        }
        if (!version || [[version stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] ) {
            version = @" ";
        }
        if (!derechos || [[derechos stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] ) {
            derechos = @" ";
        }
        if (!pie || [[pie stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] ) {
            pie = @" ";
        }
        
        // Luego de obtener la información, leemos el html plantilla con el que construiremos el contenido
        // que se mostrará en el control contenidoWebView
        NSString *rutaHtml = [[NSBundle mainBundle] pathForResource:self.nombreHtml ofType:@"html"];
        NSData *dataHtml = [NSData dataWithContentsOfFile:rutaHtml options:NSDataReadingUncached error:&error];
        if (!error && dataHtml) {
            NSString *plantillaHtml = [[NSString alloc] initWithData:dataHtml encoding:NSUTF8StringEncoding];
            
            NSString *contenidoHtml = [NSString stringWithFormat:plantillaHtml, contenido, derechos, pie];
            
            [self.contenidoWebView loadHTMLString:contenidoHtml baseURL:nil];
        }
    }
    
    if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
        self.contenedorTotal.frame = CGRectMake(0, 20, self.contenedorTotal.frame.size.width, self.contenedorTotal.frame.size.height);
    } else {
        self.contenedorTotal.frame = CGRectMake(0, 0, self.contenedorTotal.frame.size.width, self.contenedorTotal.frame.size.height);
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)irAtras:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
