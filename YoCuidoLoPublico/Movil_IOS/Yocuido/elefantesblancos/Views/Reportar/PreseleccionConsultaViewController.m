//
//  PreseleccionConsultaViewController.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 26/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "PreseleccionConsultaViewController.h"

#import "MapaRegionesViewController.h"
#import "ListaElefantesViewController.h"

#import "CargandoView.h"


@interface PreseleccionConsultaViewController ()

@property(assign) CGFloat contenedorY;

@property(strong) CargandoView *cargando;
@property(strong) AlertaMensajeView *alerta;

@end

@implementation PreseleccionConsultaViewController

@synthesize contenedorTotal;
@synthesize imagenFondo;
@synthesize atrasButton;
@synthesize verElefantesButton;
@synthesize top5Button;
@synthesize superiorContenedor;

@synthesize contenedorY;
@synthesize cargando;
@synthesize alerta;


- (id)initWithPreseleccionConsultaViewController
{
    NSString *nibName = @"";
    
    if (ES_IPAD) {
        nibName = @"PreseleccionConsultaViewController";
    } else {
        nibName = @"PreseleccionConsultaViewController";
    }
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        
        if (ES_IPHONE_5) {
            self.contenedorY = 0;
        } else {
            self.contenedorY = 86;
        }
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

    if (ES_IPHONE_5) {
        self.contenedorTotal.frame = CGRectMake(0, self.contenedorY, self.contenedorTotal.frame.size.width, self.contenedorTotal.frame.size.height);
    }
    
    if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
        self.superiorContenedor.frame = CGRectMake(0, 20, self.superiorContenedor.frame.size.width, self.superiorContenedor.frame.size.height);
    } else {
        self.superiorContenedor.frame = CGRectMake(0, 0, self.superiorContenedor.frame.size.width, self.superiorContenedor.frame.size.height);
    }
    
    UIImage *botonRojoRaw = [UIImage imageNamed:@"boton_rojo1.png"];
    UIEdgeInsets botonRojoEdges;
    botonRojoEdges.top = 12;
    botonRojoEdges.bottom = 24;
    botonRojoEdges.left = 18;
    botonRojoEdges.right = 18;
    UIImage *botonRojoImg = [botonRojoRaw resizableImageWithCapInsets:botonRojoEdges resizingMode:UIImageResizingModeTile];
    [self.verElefantesButton setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    [self.top5Button setBackgroundImage:botonRojoImg forState:UIControlStateNormal];
    
    // Vista de Cargando
    self.cargando = [CargandoView initCargandoView];
    [self.view addSubview:self.cargando];
    [self.cargando ocultarSinAnimacion];

    // Alerta y Mensajes
    self.alerta = [AlertaMensajeView initAlertaMensajeViewConDelegado:self];
    [self.view addSubview:self.alerta];
    self.alerta.hidden = YES;
    [self.view sendSubviewToBack:self.alerta];
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



- (IBAction)irAVerElefantes:(id)sender
{
    [self.cargando mostrar];
    [Servicios consultarCantidadElefantesPorRegionesConBloque:^(NSArray *regionesArray, NSError *error) {
        [self.cargando ocultar];
        if (regionesArray && regionesArray.count) {
            MapaRegionesViewController *mapaRegionesVC = [[MapaRegionesViewController alloc] initMapaRegionesViewControllerConRegiones:regionesArray];
            [self.navigationController pushViewController:mapaRegionesVC animated:YES];
        } else if (error) {
            if (error.code >= 500) {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
            } else {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
            }
        } else {
            self.alerta.bandera = 0;
            [self.alerta mostrarMensajeConLetrero:@"No hay elefantes blancos reportados"];
        }
    }];
}

- (IBAction)irATop5:(id)sender
{
    [self.cargando mostrar];
    [Servicios consultarElefantesMasVotadosConBloque:^(NSArray *elefantesArray, NSError *error) {
        [self.cargando ocultar];
        if (elefantesArray && elefantesArray.count) {
            ListaElefantesViewController *listaElefantesVC = [[ListaElefantesViewController alloc] initListaElefantesViewControllerConMasVotados:elefantesArray];
            [self.navigationController pushViewController:listaElefantesVC animated:YES];
        } else if (error) {
            if (error.code >= 500) {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
            } else {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
            }
        } else {
            self.alerta.bandera = 0;
            [self.alerta mostrarMensajeConLetrero:@"No hay elefantes blancos reportados"];
        }
    }];
}




@end
