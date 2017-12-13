//
//  MapaRegionesViewController.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 26/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "MapaRegionesViewController.h"

#import "SeleccionDepartamentoMunicipioViewController.h"
#import "Servicios.h"
#import "CargandoView.h"


@interface MapaRegionesViewController ()

@property(assign) CGFloat contenedorY;

@property(strong) NSMutableArray *botonesRegiones;

@property(strong) NSArray *regionesArray;

@property(strong) CargandoView *cargando;
@property(strong) AlertaMensajeView *alerta;

@end

@implementation MapaRegionesViewController

@synthesize contenedorTotal;
@synthesize imagenFondo;
@synthesize atrasButton;
@synthesize barraSuperiorImage;
@synthesize superiorContenedor;
@synthesize elefantesBlancosLabel;
@synthesize enColombiaLabel;
@synthesize regionInsularImage;
@synthesize regionCaribeImage;
@synthesize regionAndinaImage;
@synthesize regionPacificaImage;
@synthesize regionOrinoquiaImage;
@synthesize regionAmazoniaImage;
@synthesize regionInsularContenedor;
@synthesize regionCaribeContenedor;
@synthesize regionAndinaContenedor;
@synthesize regionPacificaContenedor;
@synthesize regionOrinoquiaContenedor;
@synthesize regionAmazoniaContenedor;;

@synthesize contenedorY;
@synthesize botonesRegiones;
@synthesize cargando;


