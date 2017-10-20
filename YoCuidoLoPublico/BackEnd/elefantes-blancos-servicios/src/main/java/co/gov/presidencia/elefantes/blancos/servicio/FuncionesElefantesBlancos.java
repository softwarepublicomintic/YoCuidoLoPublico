package co.gov.presidencia.elefantes.blancos.servicio;

import co.gov.presidencia.elefantes.blancos.dto.DetalleElefante;
import co.gov.presidencia.elefantes.blancos.dto.ElefanteBlanco;
import co.gov.presidencia.elefantes.blancos.dto.ElefanteMapa;
import co.gov.presidencia.elefantes.blancos.dto.ElefanteTop5;
import co.gov.presidencia.elefantes.blancos.dto.Imagen;
import co.gov.presidencia.elefantes.blancos.dto.Motivo;
import co.gov.presidencia.elefantes.blancos.dtorequest.ActualizacionElefanteRequestDto;
import co.gov.presidencia.elefantes.blancos.dtorequest.ImagenAsociadaRequestDto;
import co.gov.presidencia.elefantes.blancos.dto.Posicion;
import co.gov.presidencia.elefantes.blancos.dto.Rango;
//import co.gov.presidencia.elefantes.blancos.dtorequest.ElefanteBlancoRequestDto;
import co.gov.presidencia.elefantes.blancos.actualizacion.dtorequest.ElefanteBlancoRequestDto;
import co.gov.presidencia.elefantes.blancos.dtoresponse.CantidadRegionResponseDto;
import co.gov.presidencia.elefantes.blancos.actualizacion.ReportarLogica;
import co.gov.presidencia.elefantes.blancos.dtoresponse.ConsultarImagenResponseDto;
import co.gov.presidencia.elefantes.blancos.dtoresponse.ElefanteBlancoResponseDto;
import co.gov.presidencia.elefantes.blancos.dtoresponse.MiElefanteResponseDto;
import co.gov.presidencia.elefantes.blancos.util.ManejadorImagenes;

import java.awt.Image;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.ImageIcon;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.springframework.webflow.util.Base64;

/**
 *
 * @author Anibal Parra
 */
@Path("/YoCuidoLoPublico") //Se cambio el @Path("/ElefantesBlancos") por YoCuidoLoPublico
public class FuncionesElefantesBlancos {
    
    private InputStream imgStream;
    
    @GET
    @Path("/deuda")
    public String getDeuda(@QueryParam("codigo") String codigo){
        
        String retorno = "El alumno "+codigo+" tiene una deuda de $20.000";
        return retorno;
    }
    
    
    @GET
    @Path("/PorPosicion")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<ElefanteMapa> consultarPorPosicion(@QueryParam("lat") double latitud,
            @QueryParam("long") double longitud) throws Exception {
        
        Posicion posicion1 = new Posicion(4.734517, -74.067986);
        ElefanteMapa elefanteMapa1 = new ElefanteMapa(23, posicion1, "construccion coliseo republicano_", 1);
        
        Posicion posicion2 = new Posicion(4.712105, -74.072406);
        ElefanteMapa elefanteMapa2 = new ElefanteMapa(3, posicion2, "pavimentacion calle del comercio_", 2);
        
        List<ElefanteMapa> elefantesMapa = new ArrayList<ElefanteMapa>();
        elefantesMapa.add(elefanteMapa1);
        elefantesMapa.add(elefanteMapa2);
        
        return elefantesMapa;
    }
    
    
//    @POST
//    @Path("/PorPosicion")
//    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
//    public List<ElefanteBlanco> consultarPorPosicion2(Posicion posicion) throws Exception {
//
//        Posicion posicion1 = new Posicion(4.734517, -74.067986);
//        ElefanteBlanco elefanteBlanco1 = new ElefanteBlanco("2","coliseo norte_","11","11001",3,posicion1);
//        
//        Posicion posicion2 = new Posicion(4.712105, -74.072406);
//        ElefanteBlanco elefanteBlanco2 = new ElefanteBlanco("3","pavimentacion calle del comercio_","11","11001",4,posicion2);
//        
//        List<ElefanteBlanco> elefantesBlancos = new ArrayList<ElefanteBlanco>();
//        elefantesBlancos.add(elefanteBlanco1);
//        elefantesBlancos.add(elefanteBlanco2);
//        
//        return elefantesBlancos;
//    }
    
