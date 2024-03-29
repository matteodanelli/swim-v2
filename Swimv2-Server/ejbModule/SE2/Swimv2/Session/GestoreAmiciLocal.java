package SE2.Swimv2.Session;

import java.util.List;
import javax.ejb.Local;

import SE2.Swimv2.Entity.User;
import SE2.Swimv2.Exceptions.AmiciException;

@Local
public interface GestoreAmiciLocal {
	public void aggiungiAmicizia(long idUser1,long idUser2) throws AmiciException;
	public Boolean verificaAmicizia(long idUser1,long idUser2);
	public List<User> elencoAmici(long idUser);
}
