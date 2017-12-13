//
//  AcercaDeMenuView.m
//  SAC
//
//  Created by Ihonahan Buitrago on 9/5/13.
//  Copyright (c) 2013 Ministerio de Educacion Nacional. All rights reserved.
//

#import "AcercaDeMenuView.h"

#import <QuartzCore/QuartzCore.h>


static NSString *nombreCeldaAcercaDe = @"AcercaDeCell";

@interface AcercaDeMenuView()

@property(assign) CGPoint origen;

/*!
 @method iniciarAcercaDeConDelegado:
 @abstract
 Método que se encarga de iniciar y configurar la vista emergente de Acerca De
 y sus elementos internos.
 
 @param nuevoDelegado
 Apuntador tipo id que cumpla el protocolo AcercaDeMenuViewDelegate que será el 
 encargado de recibir los eventos disparados por ese delegado.
 
 @param miAcercaDeButton
 Botón de Acerca De que muestra u oculta esta vista emergente. Lo referenciamos acá
 para poder ponerlo encima de esta vista cuando se muestra con animación.
 
 @param miOrigen
 Punto inicial donde se pintará esta vista emergente.
*/
- (void)iniciarAcercaDeConDelegado:(id<AcercaDeMenuViewDelegate>)nuevoDelegado yBotonAcercaDe:(UIButton *)miAcercaDeButton conOrigen:(CGPoint)miOrigen;

@end

@implementation AcercaDeMenuView

@synthesize contenedorTotal;
@synthesize menuTableView;
@synthesize delegado;
@synthesize acercaDeButton;
@synthesize origen;


+ (AcercaDeMenuView *)initAcercaDeMenuViewConDelegado:(id<AcercaDeMenuViewDelegate>)nuevoDelegado yBotonAcercaDe:(UIButton *)miAcercaDeButton conOrigen:(CGPoint)miOrigen
{
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:@"AcercaDeMenuView" owner:nil options:nil];
    if (xibsArray && [xibsArray count]) {
        AcercaDeMenuView *view = [xibsArray objectAtIndex:0];
        
        [view iniciarAcercaDeConDelegado:nuevoDelegado yBotonAcercaDe:miAcercaDeButton conOrigen:miOrigen];
        
        return view;
    }
    
    return nil;
}


- (void)iniciarAcercaDeConDelegado:(id<AcercaDeMenuViewDelegate>)nuevoDelegado  yBotonAcercaDe:(UIButton *)miAcercaDeButton conOrigen:(CGPoint)miOrigen
{
    self.delegado = nuevoDelegado;
    self.acercaDeButton = miAcercaDeButton;
    
    self.origen = miOrigen;
    self.frame = CGRectMake(self.origen.x, self.origen.y, 180, 170);
    
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    
    [self.menuTableView reloadData];
    
    [self ocultarSinAnimacion];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    self.menuTableView.layer.masksToBounds = YES;
    self.menuTableView.layer.cornerRadius = 4;
}


- (void)ocultarSinAnimacion
{
    self.hidden = YES;
    [self.superview sendSubviewToBack:self];
    self.frame = CGRectMake(self.origen.x, self.origen.y, 180, 1);
}

- (void)ocultar
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.frame = CGRectMake(self.origen.x, self.origen.y, 180, 1);
                     }
                     completion:^(BOOL finished) {
                         self.hidden = YES;
                         [self.superview sendSubviewToBack:self];
                     }];
}

- (void)mostrar
{
    self.hidden = NO;
    [self.superview bringSubviewToFront:self];
    [self.superview bringSubviewToFront:self.acercaDeButton];
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.frame = CGRectMake(self.origen.x, self.origen.y, 180, 170);
                     }
                     completion:^(BOOL finished) {
                     }];
}


#pragma mark - UIDataTable delegate métodos
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ACERCA_DE_ELEMENTOS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nombreCeldaAcercaDe];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nombreCeldaAcercaDe];
    }
    
    NSString *title = nil;
    
    switch (indexPath.row) {
        case ACERCA_DE_ELEMENTO_COMO_USAR:
        {
            title = @"Cómo usar";
        }
            break;

        case ACERCA_DE_ELEMENTO_AVISO_LEGAL:
        {
            title = @"Aviso legal";
        }
            break;

        case ACERCA_DE_ELEMENTO_SOBRE_APLICACION:
        {
            title = @"Sobre esta aplicación";
        }
            break;

        default:
            break;
    }
    
    cell.textLabel.text = title;
    cell.textLabel.font = FUENTE_ACERCA_DE_ELEMENTO(13);
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegado) {
        if ([self.delegado respondsToSelector:@selector(acercaDe:seleccionarElemento:)]) {
            [self.delegado acercaDe:self seleccionarElemento:indexPath.row];
        }
    }
    
    [self ocultar];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
}


@end
