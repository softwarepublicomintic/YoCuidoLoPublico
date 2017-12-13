//
//  Definiciones.h
//  elefantesblancos
//
//  Created by Ihonahan Buitrago on 25/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSData+Base64.h"


#define ALTURA_VENTANA                                  [[UIScreen mainScreen] bounds].size.height
#define DENSIDAD_PIXEL                                  [UIScreen mainScreen].scale

#define ACERCA_DE_ELEMENTOS                             3

#define ACERCA_DE_ELEMENTO_COMO_USAR                    0
#define ACERCA_DE_ELEMENTO_AVISO_LEGAL                  1
#define ACERCA_DE_ELEMENTO_SOBRE_APLICACION             2

#define FUENTE_ACERCA_DE_ELEMENTO(__SIZE__)             [UIFont fontWithName:@"Verdana" size:__SIZE__]

#define ALTURA_TECLADO                                  200.0

#define GET_USERDEFAULTS(__KEY__)                       [[NSUserDefaults standardUserDefaults] valueForKey:__KEY__]
#define SET_USERDEFAULTS(__KEY__, __VALUE__)            [[NSUserDefaults standardUserDefaults] setValue:__VALUE__ forKey:__KEY__]
#define GET_OBJETO_USERDEFAULTS(__KEY__)                [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]
#define SET_OBJETO_USERDEFAULTS(__KEY__, __VALUE__)     [[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__]
#define SYNC_USERDEFAULTS                               [[NSUserDefaults standardUserDefaults] synchronize]

#define RUTA_DOCUMENTOS                                 [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define RUTA_CACHE                                      ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0])

#define GRADOS_A_RADIANES(__x__)                        (M_PI * __x__ / 180.0)

#define ES_VERSION_SISTEMA_MAYOR(__v__)                 ([[[UIDevice currentDevice] systemVersion] compare:__v__ options:NSNumericSearch] == NSOrderedDescending)
#define ES_IPAD                                         ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define ES_IPHONE                                       ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define ES_IPHONE_5                                     (ES_IPHONE && ([[UIScreen mainScreen] bounds].size.height > 480.0))

#define BOGOTA_CENTRO_LAT                               4.547677
#define BOGOTA_CENTRO_LON                               -74.033432


#define ES_PRIMERA_EJECUCION                            @"app_primera_ejecucion"


#define ESTADO_ELEFANTE_PENDIENTE                       1
#define ESTADO_ELEFANTE_APROBADO                        2
#define ESTADO_ELEFANTE_NO_APROBADO                     3


#define NOTIFICACION_UBICACION_GPS                      @"notificacion_ubicacion_gps"
#define NOTIFICACION_GPS_ERROR                          @"notificacion_gps_error"


#define USUARIO_MIS_ELEFANTES                           @"usuario_mis_elefantes"
#define USUARIO_ELEFANTES_VOTADOS                       @"usuario_elefantes_votados"

#define TEXTO_PENDIENTE                                 @"Pendiente"
#define TEXTO_APROBADO                                  @"Validado"
#define TEXTO_RECHAZADO                                 @"Rechazado"


#define DISTANCIA_MINIMA_FOTO                           500
#define DISTANCIA_PASO_MAPA                             3000


#define AGREGAR_OBSERVADOR_UBICACION(__observador__, __selector__) [[NSNotificationCenter defaultCenter] addObserver:__observador__ selector:__selector__ name:NOTIFICACION_UBICACION_GPS object:nil]

#define AGREGAR_OBSERVADOR_ERROR_UBICACION(__observador__, __selector__) [[NSNotificationCenter defaultCenter] addObserver:__observador__ selector:__selector__ name:NOTIFICACION_GPS_ERROR object:nil]

#define REMOVER_OBERVADOR_UBICACION(__observador__) [[NSNotificationCenter defaultCenter] removeObserver:__observador__]


typedef void (^crearBloque)(NSDictionary *elefanteDic, NSError *error);

typedef void (^agregarFotoBloque)(BOOL agregado, NSError *error);


/*!
 @protocol AcercaDeMenuViewDelegate
 @abstract
 Protocolo para instanciar y declarar delegados que respondan a los eventos
 generados desde el menú de Acerca De.
 */
@protocol AcercaDeMenuViewDelegate <NSObject>

@optional

/*!
 @method acercaDe: seleccionarElemento:
 @abstract
 Declaración de desencadenador del protocolo AcercaDeMenuViewDelegate para
 lanzarse cuando la vista desplegable Acerca De seleccione alguno de sus
 elementos y así informar al contenedor o supervista de lo ocurrido.
 
 @param sender
 Apuntador tipo id que será el objeto que lanzó el método del evento.
 
 @param elemento
 Índice seleccionado de la lista que corresponde al elemento asociado
 a la definición de los elementos del menú Acerca De.
 */
- (void)acercaDe:(id)sender seleccionarElemento:(int)elemento;

@end





@interface Definiciones : NSObject



/*!
 @method validarCorreoElectronico:
 @abstract
 Valida la cadena dada contra la expresión regular de correo electrónico
 y devuelve si es correcta o no.
 
 @param candidato
 Cadena de caracteres que será evaluada.
 */
+ (BOOL)validarCorreoElectronico:(NSString *)candidato;


/*!
 @method validarCadenaNumerica:
 @abstract
 Valida la cadena dada para evaluar si es numérica
 y devuelve si es correcta o no.
 
 @param candidato
 Cadena de caracteres que será evaluada.
 */
+ (BOOL)validarCadenaNumerica:(NSString *)candidato;


