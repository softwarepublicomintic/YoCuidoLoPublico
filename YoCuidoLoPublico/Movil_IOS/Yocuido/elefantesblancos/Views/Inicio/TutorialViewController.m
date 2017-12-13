//
//  TutorialViewController.m
//  SAC
//
//  Created by Ihonahan Buitrago on 9/6/13.
//  Copyright (c) 2013 Ministerio de Educacion Nacional. All rights reserved.
//

#import "TutorialViewController.h"
#import "PaginaTutorialView.h"
#import "LectorLocalJson.h"


@interface TutorialViewController ()

@property(strong) NSMutableArray *paginasTutoriales;
@property(strong) NSMutableArray *valoresPaginas;

- (void)cargarPagina:(NSInteger)pagina;
- (void)purgarPagina:(NSInteger)pagina;

@end

@implementation TutorialViewController

@synthesize contenedorTotal;
@synthesize contenedorTitulo;
@synthesize atrasButton;
@synthesize tituloLabel;
@synthesize contenidoScrollView;
@synthesize controlPaginacion;
@synthesize paginasTutoriales;


- (id)initTutorialViewController
{
    self = [super initWithNibName:@"TutorialViewController" bundle:[NSBundle mainBundle]];
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
    
    self.contenidoScrollView.delegate = self;
    
    self.paginasTutoriales = [[NSMutableArray alloc] init];
    
    // Creamos las vistas del tutorial y las cargamos en el arreglo de vistas
//    NSString *pag1Valores = @"1|Ingresa tus datos de contacto para continuar con el requerimiento.|imag_tutorial1.png";
//    NSString *pag2Valores = @"2|Selecciona e ingresa la información apropiada del requerimiento.|imag_tutorial1.png";
    NSArray *paginasTutoriales = [LectorLocalJson obtenerElementosJsonDeArchivo:@"tutorial"];
    
    self.valoresPaginas = [[NSMutableArray alloc] init];
    for (NSDictionary *item in paginasTutoriales) {
        NSString *pagValores = [NSString stringWithFormat:@"%@|%@|%@",
                                [item objectForKey:@"id"],
                                [item objectForKey:@"texto"],
                                [item objectForKey:@"imagen"]
                                ];
        [self.valoresPaginas addObject:pagValores];
    }

    for (int i = 0; i < self.valoresPaginas.count; i++) {
        [self.paginasTutoriales addObject:[NSNull null]];
    }

    // Calcular el tamaño del content size del control contenidoScrollView
    // y hacer los demás ajustes
    self.contenidoScrollView.contentSize = CGSizeMake(self.contenidoScrollView.frame.size.width * self.valoresPaginas.count, 1);
    self.controlPaginacion.currentPage = 0;
    self.controlPaginacion.numberOfPages = self.valoresPaginas.count;

    // Luego creamos las vistas para que se vean en el control contenidoScrollView
    [self cargarPaginasVisibles];

    if (ES_VERSION_SISTEMA_MAYOR(@"6.9")) {
        self.contenedorTotal.frame = CGRectMake(0, 20, self.contenedorTotal.frame.size.width, self.contenedorTotal.frame.size.height);
    } else {
        self.contenedorTotal.frame = CGRectMake(0, 0, self.contenedorTotal.frame.size.width, self.contenedorTotal.frame.size.height);
    }
    
    SET_USERDEFAULTS(ES_PRIMERA_EJECUCION, @"1");
    SYNC_USERDEFAULTS;
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



#pragma mark - UIScrollViewDelegate métodos y control de páginas
- (void)cargarPaginasVisibles
{
    CGFloat ancho = self.contenidoScrollView.frame.size.width;
    NSInteger pagina = (NSInteger)floor((self.contenidoScrollView.contentOffset.x * 2.0 + ancho) / (ancho * 2.0));
    
    self.controlPaginacion.currentPage = pagina;
    
    int primeraPagina = pagina - 1;
    int ultimaPagina = pagina + 1;
    int i = 0;
    
    for (i = 0; i < primeraPagina; i++) {
        [self purgarPagina:i];
    }
    for (i = primeraPagina; i <= ultimaPagina; i++) {
        [self cargarPagina:i];
    }
    for (i = ultimaPagina+1; i < self.valoresPaginas.count; i++) {
        [self purgarPagina:i];
    }
}

- (void)cargarPagina:(int)pagina
{
    if (pagina < 0 || pagina >= self.valoresPaginas.count) {
        return;
    }
    
    UIView *vistaPagina = [self.paginasTutoriales objectAtIndex:pagina];
    if ((NSNull*)vistaPagina == [NSNull null]) {
        CGRect frame = CGRectMake(0, 0, 320, 400);
        frame.origin.x = frame.size.width * pagina;
        frame.origin.y = 0.0;
        
        NSString *valores = [self.valoresPaginas objectAtIndex:pagina];
        NSArray *componentes = [valores componentsSeparatedByString:@"|"];
        NSString *numeroString = nil;
        NSString *textoString = nil;
        NSString *imagenString = nil;
        if (componentes.count == 3) {
            numeroString = [componentes objectAtIndex:0];
            textoString = [componentes objectAtIndex:1];
            imagenString = [componentes objectAtIndex:2];

            PaginaTutorialView *paginaTutorialView = [PaginaTutorialView initPaginaTutorialViewConNumero:[numeroString intValue] yTexto:textoString eImagen:imagenString];
            paginaTutorialView.frame = frame;
            [self.contenidoScrollView addSubview:paginaTutorialView];
            [self.paginasTutoriales replaceObjectAtIndex:pagina withObject:paginaTutorialView];
        }
    }
}

- (void)purgarPagina:(int)pagina
{
    if (pagina < 0 || pagina >= self.paginasTutoriales.count) {
        return;
    }
    
    UIView *pageView = [self.paginasTutoriales objectAtIndex:pagina];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.paginasTutoriales replaceObjectAtIndex:pagina withObject:[NSNull null]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.paginasTutoriales) {
        if (self.paginasTutoriales.count) {
            [self cargarPaginasVisibles];
        }
    }
}



@end
