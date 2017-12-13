//
//  ListaElefanteCell.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 4/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaElefanteCell : UITableViewCell

@property(strong) IBOutlet UIImageView *fondoImage;
@property(strong) IBOutlet UIImageView *fotoImage;
@property(strong) IBOutlet UIImageView *flechaImage;
@property(strong) IBOutlet UILabel *nombreLabel;
@property(strong) IBOutlet UILabel *rechazosLabel;
@property(strong) IBOutlet UILabel *rechazosTituloLabel;
@property(strong) IBOutlet UILabel *infoLabel;

@property(strong) IBOutlet UIView *estadoContenedor;
@property(strong) IBOutlet UILabel *estadoLabel;
@property(strong) IBOutlet UIImageView *estadoImage;

@end
