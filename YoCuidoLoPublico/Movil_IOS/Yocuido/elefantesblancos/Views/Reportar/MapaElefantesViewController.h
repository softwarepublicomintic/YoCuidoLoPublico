//
//  MapaElefantesViewController.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 28/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GoogleMaps/GoogleMaps.h>
#import <GoogleMaps/GMSMarker.h>

#import "Definiciones.h"
#import "AlertaMensajeView.h"


@interface MapaElefantesViewController : UIViewController <GMSMapViewDelegate, AlertaMensajeViewDelegate>{
    int numeroElefantes;
}

@property(strong) IBOutlet UIView *contenedorTotal;

@property(strong) IBOutlet UIView *mapaContendor;

@property(strong) IBOutlet UIButton *atrasButton;
@property(strong) IBOutlet UIButton *ubicarmeButton;
@property(strong) IBOutlet UIButton *reportarButton;

@property(strong) GMSMapView *mapaGoogle;

@property(strong) IBOutlet UIView *burbujaContenedor;
@property(strong) IBOutlet UIImageView *burbujaImage;
@property(strong) IBOutlet UIButton *detalleElefanteButton;
@property(strong) IBOutlet UILabel *burbujaTituloLabel;



- (IBAction)irAtras:(id)sender;

- (IBAction)irAUbicarme:(id)sender;
- (IBAction)irAReportar:(id)sender;

- (id)initMapaElefantesViewControllerConElefantes:(NSArray *)nuevosElefantes municipioLatitud:(CGFloat)municipioLatitud municipioLongitud:(CGFloat)municipioLongitud;
- (id)initMapaElefantesViewControllerReportando;
- (id)initMapaElefantesViewControllerConsultandoLatitud:(CGFloat)nuevaLat yLongitud:(CGFloat)nuevaLon;


@end