    @GET
    @Path("/DetalleElefante/{idElefante}")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public ElefanteBlanco detalleElefante(@PathParam("idElefante") Integer idElefante) throws Exception {
            
            List<Imagen> miniaturas = new ArrayList<Imagen>();
            
         ManejadorImagenes manejadorImagenes = new ManejadorImagenes();
         File file1 = new File("C://imagenes//bicentenario.jpg");
         String foto1 = manejadorImagenes.getImagenString(file1);
         File file2 = new File("C://imagenes//casa_justicia.jpg");
         String foto2 = manejadorImagenes.getImagenString(file2);
         File file3 = new File("C://imagenes//colegio.jpg");
         String foto3 = manejadorImagenes.getImagenString(file3);
         File file4 = new File("C://imagenes//comando_policia.jpg");
         String foto4 = manejadorImagenes.getImagenString(file4);
         File file5 = new File("C://imagenes//estacion_transmi.jpg");
         String foto5 = manejadorImagenes.getImagenString(file5);
            
            
            Imagen imagen1 = new Imagen();
            imagen1.setId(234);
            imagen1.setImagenGrande(5);
            imagen1.setMiniatura(foto1);
            Imagen imagen2 = new Imagen();
            imagen2.setId(21);
            imagen2.setImagenGrande(5);
            imagen2.setMiniatura(foto2);
            Imagen imagen3 = new Imagen();
            imagen3.setId(824);
            imagen3.setImagenGrande(5);
            imagen3.setMiniatura(foto3);
            Imagen imagen4 = new Imagen();
            imagen4.setId(24);
            imagen4.setImagenGrande(5);
            imagen4.setMiniatura(foto4);
            Imagen imagen5 = new Imagen();
            imagen5.setId(29);
            imagen5.setImagenGrande(5);
            imagen5.setMiniatura(foto5);
            
            miniaturas.add(imagen1);
            miniaturas.add(imagen2);
            miniaturas.add(imagen3);
            miniaturas.add(imagen4);
            miniaturas.add(imagen5);

            ElefanteBlanco elefanteBlanco = new ElefanteBlanco(28,"estacion de policia_","11","11001",
                    miniaturas,1,129,"policia nacional_",2,3,250000000,"ingenieros asociados s.a.",
                    231,"10/12/2013","se cambia titulo porque el anterior era muy ofensivo",0,1,2);
            
            
        
        return elefanteBlanco;
    }
    
    @PUT
    @Path("/ModificarReporte/{idElefante}")
    @Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public void modificarElefante(ActualizacionElefanteRequestDto datos){
        
    }
    
    @PUT
    @Path("/AsociarImagen/{idElefante}")
    @Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public void asociarImagen(ImagenAsociadaRequestDto imagen){ 
        
    }
    
    
    @GET
    @Path("/ConsultaDeptos/{idRegion}")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<String> consultarDepartamentos(@PathParam("idRegion") int idRegion) throws Exception {
        List<String> departamentos = new ArrayList<String>();
        if(idRegion == 1){ //atlantica
            departamentos.add("44"); //la guajira
            departamentos.add("47"); //magdalena
            departamentos.add("70"); //sucre
       }
       if(idRegion == 2){ //andina
            departamentos.add("05"); //antioquia
            departamentos.add("25"); //cundinamarca
            departamentos.add("73"); //tolima
       } 
       if(idRegion == 3){ //pacifica
            departamentos.add("19"); //cauca
            departamentos.add("27"); //choco
            departamentos.add("76"); //valle del cauca
       } 
        
        return departamentos;
    }

    @GET
    @Path("/ConsultaMunicipios/{idDepartamento}")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<String> consultarMunicipios(@PathParam("idDepartamento") int idDepartamento) throws Exception {
        List<String> municipios = new ArrayList<String>();
        if(idDepartamento == 5){ //antioquia
            municipios.add("05001"); //medellin
            municipios.add("05088"); //bello
            municipios.add("05266"); //envigado
       }
       if(idDepartamento == 25){ //cundinamarca
            municipios.add("25290"); //fusa
            municipios.add("25307"); //girardot
            municipios.add("25386"); //la mesa
       } 
       if(idDepartamento == 76){ //valle del cauca
            municipios.add("76001"); //cali
            municipios.add("76122"); //caicedonia
            municipios.add("76147"); //cartago
       } 
        
        return municipios;
    }
    
