/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.conexion;

import java.sql.Connection;
import java.sql.DriverManager;

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InitialContext;
import javax.sql.DataSource;


/**
 *
 * @author farevalo
 */
public class ConexionBD {
    
    public static DataSource getDataSource() throws Exception {
        DataSource ds;
        InitialContext cxt = new InitialContext();

        ds = (DataSource) cxt.lookup("java:/comp/env/jdbc/elefantesblancos-preproduccion");

       // ds = (DataSource) cxt.lookup("jdbc:mysql://localhost:3306/elefantesblancos-preproduccion?zeroDateTimeBehavior=convertToNull");
//        ds = (DataSource) cxt.lookup("java:/comp/env/jdbc/elefantesblancosDBPruebasInterventoria");
//        ds = (DataSource) cxt.lookup("java:/comp/env/jdbc/elefantesblancosDBPruebasInternas");
        //ds = (DataSource) cxt.lookup("java:/comp/env/jdbc/elefantesblancosDBDesarrollo");
        //ds = (DataSource) cxt.lookup("java:/comp/env/jdbc/elefantesblancosDB");

        if (ds == null) {
            throw new Exception("Data source not found!");
        }
        return ds;
    }
    
        public static DataSource getDataSourceAuditoria() throws Exception {
        DataSource ds;
        InitialContext cxt = new InitialContext();

        ds = (DataSource) cxt.lookup("java:/comp/env/jdbc/elefantesblancosDB-auditoria");
        //ds = (DataSource) cxt.lookup("java:/comp/env/jdbc/elefantesblancosDBPreProduccion-auditoria");      
//        ds = (DataSource) cxt.lookup("java:/comp/env/jdbc/elefantesblancosDBPruebasInterventoria-auditoria");
//        ds = (DataSource) cxt.lookup("java:/comp/env/jdbc/elefantesblancosDBPruebasInternas-auditoria");          
        //ds = (DataSource) cxt.lookup("java:/comp/env/jdbc/elefantesblancosDBDesarrollo-auditoria");
        //ds = (DataSource) cxt.lookup("java:/comp/env/jdbc/elefantesblancosDB");

        if (ds == null) {
            throw new Exception("Data source not found!");
        }
        return ds;
    }
}
