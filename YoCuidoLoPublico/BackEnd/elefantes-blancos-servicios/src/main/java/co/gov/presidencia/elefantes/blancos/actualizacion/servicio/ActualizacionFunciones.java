/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.actualizacion.servicio;

import co.gov.presidencia.elefantes.blancos.actualizacion.ActualizarLogica;
import co.gov.presidencia.elefantes.blancos.actualizacion.ReportarLogica;
import co.gov.presidencia.elefantes.blancos.actualizacion.dtorequest.ElefanteBlancoRequestDto;
import co.gov.presidencia.elefantes.blancos.actualizacion.dtorequest.ImagenAsociadaRequestDto;
import co.gov.presidencia.elefantes.blancos.actualizacion.dtorequest.ModificarElefanteRequestDto;
import co.gov.presidencia.elefantes.blancos.actualizacion.dtoresponse.ElefanteBlancoResponseDto;
import co.gov.presidencia.elefantes.blancos.actualizacion.dtoresponse.RegistrarVotoResponseDto;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author farevalo
 */
@Path("/Actualizar")
public class ActualizacionFunciones {
    
    
    @POST
    @Path("/Reportar")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public ElefanteBlancoResponseDto reportarElefante(ElefanteBlancoRequestDto elefante) throws Exception {
        return new ReportarLogica().reportarElefante(elefante);
    }

    @GET
    @Path("/RegistrarVoto/{idElefante}")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public RegistrarVotoResponseDto registrarVoto(@PathParam("idElefante") long idElefante) throws Exception {
        return new ActualizarLogica().registrarVoto(idElefante);
    }        
//    
//    @GET
//    @Path("/DetalleBasicoElefante/{idElefante}")
//    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
//    public DetalleBasicoElefanteDto detalleBasicoElefante(@PathParam("idElefante") long idElefante) throws Exception {
//        return new ConsultarLogica().detalleBasicoElefante(idElefante);
//    }        
//    
    @PUT
    @Path("/ModificarReporte/{idElefante}")
    @Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public void actualizarElefante(ModificarElefanteRequestDto input, @PathParam ("idElefante") Long idElefante) throws Exception {
        input.setIdElefante(idElefante);
        new ActualizarLogica().actualizarElefante(input);
    }  
    
    @POST
    @Path("/AsociarImagen")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public void asociarImagen(ImagenAsociadaRequestDto input) throws Exception {
        new ActualizarLogica().asociarImagen(input);
    }       
    
}