/*!
 @method validarCadenaCaracteresValidos:
 @abstract
 Valida la cadena dada para revisar que tenga caracteres especiales
 y devuelve si es correcta o no.
 
 @param candidato
 Cadena de caracteres que será evaluada.
 */
+ (BOOL)validarCadenaCaracteresValidos:(NSString *)candidato;


/*!
 @method validarCadenaCaracteres: contraRegEx:
 @abstract
 Valida la cadena dada contra la expresión regular dada
 y devuelve si es correcta o no.
 
 @param candidato
 Cadena de caracteres que será evaluada.
 
 @param regex
 Expresión regular para evaluar al candidato.
 */
+ (BOOL)validarCadenaCaracteres:(NSString *)candidato contraRegEx:(NSString *)regex;


/*!
 @method sharedImagenAncho
 @abstract
 Método shared que devuelve el singleton que contiene el valor
 del ancho de las imágenes.
 */
+ (NSString *)sharedImagenAncho;


/*!
 @method imagenDesdeImagen: conNuevoTamano:
 @abstract
 Método shared que devuelve el singleton que contiene el valor
 del alto de las imágenes.
 */
+ (NSString *)sharedImagenAlto;

/*!
 @method sharedUrlServidor
 @abstract
 Método shared que devuelve el singleton que contiene la URL
 del servidor de back-end.
 */
+ (NSString *)sharedUrlServidor;



/*!
 @method sharedAPIKeyGoogleMaps
 @abstract
 Método shared que devuelve el singleton que contiene el API
 Key del servicio de Google Maps.
 */
+ (NSString *)sharedAPIKeyGoogleMaps;

/*!
 @method sharedServicioElefantesPorRegion
 @abstract
 Método shared que devuelve el singleton que contiene la 
 ruta del servicio que devuelve los elefantes y regiones.
 */
+ (NSString *)sharedServicioElefantesPorRegion;

/*!
 @method sharedServicioDepartamentosPorRegion
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio que devuelve los departamentos de una región.
 */
+ (NSString *)sharedServicioDepartamentosPorRegion;

/*!
 @method sharedServicioMunicipiosPorDepartamento
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio que devuelve los municipios por departamento.
 */
+ (NSString *)sharedServicioMunicipiosPorDepartamento;

/*!
 @method sharedServicioElefantesProMunicipio
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio que devuelve los elefantes por posición.
 */
+ (NSString *)sharedServicioElefantesPorPosicion;

/*!
 @method sharedServicioDetalleElefante
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio que devuelve el detalle del elefante dado.
 */
+ (NSString *)sharedServicioDetalleElefante;

/*!
 @method sharedServicioMasVotados
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio que devuelve la lista de elefantes más votados.
 */
+ (NSString *)sharedServicioMasVotados;

/*!
 @method sharedServicioCrearElefante
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio con el que se crea un nuevo Elefante Blanco.
 */
+ (NSString *)sharedServicioCrearElefante;


/*!
 @method sharedServicioConsultaElefantesPorDeptoYMUnicipio
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio para listar los elefantes blancos de un 
 municipio y departamento dado
 */
+ (NSString *)sharedServicioConsultaElefantesPorDeptoYMUnicipio;


/*!
 @method sharedServicioAgregarFoto
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio para agregar una foto a un elefante dado
 */
+ (NSString *)sharedServicioAgregarFoto;


/*!
 @method sharedServicioVotoRechazo
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio para votar rechazando un elefante reportado
 */
+ (NSString *)sharedServicioVotoRechazo;


/*!
 @method sharedServicioRazonesElefantes
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio para listar las razones de reporte
 de un elefante blanco
 */
+ (NSString *)sharedServicioRazonesElefantes;


/*!
 @method sharedServicioRangosTiempo
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio para listar los rangos de tiempos
 para los reportes
 */
+ (NSString *)sharedServicioRangosTiempo;


/*!
 @method sharedServicioConsultarMiElefante
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio para obtener un elefante creado por mí
 */
+ (NSString *)sharedServicioConsultarMiElefante;


/*!
 @method sharedServicioConsultarImagenGrande
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio para la imagen grande dada por el id
 */
+ (NSString *)sharedServicioConsultarImagenGrande;


/*!
 @method sharedServicioModificarElefante
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio para modificar un elefante dado
 */
+ (NSString *)sharedServicioModificarElefante;


/*!
 @method sharedGeoUrlServidor
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta base del servidor de Servicios de Información Geográfica
 */
+ (NSString *)sharedGeoUrlServidor;

/*!
 @method sharedGeoServicioGeoReferencia
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio que geo-referencia una ubicación natural.
 */
+ (NSString *)sharedGeoServicioGeoReferencia;


/*!
 @method sharedGeoServicioGeoInverso
 @abstract
 Método shared que devuelve el singleton que contiene la
 ruta del servicio que geo-referencia de manera inversa
 una ubicación por coordenadas GPS.
 */
+ (NSString *)sharedGeoServicioGeoInverso;


/*!
 @method base64DeData
 @abstract
 Método shared que devuelve una cadena string Base64 a partir
 de la data dada.
 
 @param data
 Objeto de tipo NSData que contiene la información a ser convertida.
 */
+ (NSString*)base64DeData:(NSData*)data;


/*!
 @method sharedImagenAncho
 @abstract
 Método shared que devuelve una nueva imagen a partir de la imagen dada,
 usualmente para escalarla o cambiarle el tamaño.
 
 @param imagen
 Objeto de tipo UIImage que contiene la imagen original.
 
 @param nuevoTamano
 Estructura CGSize que contiene el nuevo tamaño de la imagen resultado.
 */
+ (UIImage *)imagenDesdeImagen:(UIImage *)imagen conNuevoTamano:(CGSize)nuevoTamano;



@end