    @GET
    @Path("/MasVotados")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<ElefanteTop5> consultarTop5() throws Exception {
         List<ElefanteTop5> elefantes = new ArrayList<ElefanteTop5>();
         
//         //////////////////////////////////////////////////////////////////////////////////////
//         File imagen1 = new File("C://imagenes//comando_policia.jpg");
//         FileInputStream fin = new FileInputStream(imagen1);  
//         byte[] fileContent = new byte[(int) imagen1.length()];
//         fin.read(fileContent); 
//         String imagen = new Base64().encodeToString(fileContent);
//         //////////////////////////////////////////////////////////////////////////////////////
         
         ManejadorImagenes manejadorImagenes = new ManejadorImagenes();
         File file1 = new File("C://imagenes//bicentenario.jpg");
         String imagen1 = manejadorImagenes.getImagenString(file1);
         File file2 = new File("C://imagenes//casa_justicia.jpg");
         String imagen2 = manejadorImagenes.getImagenString(file2);
         File file3 = new File("C://imagenes//colegio.jpg");
         String imagen3 = manejadorImagenes.getImagenString(file3);
         File file4 = new File("C://imagenes//comando_policia.jpg");
         String imagen4 = manejadorImagenes.getImagenString(file4);
         File file5 = new File("C://imagenes//estacion_transmi.jpg");
         String imagen5 = manejadorImagenes.getImagenString(file5);
         
         ElefanteTop5 elefante1 = new ElefanteTop5(5,"construccion comando de policia_",
                 "11","11001",23,imagen1);
         ElefanteTop5 elefante2 = new ElefanteTop5(21,"construccion de coliseo diamante_",
                 "11","11001",159,imagen2);
         ElefanteTop5 elefante3 = new ElefanteTop5(36,"remodelacion parque el rocio_",
                 "05","05002",149,imagen3);
         ElefanteTop5 elefante4 = new ElefanteTop5(41,"adecuacion alcantarillado barrio la soledad_",
                 "11","11001",159,imagen4);
         ElefanteTop5 elefante5 = new ElefanteTop5(2,"construccion salon comunal barrio jazmin",
                 "11","11001",68,imagen5);
         
         elefantes.add(elefante1);
         elefantes.add(elefante2);
         elefantes.add(elefante3);
         elefantes.add(elefante4);
         elefantes.add(elefante5);
         
         return elefantes;
     }
   
    @POST
    @Path("/Reportar")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public co.gov.presidencia.elefantes.blancos.actualizacion.dtoresponse.ElefanteBlancoResponseDto reportar(ElefanteBlancoRequestDto elefante) throws Exception {
    	ReportarLogica ex = new ReportarLogica();
    	//ex.reportarElefante(elefante);
    	//Integer n = ex.reportarElefante(elefante);
    	//ElefanteBlancoResponseDto id = new ElefanteBlancoResponseDto(ex.reportarElefante(elefante));
    	return ex.reportarElefante(elefante);
    	//debe retornar el codigo http 201 en caso de exito en la transaccion  
//        URI uri = "http://localhost:8080/elefantes-blancos-servicios/Servicios/ElefantesBlancos/Reportar";
//        Response.created(http://localhost:8080/elefantes-blancos-servicios/Servicios/ElefantesBlancos/Reportar);
       
    }

    
    /*@GET
    @Path("/Votar")
    public void votar(@QueryParam("elefante") int elefante) throws Exception {
            
            //debe retornar el codigo http 201 en caso de exito en la transaccion
        
    }*/

    @GET
    @Path("/ConsultaRegion")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<CantidadRegionResponseDto> consultarRegiones() throws Exception {
            List<CantidadRegionResponseDto> cantidadesRegion = new ArrayList<CantidadRegionResponseDto>();
            CantidadRegionResponseDto cantidadRegion2 = new CantidadRegionResponseDto(2,19);
            CantidadRegionResponseDto cantidadRegion4 = new CantidadRegionResponseDto(4,8);
            CantidadRegionResponseDto cantidadRegion5 = new CantidadRegionResponseDto(5,3);
            
            cantidadesRegion.add(cantidadRegion2);
            cantidadesRegion.add(cantidadRegion4);
            cantidadesRegion.add(cantidadRegion5);
            
            return cantidadesRegion;
    }
    
