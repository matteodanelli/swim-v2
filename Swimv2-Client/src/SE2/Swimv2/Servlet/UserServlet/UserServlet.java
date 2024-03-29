package SE2.Swimv2.Servlet.UserServlet;

import java.io.IOException;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import SE2.Swimv2.Entity.User;
import SE2.Swimv2.Session.GestoreMessaggiRemote;
import SE2.Swimv2.Session.GestoreRichiesteAiutoRemote;
import SE2.Swimv2.Session.GestoreRichiesteAmiciziaRemote;
import SE2.Swimv2.Session.GestoreUserRemote;
import SE2.Swimv2.Util.RemoteManager;

/**
 * Servlet implementation class UserServlet
 */
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	//nomi attributi
	private static final String ERROR = "Errore";
	private static final String USER= "user";
	private static final String RIC_AMICIZIA= "richiesteAmicizia";
	private static final String NEW_MEX= "newMess";
	private static final String NEW_AIUTO= "newHelp";
	private static final String USER_ID= "userId";
	
	//valori attributi
	private static final String LOGIN_ERROR= "logError";
	
	//nomi pagine
	private static final String HOME_PAGE = "index.jsp";
	private static final String USER_PAGE = "User/user.jsp";
	private static final String ERROR_PAGE = "error.jsp";
	

	private RemoteManager remoteManager= new RemoteManager();
	private GestoreUserRemote gestoreUser;
	private GestoreRichiesteAmiciziaRemote gestoreRichiesteAmicizia;
	private GestoreMessaggiRemote gestoreMessaggi;
	private GestoreRichiesteAiutoRemote gestoreRichiesteAiuto;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		//se non esiste una sessione richiamo l'home page
		Long id= (Long) request.getSession().getAttribute(USER_ID);
		if(id==null){
			request.setAttribute(ERROR, LOGIN_ERROR);
			request.getRequestDispatcher(HOME_PAGE).forward(request, response);
			return;
		}

		//imposto gli attributi messaggi/richieste aiuto/richieste messaggi

		try {
			gestoreUser = remoteManager.getGestoreUserRemote();
			gestoreRichiesteAmicizia = remoteManager.getGestoreRichiesteAmiciziaRemote();
			gestoreMessaggi= remoteManager.getGestoreMessaggiRemote();
			gestoreRichiesteAiuto= remoteManager.getGestoreRichiesteAiutoRemote();
		} catch (NamingException e) {
			response.sendRedirect(ERROR_PAGE);
			return;
		}	
		
		//SETTO ATTRIBUTO USER	
		User user= gestoreUser.getById(id.longValue());
		request.setAttribute(USER, user);
		
		//Setto attributo numero richieste amicizia
		Integer numRichiesteAmicizia= gestoreRichiesteAmicizia.elencoRichiesteAmicizia(id).size();
		request.setAttribute(RIC_AMICIZIA, numRichiesteAmicizia);
		
		//Setto attributo numero nuovi messaggi
		Integer numMex= gestoreMessaggi.verificaNuoviMessaggi(id);
		request.setAttribute(NEW_MEX, numMex);
		
		//Setto attributo numero nuove richieste aiuto
		Integer numRichiesteAiuto= gestoreRichiesteAiuto.verificaNuoveRichiesteAiuto(id);
		request.setAttribute(NEW_AIUTO, numRichiesteAiuto);

		request.getRequestDispatcher(USER_PAGE).forward(request, response);
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}
	
}