- (id)initMapaRegionesViewControllerConRegiones:(NSArray *)nuevasRegiones
{
    NSString *nibName = @"";
    
    if (ES_IPAD) {
        nibName = @"MapaRegionesViewController";
    } else {
        nibName = @"MapaRegionesViewController";
    }
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        
        if (ES_IPHONE_5) {
            self.contenedorY = 132;
        } else {
            self.contenedorY = 86;
        }

        self.regionesArray = nuevasRegiones;
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
        self.mapaContenedor.frame = CGRectMake(0, self.contenedorY, self.mapaContenedor.frame.size.width, self.mapaContenedor.frame.size.height);
    }
    
    if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
        self.superiorContenedor.frame = CGRectMake(0, 20, self.superiorContenedor.frame.size.width, self.superiorContenedor.frame.size.height);
    } else {
        self.superiorContenedor.frame = CGRectMake(0, 0, self.superiorContenedor.frame.size.width, self.superiorContenedor.frame.size.height);
    }
    
    
    // Botones de regiones
    // Primero seteamos las regiones como si no tuvieran info
    self.regionCaribeImage.image = [UIImage imageNamed:@"mapa_region_caribe_inactiva.png"];
    self.regionCaribeContenedor.hidden = YES;
    self.regionAndinaImage.image = [UIImage imageNamed:@"mapa_region_andina_inactiva.png"];
    self.regionAndinaContenedor.hidden = YES;
    self.regionPacificaImage.image = [UIImage imageNamed:@"mapa_region_pacifica_inactiva.png"];
    self.regionPacificaContenedor.hidden = YES;
    self.regionOrinoquiaImage.image = [UIImage imageNamed:@"mapa_region_orinoquia_inactiva.png"];
    self.regionOrinoquiaContenedor.hidden = YES;
    self.regionAmazoniaImage.image = [UIImage imageNamed:@"mapa_region_amazonia_inactiva.png"];
    self.regionAmazoniaContenedor.hidden = YES;
    self.regionInsularImage.image = [UIImage imageNamed:@"mapa_region_insular_inactiva.png"];
    self.regionInsularContenedor.hidden = YES;

    // Luego llenamos y seteamos valores
    self.botonesRegiones = [[NSMutableArray alloc] init];
    
    for (NSDictionary *region in self.regionesArray) {
        int idRegion = [[region objectForKey:@"idRegion"] intValue];
        int cantidad = [[region objectForKey:@"cantidad"] intValue];

        NSMutableDictionary *regionDic = [[NSMutableDictionary alloc] init];
        ElefanteRegionButton *botonRgn = [ElefanteRegionButton initElefanteRegionButtonConCantidad:cantidad yDelegado:self];
        
        switch (idRegion) {
            case 1:  // atlantica = 1
            {
                if (!cantidad) {
                    self.regionCaribeImage.image = [UIImage imageNamed:@"mapa_region_caribe_inactiva.png"];
                    self.regionCaribeContenedor.hidden = YES;
                } else {
                    self.regionCaribeImage.image = [UIImage imageNamed:@"mapa_region_caribe_activa.png"];
                    self.regionCaribeContenedor.hidden = NO;
                    [self.regionCaribeContenedor addSubview:botonRgn];
                    [regionDic setValue:botonRgn forKey:@"control"];
                    [regionDic setValue:@"Caribe" forKey:@"nombre"];
                    [regionDic setValue:@"1" forKey:@"idRegion"];
                }
            }
                break;
                
            case 2:  // andina = 2
            {
                if (!cantidad) {
                    self.regionAndinaImage.image = [UIImage imageNamed:@"mapa_region_andina_inactiva.png"];
                    self.regionAndinaContenedor.hidden = YES;
                } else {
                    self.regionAndinaImage.image = [UIImage imageNamed:@"mapa_region_andina_activa.png"];
                    self.regionAndinaContenedor.hidden = NO;
                    [self.regionAndinaContenedor addSubview:botonRgn];
                    [regionDic setValue:botonRgn forKey:@"control"];
                    [regionDic setValue:@"Andina" forKey:@"nombre"];
                    [regionDic setValue:@"2" forKey:@"idRegion"];
                }
            }
                break;
                
            case 3:  // pacifica = 3
            {
                if (!cantidad) {
                    self.regionPacificaImage.image = [UIImage imageNamed:@"mapa_region_pacifica_inactiva.png"];
                    self.regionPacificaContenedor.hidden = YES;
                } else {
                    self.regionPacificaImage.image = [UIImage imageNamed:@"mapa_region_pacifica_activa.png"];
                    self.regionPacificaContenedor.hidden = NO;
                    [self.regionPacificaContenedor addSubview:botonRgn];
                    [regionDic setValue:botonRgn forKey:@"control"];
                    [regionDic setValue:@"Pacífica" forKey:@"nombre"];
                    [regionDic setValue:@"3" forKey:@"idRegion"];
                }
            }
                break;
                
            case 4:  // orinoquia = 4
            {
                if (!cantidad) {
                    self.regionOrinoquiaImage.image = [UIImage imageNamed:@"mapa_region_orinoquia_inactiva.png"];
                    self.regionOrinoquiaContenedor.hidden = YES;
                } else {
                    self.regionOrinoquiaImage.image = [UIImage imageNamed:@"mapa_region_orinoquia_activa.png"];
                    self.regionOrinoquiaContenedor.hidden = NO;
                    [self.regionOrinoquiaContenedor addSubview:botonRgn];
                    [regionDic setValue:botonRgn forKey:@"control"];
                    [regionDic setValue:@"Orinoquía" forKey:@"nombre"];
                    [regionDic setValue:@"4" forKey:@"idRegion"];
                }
            }
                break;
                
            case 5:  // amazonia = 5
            {
                if (!cantidad) {
                    self.regionAmazoniaImage.image = [UIImage imageNamed:@"mapa_region_amazonia_inactiva.png"];
                    self.regionAmazoniaContenedor.hidden = YES;
                } else {
                    self.regionAmazoniaImage.image = [UIImage imageNamed:@"mapa_region_amazonia_activa.png"];
                    self.regionAmazoniaContenedor.hidden = NO;
                    [self.regionAmazoniaContenedor addSubview:botonRgn];
                    [regionDic setValue:botonRgn forKey:@"control"];
                    [regionDic setValue:@"Amazonía" forKey:@"nombre"];
                    [regionDic setValue:@"5" forKey:@"idRegion"];
                }
            }
                break;
                
            case 6:  // insular = 6
            {
                if (!cantidad) {
                    self.regionInsularImage.image = [UIImage imageNamed:@"mapa_region_insular_inactiva.png"];
                    self.regionInsularContenedor.hidden = YES;
                } else {
                    self.regionInsularImage.image = [UIImage imageNamed:@"mapa_region_insular_activa.png"];
                    self.regionInsularContenedor.hidden = NO;
                    [self.regionInsularContenedor addSubview:botonRgn];
                    [regionDic setValue:botonRgn forKey:@"control"];
                    [regionDic setValue:@"Insular" forKey:@"nombre"];
                    [regionDic setValue:@"6" forKey:@"idRegion"];
                }
            }
                break;
                
            default:
                break;
        }
        
        [self.botonesRegiones addObject:regionDic];
    }
    
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


#pragma mark - ElefanteRegionButtonDelegate métodos
- (void)elefanteRegionButtonInvocado:(ElefanteRegionButton *)vista
{
    NSMutableDictionary *regionDic = nil;
    for (NSMutableDictionary *item in self.botonesRegiones) {
        ElefanteRegionButton *boton = [item objectForKey:@"control"];
        if (vista == boton) {
            regionDic = item;
            break;
        }
    }
    
    int idRegion = [[regionDic objectForKey:@"idRegion"] intValue];
    NSString *nombreRegion = [regionDic objectForKey:@"nombre"];
    
    [self.cargando mostrar];
    [Servicios consultarDepartamentosPorRegion:idRegion conBloque:^(NSArray *deptosArray, NSError *error) {
        if (error) {
            if (error.code >= 500) {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
            } else {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
            }
        } else if (deptosArray && deptosArray.count) {
            SeleccionDepartamentoMunicipioViewController *seleccionDeptoVC = [[SeleccionDepartamentoMunicipioViewController alloc] initSeleccionDepartamentoMunicipioViewControllerParaRegion:deptosArray nombreRegion:nombreRegion];
            
            [self.navigationController pushViewController:seleccionDeptoVC animated:YES];
        }
        
        [self.cargando ocultar];
    }];
    
}



@end
