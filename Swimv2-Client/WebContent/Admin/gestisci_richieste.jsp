<%@page import="SE2.Swimv2.Exceptions.RichiesteSkillException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="SE2.Swimv2.Entity.*"%>
<%@ page import="java.util.List;"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<title>Swimv2</title>
	 
	<style type="text/css">
		@import url(/Swimv2-Client/css/main.css);

	form {	
	display: inline	
	}
	</style>
	</head>

  <body>

	<div class="header">
		<div class="content">
	  		<a class="logo" href="/Swimv2-Client/index.jsp">
	  			<img alt="Swimv2" src="/Swimv2-Client/img/logo.gif" width="320" height="60">
	  		</a>
	  		
	  		<span class="page_title">
					Gestione Richieste
		  	</span> 		
  		</div>
 	</div> 	
 	
 		<div class="menu_bar">
		<div class="content">
			<ul id="menu">
				<li><a class="first" href="/Swimv2-Client/AdminServlet">Home Page</a></li>
				<li><a href="/Swimv2-Client/AggiungiSkillServlet">Aggiungi Skill</a></li>
				<li><a href="/Swimv2-Client/ModificaPasswordAdminServlet">Modifica password</a></li>
				<li><a href="LogoutServlet">Logout</a></li>
			</ul>
		</div>		
	</div>
	
	<div class="wrapper">
	  <div class="margintop content">
	  <% 
	  //Controllo se esiste la sessione
	  Long id = (Long) request.getSession().getAttribute("adminId");
	  if (id==null) {
			request.setAttribute("Errore", "logError");
			request.getRequestDispatcher("/index.jsp").forward(request, response);
			return;
		}
	  
	  //Controlla se la lista ottenuta dalla servlet è nulla
	  	@SuppressWarnings("unchecked")
		List<RichiestaSkill> elenco = (List<RichiestaSkill>)request.getAttribute("richieste");
		if(elenco== null) {
			response.sendRedirect("/Swimv2-Client/error.jsp");
			return;
		}
	  %>
				<div class="box margintop">
			  			<div class="box_title">
							Nuove Richieste
						</div>
	  		
				  		<div class="box_contents">
				  		
							<% for (RichiestaSkill richiesta : elenco) { 
								long idRichiesta =richiesta.getId();
								%>
								<div class="elenco">
								<%
								out.println("<p><b>Skill proposta: </b>"+richiesta.getSkillRichiesta()+"</p>");
								%> 
						
									<div class="link_right_align">
										<form class="form" action="/Swimv2-Client/RichiesteAggiuntaSkillServlet" method="post">
											<input type="hidden" name="scelta" value="a" >
											<input type="hidden" name="id" value="<%out.print(idRichiesta); %>">
											<input type="submit" value="Accetta!">
			    						</form> 
										
										<form class="form" action="/Swimv2-Client/RichiesteAggiuntaSkillServlet" method="post">
											<input type="hidden" name="scelta" value="r">
											<input type="hidden" name="id" value="<%out.print(idRichiesta); %>">
											<input type="submit" value="Rifiuta!">
										</form>
									</div> 
								</div> 					
								<%
							}
							
							if(elenco.size()==0){
								out.println("<br><p>Non ci sono richieste</p>");
							}
							%> 
							
	  					</div>
	  				</div>
			</div>
	</div>
	
	
</body>
</html>