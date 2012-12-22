package SE2.Swimv2.Session;

import java.util.Date;
import java.util.Set;

import javax.ejb.Remote;

import SE2.Swimv2.Entity.Skill;
import SE2.Swimv2.Entity.User;

@Remote
public interface GestoreUserRemote {

	public User addUser(String email, String password, String nome, String cognome, String provincia, char sesso, Date datanascita, Set<Skill> personalSkill);
	public void modificaEmail(User user, String email);
	public void modificaPassword(User user, String password);
	public void modificaAnagrafica(String nome, String cognome, String provincia, char sesso, Date datanascita);
}