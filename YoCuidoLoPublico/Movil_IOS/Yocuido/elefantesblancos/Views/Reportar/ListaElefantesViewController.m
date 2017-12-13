//
//  ListaElefantesViewController.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 4/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "ListaElefantesViewController.h"

#import "LectorLocalJson.h"
#import "CargandoView.h"
#import "DetalleElefanteBlancoViewController.h"
#import "EditarMiElefanteViewController.h"
#import "Servicios.h"


@interface ListaElefantesViewController ()

@property(assign) CGFloat contenedorY;
@property(strong) NSMutableArray *elefantesArray;
@property(strong) NSMutableArray *misElefantes;
@property(strong) NSMutableArray *misElefantesConsultados;
@property(strong) NSString *titulo;

@property(strong) CargandoView *cargando;
@property(strong) AlertaMensajeView *alerta;

@property(strong) NSArray *departamentosArray;
@property(strong) NSArray *municipiosArray;

@property(strong) UIImage *estadoElefanteAprobadoImage;
@property(strong) UIImage *estadoElefantePendienteImage;
@property(strong) UIImage *estadoElefanteRechazadoImage;

@end

@implementation ListaElefantesViewController

@synthesize contenedorTotal;
@synthesize imagenFondo;
@synthesize atrasButton;
@synthesize barraSuperiorImage;
@synthesize superiorContenedor;
@synthesize elefanteBlancoLabel;
@synthesize nombreElefanteLabel;
@synthesize elefantesTable;

@synthesize contenedorY;
@synthesize elefantesArray;
@synthesize titulo;
@synthesize cargando;
@synthesize alerta;
@synthesize esMasVotados;
@synthesize departamentosArray;
@synthesize municipiosArray;
@synthesize estadoElefanteAprobadoImage;
@synthesize estadoElefantePendienteImage;
@synthesize estadoElefanteRechazadoImage;
@synthesize misElefantes;
@synthesize misElefantesConsultados;


- (id)initListaElefantesViewControllerConMisElefantes:(NSArray *)nuevosElefantes
{
    NSString *nibName = @"";
    
    if (ES_IPAD) {
        nibName = @"ListaElefantesViewController";
    } else {
        nibName = @"ListaElefantesViewController";
    }
    
    if (ES_IPHONE_5) {
        self.contenedorY = 84;
    } else {
        self.contenedorY = 84;
    }
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        self.elefantesArray = [NSMutableArray arrayWithArray:nuevosElefantes];
        self.titulo = @"Consulta de mis Reportes";
        self.esMasVotados = NO;
    }
    return self;
}

- (id)initListaElefantesViewControllerConMasVotados:(NSArray *)nuevosElefantes
{
    NSString *nibName = @"";
    
    if (ES_IPAD) {
        nibName = @"ListaElefantesViewController";
    } else {
        nibName = @"ListaElefantesViewController";
    }
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        if (ES_IPHONE_5) {
            self.contenedorY = 84;
        } else {
            self.contenedorY = 84;
        }
        
        self.elefantesArray = [NSMutableArray arrayWithArray:nuevosElefantes];
        self.titulo = @"Top 5";
        self.esMasVotados = YES;
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
        self.elefantesTable.frame = CGRectMake(0, self.contenedorY, self.elefantesTable.frame.size.width, self.elefantesTable.frame.size.height);
    }
    
    if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
        self.superiorContenedor.frame = CGRectMake(0, 20, self.superiorContenedor.frame.size.width, self.superiorContenedor.frame.size.height);
    } else {
        self.superiorContenedor.frame = CGRectMake(0, 0, self.superiorContenedor.frame.size.width, self.superiorContenedor.frame.size.height);
    }
    
    self.departamentosArray = [LectorLocalJson obtenerElementosJsonDeArchivo:@"departamentos"];
    self.municipiosArray = [LectorLocalJson obtenerElementosJsonDeArchivo:@"municipios"];
    
    self.elefantesTable.dataSource = self;
    self.elefantesTable.delegate = self;

    self.nombreElefanteLabel.text = self.titulo;
    [self.elefantesTable reloadData];

    // Vista de Cargando
    self.cargando = [CargandoView initCargandoView];
    [self.view addSubview:self.cargando];
    [self.cargando ocultarSinAnimacion];

    // Alerta y Mensajes
    self.alerta = [AlertaMensajeView initAlertaMensajeViewConDelegado:self];
    [self.view addSubview:self.alerta];
    self.alerta.hidden = YES;
    [self.view sendSubviewToBack:self.alerta];
    
    // Imágenes de Estados de Elefante
    self.estadoElefanteAprobadoImage = [UIImage imageNamed:@"icono_aprobado.png"];
    self.estadoElefantePendienteImage = [UIImage imageNamed:@"icono_pendiente.png"];
    self.estadoElefanteRechazadoImage = [UIImage imageNamed:@"icono_rechazado.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)recargarListaMasVotados
{
    [self.cargando mostrar];
    [Servicios consultarElefantesMasVotadosConBloque:^(NSArray *nuevosElefantes, NSError *error) {
        [self.cargando ocultar];
        if (nuevosElefantes && nuevosElefantes.count) {
            self.elefantesArray = [NSMutableArray arrayWithArray:nuevosElefantes];
            [self.elefantesTable reloadData];
        } else {
            if (error.code >= 500) {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
            } else {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
            }
        }
    }];
}


- (void)regargarMisElefantes
{
    [self.cargando mostrar];
    NSString *idsGuardados = GET_USERDEFAULTS(USUARIO_MIS_ELEFANTES);
    NSArray *comps = [idsGuardados componentsSeparatedByString:@"|"];
    self.misElefantes = [NSMutableArray arrayWithArray:comps];
    if (self.misElefantes && self.misElefantes.count) {
        self.misElefantesConsultados = [[NSMutableArray alloc] init];
        NSString *primerId = [self.misElefantes firstObject];
        long long idElefante = [primerId longLongValue];
        [self obtenerYCargarElefanteConsultado:idElefante];
    } else {
        [self.cargando ocultar];
        [self.navigationController popViewControllerAnimated:YES];
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
                
                self.elefantesArray = [NSMutableArray arrayWithArray:self.misElefantesConsultados];
                [self.elefantesTable reloadData];
            }
        }
    }];
}




