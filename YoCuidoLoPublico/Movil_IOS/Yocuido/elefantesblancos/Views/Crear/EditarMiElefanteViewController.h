//
//  EditarMiElefanteViewController.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 26/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Definiciones.h"
#import "AlertaMensajeView.h"
#import "MasInformacionView.h"
#import "ServiciosConnection.h"


@interface EditarMiElefanteViewController : UIViewController <UIScrollViewDelegate, MasInformacionViewDelegate, UIImagePickerControllerDelegate, AlertaMensajeViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property(strong) IBOutlet UIView *contenedorTotal;
@property(strong) IBOutlet UIImageView *imagenFondo;
@property(strong) IBOutlet UIButton *atrasButton;

@property(strong) IBOutlet UIImageView *barraSuperiorImage;
@property(strong) IBOutlet UIView *superiorContenedor;
@property(strong) IBOutlet UILabel *elefanteBlancoLabel;
@property(strong) IBOutlet UILabel *nombreElefanteLabel;
@property(strong) IBOutlet UILabel *fechaElefanteLabel;

@property(strong) IBOutlet UIView *estadisticasContenedor;
@property(strong) IBOutlet UILabel *cantidadRechazosLabel;
@property(strong) IBOutlet UILabel *cantidadFotosLabel;
@property(strong) IBOutlet UILabel *cantidadSeparadorLabel;

@property(strong) IBOutlet UIScrollView *contenidoScroller;

@property(strong) IBOutlet UIView *fotoContenedor;
@property(strong) IBOutlet UIScrollView *fotoScroller;
@property(strong) IBOutlet UIPageControl *controlPaginacion;

@property(strong) IBOutlet UILabel *departamentoUbicacionLabel;

@property(strong) IBOutlet UIImageView *estadoElefanteImage;
@property(strong) IBOutlet UILabel *estadoElefanteLabel;

@property(strong) IBOutlet UITextField *nombreElefanteText;
@property(strong) IBOutlet UITextField *entidadTituloText;
@property(strong) IBOutlet UITextField *razonElefanteText;

@property(strong) IBOutlet UILabel *masInfoTituloLabel;
@property(strong) MasInformacionView *masInfoView;

@property(strong) IBOutlet UIView *notificacionesContenedor;
@property(strong) IBOutlet UILabel *notificacionesTituloLabel;
@property(strong) IBOutlet UILabel *notificacionesLabel;

@property(strong) IBOutlet UIView *botonesContenedor;
@property(strong) IBOutlet UIButton *actualizarButton;

@property(strong) IBOutlet UIView *masInfoContenedor;
@property(strong) IBOutlet UIView *accionesContenedor;
@property(strong) IBOutlet UIImageView *accionesImage;

@property(strong) IBOutlet UIView *razonesContenedor;
@property(strong) IBOutlet UIButton *razonesButton;
@property(strong) IBOutlet UIButton *cancelarRazonButton;
@property(strong) IBOutlet UIPickerView *razonesPicker;

@property(strong) IBOutlet UIView *tiemposContenedor;
@property(strong) IBOutlet UIButton *tiemposButton;
@property(strong) IBOutlet UIButton *cancelarTiempoButton;
@property(strong) IBOutlet UIPickerView *tiemposPicker;


@property(strong) IBOutlet UIButton *cerrarTecladoButton1;
@property(strong) IBOutlet UIButton *cerrarTecladoButton2;
@property(strong) NSArray *cerrarTecladoButtonsArray;


@property(assign) BOOL esAgregarFoto;


- (IBAction)irAtras:(id)sender;

- (IBAction)irADetalleFoto:(id)sender;

- (IBAction)irARechazar:(id)sender;

- (IBAction)irAAgregarFoto:(id)sender;
- (IBAction)irAAgregarRechazo:(id)sender;

- (IBAction)irAActualizar:(id)sender;



- (IBAction)irASeleccionarRazon:(id)sender;
- (IBAction)irASeleccionarTiempo:(id)sender;
- (IBAction)irACancelarRazon:(id)sender;
- (IBAction)irACancelarTiempo:(id)sender;

- (IBAction)irACerrarTeclados:(id)sender;


- (id)initEditarMiElefanteViewControllerParaElefante:(NSDictionary *)
infoElefante estadoEdicion:(MasInformacionEstado)estadoEdicion esMiElefante:(BOOL)esMio;



@end