    @GET
    @Path("/ConsultarImagen/{idGrande}")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public ConsultarImagenResponseDto consultarImagen(@PathParam("idGrande") int idGrande) throws Exception {

         ManejadorImagenes manejadorImagenes = new ManejadorImagenes();
         File file1 = new File("C://imagenes//comando_policia_gde.jpg");
         String imagen1 = manejadorImagenes.getImagenString(file1);
        
        
        return new ConsultarImagenResponseDto(imagen1);

    }

    @GET
    @Path("/ConsultarRangos")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<Rango> consultarRangos() throws Exception {
        
        List<Rango> rangos = new ArrayList<Rango>();
        Rango rango1 = new Rango("1", "De 1 a 5 años");
        Rango rango2 = new Rango("2", "De 6 a 10 años");
        Rango rango3 = new Rango("3", "De 11 a 15 años");
        Rango rango4 = new Rango("4", "De 16 a 20 años");
        
        rangos.add(rango1);
        rangos.add(rango2);
        rangos.add(rango3);
        rangos.add(rango4);
        
        return rangos;
    }

    @GET
    @Path("/ConsultarMotivos")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<Motivo> consultarMotivos() throws Exception {
        
        List<Motivo> motivos = new ArrayList<Motivo>();
        Motivo motivo1 = new Motivo("1", "Es una construcción abandonada_");
        Motivo motivo2 = new Motivo("2", "No se ha puesto en funcionamiento_");
        Motivo motivo3 = new Motivo("3", "Lleva más tiempo del presupuestado la construcción_");
        
        motivos.add(motivo1);
        motivos.add(motivo2);
        motivos.add(motivo3);
        
        return motivos;
    }
    
    @GET
    @Path("/ElefantesMunicipio")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<ElefanteMapa> consultarElefantesMunicipio(@QueryParam("codDep") String codDep,
            @QueryParam("codMun") String codMun) throws Exception {
        
        List<ElefanteMapa> elefantesMapa = new ArrayList<ElefanteMapa>();
        if(codDep.equals("25")){ //cundinamarca
            if(codMun.equals("290")){ //fusa
                Posicion posicion1 = new Posicion(4.380644, -74.352143);
                Posicion posicion2 = new Posicion(4.291636, -74.465439);
                Posicion posicion3 = new Posicion(4.279311, -74.358323);
                ElefanteMapa elefanteMapa1 = new ElefanteMapa(211, posicion1, "coliseo municipal_", 1);
                ElefanteMapa elefanteMapa2 = new ElefanteMapa(212, posicion2, "pavimentacion calle comercio_", 2);
                ElefanteMapa elefanteMapa3 = new ElefanteMapa(213, posicion3, "construccion alameda oriental_", 3);
                elefantesMapa.add(elefanteMapa1);
                elefantesMapa.add(elefanteMapa2);
                elefantesMapa.add(elefanteMapa3);
             }
            if(codMun.equals("307")){ //girardot
                Posicion posicion1 = new Posicion(4.396391, -74.77237);
                Posicion posicion2 = new Posicion(4.288897, -74.869187);
                ElefanteMapa elefanteMapa1 = new ElefanteMapa(31, posicion1, "construccion acueducto norte_", 1);
                ElefanteMapa elefanteMapa2 = new ElefanteMapa(32, posicion2, "construccion acueducto sur_", 3);
                elefantesMapa.add(elefanteMapa1);
                elefantesMapa.add(elefanteMapa2);
            }
        }
            
        return elefantesMapa;
    }
    
    @GET
    @Path("/ConsultarMiElefante/{idElefante}")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public MiElefanteResponseDto consultarMiElefante(@PathParam("idElefante") int idElefante) throws Exception {
            ManejadorImagenes manejadorImagenes = new ManejadorImagenes();
            File file = new File("C://imagenes//bicentenario.jpg");
            String miniatura = manejadorImagenes.getImagenString(file);
            MiElefanteResponseDto miElefante = new MiElefanteResponseDto("Comando de policia", miniatura, 32, 2L, 19L);

            return miElefante; 
    }
    
}