- (IBAction)irAtras:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (NSString *)obtenerNombreDepartamentoPorCodigo:(int)codigo
{
    for (NSDictionary *depto in self.departamentosArray) {
        int idDp = [[depto objectForKey:@"codigo"] intValue];
        if (idDp == codigo) {
            NSString *nombre = [depto objectForKey:@"nombre"];
            return nombre;
        }
    }
    
    return @"";
}

- (NSString *)obtenerNombreMunicipioPorCodigo:(int)codigo
{
    for (NSDictionary *munic in self.municipiosArray) {
        int idMn = [[munic objectForKey:@"codigo"] intValue];
        if (idMn == codigo) {
            NSString *nombre = [munic objectForKey:@"nombre"];
            return nombre;
        }
    }
    
    return @"";
}


#pragma mark - UITableViewDelegate y DataSource métodos
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.elefantesArray && self.elefantesArray.count) {
        return  self.elefantesArray.count;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *elefanteBlanco = [self.elefantesArray objectAtIndex:indexPath.row];
    
    ListaElefanteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListaElefanteCell"];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ListaElefanteCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Obtener información desde el diccionario y asignarlo a los controles de la celda
    NSString *imgBase64 = [elefanteBlanco objectForKey:@"imagenPrincipal"];
    UIImage *imagen = nil;
    if (![imgBase64 isKindOfClass:[NSNull class]] && [imgBase64 isKindOfClass:[NSString class]]) {
        NSData *imgData = [NSData dataFromBase64String:imgBase64];
        imagen = [UIImage imageWithData:imgData];
    }
    
    int rechazos = [[elefanteBlanco objectForKey:@"rechazos"] intValue];
    cell.nombreLabel.text = [elefanteBlanco objectForKey:@"titulo"];
    cell.rechazosLabel.text = [NSString stringWithFormat:@"%d", rechazos];
    cell.fotoImage.image = imagen;
    
    int codDepto = [[elefanteBlanco objectForKey:@"departamento"] intValue];
    int codMunic = [[elefanteBlanco objectForKey:@"municipio"] intValue];
    NSString *depto = [self obtenerNombreDepartamentoPorCodigo:codDepto];
    NSString *munic = [self obtenerNombreMunicipioPorCodigo:codMunic];
    NSString *infoStr = [NSString stringWithFormat:@"%@\r%@", depto, munic];
    
    if (self.esMasVotados) {
        cell.infoLabel.hidden = NO;
        cell.estadoContenedor.hidden = YES;
        cell.infoLabel.text = infoStr;
    } else {
        cell.infoLabel.hidden = YES;
        cell.estadoContenedor.hidden = NO;
        
        // Lógica para pintar el estado
        int estado = [[elefanteBlanco objectForKey:@"estado"] intValue];
        if (estado == ESTADO_ELEFANTE_APROBADO) {
            cell.estadoImage.image = self.estadoElefanteAprobadoImage;
            cell.estadoLabel.text = TEXTO_APROBADO;
        } else if (estado == ESTADO_ELEFANTE_PENDIENTE) {
            cell.estadoImage.image = self.estadoElefantePendienteImage;
            cell.estadoLabel.text = TEXTO_PENDIENTE;
        } else if (estado == ESTADO_ELEFANTE_NO_APROBADO) {
            cell.estadoImage.image = self.estadoElefanteRechazadoImage;
            cell.estadoLabel.text = TEXTO_RECHAZADO;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:NO];

    NSDictionary *elefanteBlanco = [self.elefantesArray objectAtIndex:indexPath.row];

    long long idElefante = [[elefanteBlanco objectForKey:@"id"] longLongValue];
    int estado = [[elefanteBlanco objectForKey:@"estado"] intValue];
    
    [self.cargando mostrar];

    [Servicios consultarDetalleElefantes:idElefante conBloque:^(NSDictionary *elefanteDiccionario, NSError *error) {
        [self.cargando ocultar];
        if (error) {
            if (error.code >= 500) {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"Por favor intente más tarde"];
            } else {
                self.alerta.bandera = 0;
                [self.alerta mostrarMensajeConLetrero:@"No es posible conectarse con el servidor. Por favor verifique que su dispositivo esté conectado a internet y vuelva a intentar"];
            }
        } else if (elefanteDiccionario) {
            if (estado == ESTADO_ELEFANTE_PENDIENTE || estado == ESTADO_ELEFANTE_NO_APROBADO) {
                EditarMiElefanteViewController *editarElefanteVC = [[EditarMiElefanteViewController alloc] initEditarMiElefanteViewControllerParaElefante:elefanteDiccionario estadoEdicion:MasInformacionEstadoDespliegueEditando esMiElefante:!self.esMasVotados];
                [self.navigationController pushViewController:editarElefanteVC animated:YES];
            } else {
                DetalleElefanteBlancoViewController *detalleVC = [[DetalleElefanteBlancoViewController alloc] initDetalleElefanteBlancoViewControllerParaElefante:elefanteDiccionario estadoEdicion:MasInformacionEstadoDespliegueEditando esMiElefante:!self.esMasVotados];
                [self.navigationController pushViewController:detalleVC animated:YES];
            }
        }
    }];
    
    
}


@end
