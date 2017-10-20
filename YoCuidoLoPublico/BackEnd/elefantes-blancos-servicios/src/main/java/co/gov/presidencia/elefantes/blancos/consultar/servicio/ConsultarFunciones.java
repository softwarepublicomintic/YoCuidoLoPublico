/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.consultar.servicio;

import co.gov.presidencia.elefantes.blancos.consultar.ConsultarLogica;
import co.gov.presidencia.elefantes.blancos.consultar.dto.DetalleBasicoElefanteDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.DetalleElefanteDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.ElefanteMapaDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.ElefanteMasVotadoDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.ElefanteMunicipioDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.MotivoDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.MunicipioMapa;
import co.gov.presidencia.elefantes.blancos.consultar.dto.RangoTiempoDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.RegionDto;
import co.gov.presidencia.elefantes.blancos.consultar.dtoresponse.ImagenReponseDto;
import java.util.List;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author farevalo
 */
@Path("/Consultar")
public class ConsultarFunciones {

    @GET
    @Path("/DetalleCuidoLoPublico/{idCuidoLoPublico}")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public DetalleElefanteDto detalleCuidoLoPublico(@PathParam("idCuidoLoPublico") long idElefante) throws Exception {
        return new ConsultarLogica().detalleLoPublico(idElefante);
    }

    @GET
    @Path("/DetalleBasicoCuidoLoPublico/{idCuidoLoPublico}")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public DetalleBasicoElefanteDto detalleBasicoCuidoLoPublico(@PathParam("idCuidoLoPublico") long idElefante) throws Exception {
        return new ConsultarLogica().detalleBasicoLoPublico(idElefante);
    }

    @GET
    @Path("/ImagenCuidoLoPublico/{idImagen}")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public ImagenReponseDto consultarImagen(@PathParam("idImagen") long idImagen) throws Exception {
        return new ConsultarLogica().consultarImagen(idImagen);
    }

    @GET
    @Path("/CuidoLoPublicoMasVotados")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<ElefanteMasVotadoDto> CuidoLoPublicoMasVotados() throws Exception {
        return new ConsultarLogica().loPublicoMasVotados();
    }

    @GET
    @Path("/CuidoLoPublicoPorRegion")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<RegionDto> cuidoLoPublicoPorRegion() throws Exception {
        return new ConsultarLogica().loPublicoPorRegion();
    }

    @GET
    @Path("/DepartamentosPorRegion/{idRegion}")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<String> departamentosPorRegion(@PathParam("idRegion") long idRegion) throws Exception {
        return new ConsultarLogica().departamentosPorRegion(idRegion);
    }

    @GET
    @Path("/MunicipiosPorDepartamento/{idDepartamento}")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<MunicipioMapa> municipiosPorDepartamento(@PathParam("idDepartamento") String idDepartamento) throws Exception {
        return new ConsultarLogica().municipiosPorDepartamento(idDepartamento);
    }

    @GET
    @Path("/CuidoLoPublicoPorMunicipio/{idMunicipio}")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<ElefanteMunicipioDto> cuidoLoPublicoPorMunicipio(@PathParam("idMunicipio") String idMunicipio) throws Exception {
        return new ConsultarLogica().loPublicoPorMunicipio(idMunicipio);
    }

    @GET
    @Path("/RangosDeTiempo")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<RangoTiempoDto> rangosDeTiempo() throws Exception {
        return new ConsultarLogica().rangosDeTiempo();
    }

    @GET
    @Path("/MotivosCuidoLoPublico")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<MotivoDto> motivosCuidoLoPublico() throws Exception {
        return new ConsultarLogica().motivosCuidoLoPublico();
    }

    @GET
    @Path("/CuidoLoPublicoPorPosicion")
    @Produces(MediaType.APPLICATION_JSON + ";charset=UTF-8")
    public List<ElefanteMapaDto> cuidoLoPublico(@QueryParam("latitud") Double latitud,
            @QueryParam("longitud") Double longitud) throws Exception {
        return new ConsultarLogica().loPublicoPorPosicion(latitud, longitud);
    }
}
