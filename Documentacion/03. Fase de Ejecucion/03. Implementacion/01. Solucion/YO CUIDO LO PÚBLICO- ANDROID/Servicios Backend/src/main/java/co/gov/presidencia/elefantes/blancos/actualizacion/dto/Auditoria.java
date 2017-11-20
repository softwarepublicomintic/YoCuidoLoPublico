/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.actualizacion.dto;

import co.gov.presidencia.elefantes.blancos.actualizacion.ReportarLogica;
import co.gov.presidencia.elefantes.blancos.conexion.ConexionBD;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author farevalo
 */
public class Auditoria {
    
    public static void registrarAuditoria(int accion, int idElefante, int tipo, String datos, String titulo) throws Exception{
        ResultSet rs = null;
        String sql = "INSERT INTO stra_auditoria (id_stra_accion,id_stra_elefante,id_stra_usuario,id_stra_tipo,datos,usuario,titulo,fecha_creacion) values (?,?,?,?,?,?,?,?)";

        Connection con = null;
        try {
            con = ConexionBD.getDataSourceAuditoria().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setInt(1, accion);
            callableStatement.setInt(2, idElefante);
            callableStatement.setInt(3, 0);
            callableStatement.setInt(4, tipo);
            callableStatement.setString(5, datos);
            callableStatement.setString(6, "Móvil");
            callableStatement.setString(7, titulo);
            
            SimpleDateFormat formatter  = new SimpleDateFormat("yyyy-MM-dd H:mm:ss");             
            callableStatement.setString(8, formatter.format(new java.sql.Date(new Timestamp(System.currentTimeMillis()).getTime())));            
            
            callableStatement.execute();
            con.close();
        } catch (Exception ex) {
            Logger.getLogger(Auditoria.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(Auditoria.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }        
    }    
    
}
