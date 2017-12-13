//
//  ListaElefantesViewController.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 4/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ListaElefanteCell.h"

#import "Definiciones.h"
#import "AlertaMensajeView.h"


@interface ListaElefantesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AlertaMensajeViewDelegate>

@property(strong) IBOutlet UIView *contenedorTotal;
@property(strong) IBOutlet UIImageView *imagenFondo;
@property(strong) IBOutlet UIButton *atrasButton;

@property(strong) IBOutlet UIImageView *barraSuperiorImage;
@property(strong) IBOutlet UIView *superiorContenedor;
@property(strong) IBOutlet UILabel *elefanteBlancoLabel;
@property(strong) IBOutlet UILabel *nombreElefanteLabel;

@property(strong) IBOutlet UITableView *elefantesTable;

@property(assign) BOOL esMasVotados;


- (IBAction)irAtras:(id)sender;


- (id)initListaElefantesViewControllerConMisElefantes:(NSArray *)nuevosElefantes;

- (id)initListaElefantesViewControllerConMasVotados:(NSArray *)nuevosElefantes;


- (void)recargarListaMasVotados;
- (void)regargarMisElefantes;


@end
