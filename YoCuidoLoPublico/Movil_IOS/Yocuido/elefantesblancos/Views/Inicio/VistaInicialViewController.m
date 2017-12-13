//
//  VistaInicialViewController.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 25/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "VistaInicialViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "PreseleccionConsultaViewController.h"
#import "MapaElefantesViewController.h"
#import "ListaElefantesViewController.h"
#import "CargandoView.h"
#import "Servicios.h"
#import "InformacionViewController.h"
#import "TutorialViewController.h"


#import "CrearElefanteViewController.h"



@interface VistaInicialViewController ()

@property(assign) CGFloat contenedorY;
@property(assign) BOOL acercaDeDesplegado;

@property(strong) CargandoView *cargando;
@property(strong) AlertaMensajeView *alerta;

@property(strong) NSMutableArray *misElefantes;
@property(strong) NSMutableArray *misElefantesConsultados;

@end

@implementation VistaInicialViewController

@synthesize contenedorTotal;
@synthesize imagenFondo;
@synthesize fondoArriba;
@synthesize fondoAbajo;

@synthesize elefanteImage;
@synthesize reportarElefanteButton;
@synthesize reportarElefanteLabel;
@synthesize consultarElefantesButton;
@synthesize consultarElefantesLabel;
@synthesize misElefantesButton;
@synthesize misElefantesLabel;
@synthesize secretariaImage;

@synthesize contenedorY;
@synthesize cargando;
@synthesize alerta;
@synthesize misElefantes;
@synthesize misElefantesConsultados;


- (id)initVistaInicialViewController
{
    NSString *nibName = @"";
    
    if (ES_IPAD) {
        nibName = @"VistaInicialViewController";
    } else {
        nibName = @"VistaInicialViewController";
    }
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        if (ES_IPHONE_5) {
            self.contenedorY = 52;
        } else {
            self.contenedorY = 0;
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
    
    self.fondoArriba.layer.masksToBounds = YES;
    self.fondoArriba.layer.cornerRadius = 48;

    // Vista de Cargando
    self.cargando = [CargandoView initCargandoView];
    [self.view addSubview:self.cargando];
    [self.cargando ocultarSinAnimacion];
    
    // Alerta y Mensajes
    self.alerta = [AlertaMensajeView initAlertaMensajeViewConDelegado:self];
    [self.view addSubview:self.alerta];
    self.alerta.hidden = YES;
    
    // Acerca De
    [self.view sendSubviewToBack:self.alerta];
    self.acercaDeMenuView = [AcercaDeMenuView initAcercaDeMenuViewConDelegado:self yBotonAcercaDe:self.acercaDeButton conOrigen:CGPointMake(137, 14)];
    [self.contenedorTotal addSubview:self.acercaDeMenuView];
    [self.acercaDeMenuView ocultarSinAnimacion];
    
    self.acercaDeDesplegado = NO;
    
    NSString *primeraEjec = GET_USERDEFAULTS(ES_PRIMERA_EJECUCION);
    if (!primeraEjec || [primeraEjec isEqualToString:@""]) {
        [self performSelector:@selector(asyncCargarTutorialPrimeraVez) withObject:nil afterDelay:1.1];
    }
}

- (void)asyncCargarTutorialPrimeraVez
{
    TutorialViewController *tutorialView = [[TutorialViewController alloc] initTutorialViewController];
    [self.navigationController pushViewController:tutorialView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)irAAcercaDe:(id)sender
{
    if (self.acercaDeDesplegado) {
        self.acercaDeDesplegado = NO;
        [self.acercaDeMenuView ocultar];
    } else {
        self.acercaDeDesplegado = YES;
        [self.acercaDeMenuView mostrar];
    }
}



- (IBAction)irAReportarElefante:(id)sender
{
    MapaElefantesViewController *mapaVC = [[MapaElefantesViewController alloc] initMapaElefantesViewControllerReportando];
    [self.navigationController pushViewController:mapaVC animated:YES];
    
//    CrearElefanteViewController *crearVC = [[CrearElefanteViewController alloc] initCrearElefanteViewControllerConFoto:[UIImage imageNamed:@"imag_tutorial1.png"]];
//    [self.navigationController pushViewController:crearVC animated:YES];
}

- (IBAction)irAConsultarElefantes:(id)sender
{
    PreseleccionConsultaViewController *preselVC = [[PreseleccionConsultaViewController alloc] initWithPreseleccionConsultaViewController];
    [self.navigationController pushViewController:preselVC animated:YES];
}

- (IBAction)irAMisElefantes:(id)sender
{
    [self.cargando mostrar];
//    SET_USERDEFAULTS(USUARIO_MIS_ELEFANTES, @"391|392|393|394|395|396");
//    SYNC_USERDEFAULTS;
    NSString *idsGuardados = GET_USERDEFAULTS(USUARIO_MIS_ELEFANTES);
    NSArray *comps = [idsGuardados componentsSeparatedByString:@"|"];
    self.misElefantes = [NSMutableArray arrayWithArray:comps];
    if (self.misElefantes && self.misElefantes.count) {
        self.misElefantesConsultados = [[NSMutableArray alloc] init];
        NSString *primerId = [self.misElefantes firstObject];
        long long idElefante = [primerId longLongValue];
        [self obtenerYCargarElefanteConsultado:idElefante];
    } else {
        [self.alerta mostrarMensajeConLetrero:@"Usted no ha reportado elefantes desde este dispositivo."];
        [self.cargando ocultar];
    }
}


- (void)obtenerYCargarElefanteConsultado:(long long)idElefante
{
    [Servicios consultarMiElefante:idElefante conBloque:^(NSDictionary *elefante, NSError *error) {
        if (error) {
            if (error.code >= 500) {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
            } else {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
            }
            [self.cargando ocultar];
        } else {
            [self.misElefantes removeObjectAtIndex:0];
            [self.misElefantesConsultados addObject:elefante];
            if (self.misElefantes.count) {
                NSString *primerId = [self.misElefantes firstObject];
                long long idElefante = [primerId longLongValue];
                [self obtenerYCargarElefanteConsultado:idElefante];
            } else {
                [self.cargando ocultar];
                
                ListaElefantesViewController *listaVC = [[ListaElefantesViewController alloc] initListaElefantesViewControllerConMisElefantes:self.misElefantesConsultados];
                [self.navigationController pushViewController:listaVC animated:YES];
            }
        }
    }];
}



#pragma mark - AcercaDeMenuViewDelegate métodos
- (void)acercaDe:(id)sender seleccionarElemento:(int)elemento
{
    self.acercaDeDesplegado = NO;
    
    switch (elemento) {
        case ACERCA_DE_ELEMENTO_COMO_USAR:
        {
            TutorialViewController *tutorialView = [[TutorialViewController alloc] initTutorialViewController];
            [self.navigationController pushViewController:tutorialView animated:YES];
        }
            break;
            
        case ACERCA_DE_ELEMENTO_AVISO_LEGAL:
        {
            InformacionViewController *infoAvisoLegal = [[InformacionViewController alloc] initInformacionAvisoLegalViewController];
            [self.navigationController pushViewController:infoAvisoLegal animated:YES];
        }
            break;
            
        case ACERCA_DE_ELEMENTO_SOBRE_APLICACION:
        {
            InformacionViewController *infoSobreAplicacion = [[InformacionViewController alloc] initInformacionSobreAplicacionViewController];
            [self.navigationController pushViewController:infoSobreAplicacion animated:YES];
        }
            break;
            
        default:
            break;
    }
}



@end
