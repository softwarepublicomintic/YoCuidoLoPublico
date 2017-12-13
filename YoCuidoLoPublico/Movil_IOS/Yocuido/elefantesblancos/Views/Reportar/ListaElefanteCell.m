//
//  ListaElefanteCell.m
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 4/12/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import "ListaElefanteCell.h"

@implementation ListaElefanteCell

@synthesize fondoImage;
@synthesize fotoImage;
@synthesize flechaImage;
@synthesize nombreLabel;
@synthesize rechazosLabel;
@synthesize rechazosTituloLabel;
@synthesize infoLabel;
@synthesize estadoContenedor;
@synthesize estadoLabel;
@synthesize estadoImage;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
