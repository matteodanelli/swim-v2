<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="SE2.Swimv2.Entity.*"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<title>Swimv2</title>
	 
	<style type="text/css">
		@import url(/Swimv2-Client/css/main.css);
		@import url(/Swimv2-Client/css/form.css);
	</style>
	<script type="text/javascript" src="/Swimv2-Client/js/user.js"></script>
	</head>

  <body>
	<%
	//verifico sessione
	Long id= (Long) request.getSession().getAttribute("userId");
	if(id==null){
		request.setAttribute("Errore", "logError");
		request.getRequestDispatcher("/index.jsp").forward(request, response);
		return;
	}
	
	%>
	<div class="header">
		<div class="content">
	  		<a class="logo" href="/Swimv2-Client/index.jsp">
	  			<img alt="Swimv2" src="/Swimv2-Client/img/logo.gif" width="320" height="60">
	  		</a>
	  		
	  		<span class="page_title">
					Search User
		  	</span>
	  		
  		</div>
 	</div>
 	
 	<div class="menu_bar">
		<div class="content">
			<ul id="menu">
				<li><a class="first" href="/Swimv2-Client/UserServlet">Home Page</a></li>
				<li><a href="/Swimv2-Client/ProfiloServlet?userId=<%out.print(id);%>">Profilo</a></li>
				<li><a href="/Swimv2-Client/RicercaUtentiUserServlet">Cerca Utente</a></li>
				<li><a href="/Swimv2-Client/AmiciUserServlet">Visualizza Amici</a></li>
				<li><a href="/Swimv2-Client/ModificaDatiServlet">Modifica Dati</a></li>
				<li><a href="/Swimv2-Client/PersonalSkillServlet">Modifica Skills</a></li>
				<li><a href="/Swimv2-Client/ProponiAbilitaServlet">Proponi Abilità</a></li>
				<li><a href="/Swimv2-Client/LogoutServlet">Logout</a></li>
			</ul>
		</div>		
	</div>	
 	
 		
 	<div class="wrapper">
	  <div class="margintop content">
	  
	  		<div class="box">
	  			<div class="box_title">
					Cerca Utenti
				</div>
	  			
		  		<div class="box_contents">
		  			<div class="elenco">
		  				<h3>Ricerca per Nominativo:</h3>
						<form class="form" name="form1" action="/Swimv2-Client/RicercaUtentiUserServlet?type=nominativo" method="post" onsubmit="return validateFormCercaNominativo();">
							<label>Nome: </label>
							<input type="text" name="nome">
							<br>
							<label>Cognome: </label>
							<input type="text" name="cognome">
							<br>
							<br>
							<input name="ricercaAmici" type="checkbox" value="1">Ricerca solo tra utenti amici
							<br>
							<p class="link_right_align"> <input type="submit" value="Cerca"></p>
						</form>
	
					</div>

		  			<div class="elenco">
		  				<h3>Ricerca per Skill:</h3>
						<form class="form" name="form2" action="/Swimv2-Client/RicercaUtentiUserServlet?type=skill" method="post" onsubmit="return validateFormCercaSkill();">
							<label>Skill: </label>
							<input type="text" name="skill">
							<br>
							<br>
							<input name="ricercaAmici" type="checkbox" value="1">Ricerca solo tra utenti amici
							<br>
							<p class="link_right_align"> <input type="submit" value="Cerca"></p>
						</form>

					</div>
							
				</div>	
	  		</div>
 
			<%
			@SuppressWarnings("unchecked")
			List<User> risultati= (List<User>) request.getAttribute("RisultatiRicerca");
			String mex= (String) request.getAttribute("Messaggio");

			
			if(risultati!=null && mex==null){

				for(User user:risultati){
					
					%>

					<div class="elenco">
					<h3>User:</h3>
						<ul>
							<li><b>Nome:</b> <% out.println(user.getNome());%></li>
							<li><b>Cognome:</b> <% out.println(user.getCognome());%></li>
							<%if(user.getProvincia()!=null){ %>
								<li><b>Provincia:</b> <% out.println(user.getProvincia());%></li>
							<%}%>
						</ul>
						<p class="link_right_align"><a href="<% out.println("/Swimv2-Client/ProfiloServlet?userId="+user.getId());%>">Visualizza Profilo</a></p>
					</div>
					
					<%
					
				}
			}
			
			if(mex!=null){
				out.println("<br><p>"+ mex +"</p>");
			}
				
			%>

	  </div>
	</div>
  
  </body>
</html>
