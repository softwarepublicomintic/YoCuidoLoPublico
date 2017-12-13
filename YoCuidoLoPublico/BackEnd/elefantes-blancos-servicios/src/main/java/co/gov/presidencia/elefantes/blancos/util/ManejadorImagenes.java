package co.gov.presidencia.elefantes.blancos.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.webflow.util.Base64;

/**
 *
 * @author Anibal Parra
 */
public class ManejadorImagenes {

    public String getImagenString(File archivo){
        FileInputStream fin = null;
        try {
            fin = new FileInputStream(archivo);
            byte[] fileContent = new byte[(int) archivo.length()];
            fin.read(fileContent);
            String imagen = new Base64().encodeToString(fileContent);
            return imagen;
        } catch (FileNotFoundException ex) {
            Logger.getLogger(ManejadorImagenes.class.getName()).log(Level.SEVERE, null, ex);
            return "";
        } catch (IOException ex) {
            Logger.getLogger(ManejadorImagenes.class.getName()).log(Level.SEVERE, null, ex);
            return "";
        } finally {
            try {
                fin.close();
            } catch (IOException ex) {
                Logger.getLogger(ManejadorImagenes.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
