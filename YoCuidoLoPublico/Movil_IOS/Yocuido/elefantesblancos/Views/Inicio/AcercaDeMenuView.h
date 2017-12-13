//
//  AcercaDeMenuView.h
//  SAC
//
//  Created by Ihonahan Buitrago on 9/5/13.
//  Copyright (c) 2013 Ministerio de Educacion Nacional. All rights reserved.
//
//  Vista que despliega el menú emergente de Acerca De.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"


@interface AcercaDeMenuView : UIView <UITableViewDataSource, UITableViewDelegate>

@property(strong) IBOutlet UIView *contenedorTotal;
@property(strong) IBOutlet UITableView *menuTableView;

@property(weak) id<AcercaDeMenuViewDelegate> delegado;
@property(weak) UIButton *acercaDeButton;

/*!
 @method initAcercaDeMenuViewConDelegado:
 @abstract
 Método creador de objetos de este tipo de clase, envolvente propio que evita que sea creado
 conociendo previamente sus parámetros usuales de creación.
 
 @param nuevoDelegado
 Apuntador tipo id que cumpla el protocolo AcercaDeMenuViewDelegate que será el
 encargado de recibir los eventos disparados por ese delegado.
 
 @param miAcercaDeButton
 Botón de Acerca De que muestra u oculta esta vista emergente. Lo referenciamos acá
 para poder ponerlo encima de esta vista cuando se muestra con animación.
 
 @param miOrigen
 Punto inicial donde se pintará esta vista emergente.
 */
+ (AcercaDeMenuView *)initAcercaDeMenuViewConDelegado:(id<AcercaDeMenuViewDelegate>)nuevoDelegado yBotonAcercaDe:(UIButton *)miAcercaDeButton conOrigen:(CGPoint)miOrigen;


/*!
 @method ocultarSinAnimacion
 @abstract
 Método para ocultar inmediatamente y sin animación la vista emergente de Acerca De.
 */
- (void)ocultarSinAnimacion;

/*!
 @method ocultar
 @abstract
 Método para ocultar con animación la vista emergente de Acerca De.
 */
- (void)ocultar;

/*!
 @method mostrar
 @abstract
 Método para mostrar con animación la vista emergente de Acerca De.
 */
- (void)mostrar;

@end
