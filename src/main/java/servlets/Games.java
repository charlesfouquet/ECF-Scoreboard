package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.GameDAO;

/**
 * Servlet implementation class Games
 */
@WebServlet("/games")
public class Games extends HttpServlet {
	private static final long serialVersionUID = 1L;
	GameDAO gameDAO = new GameDAO();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Games() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("id") != null) {
			if (request.getParameter("act").equals("delete")) {
				if (gameDAO.delete(new beans.Game(Integer.parseInt(request.getParameter("id"))))) {
					request.setAttribute("message", "Suppression effectuée !");
				} else {
					request.setAttribute("message", "Erreur lors de la suppression !");
				}
			} else if (request.getParameter("act").equals("update")) {
				request.setAttribute("gameToUpdate", gameDAO.findByID(Integer.parseInt(request.getParameter("id"))));
			}
		}
		request.setAttribute("listeJeux", gameDAO.read());
		request.getRequestDispatcher("/vue/games/games.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("idUpdate") != null) {
			if (gameDAO.update(new beans.Game(Integer.parseInt(request.getParameter("idUpdate")), request.getParameter("titleUpdate"), Integer.parseInt(request.getParameter("min_playersUpdate")), Integer.parseInt(request.getParameter("max_playersUpdate"))))) {
				request.setAttribute("message", "La mise à jour pour " + request.getParameter("titleUpdate") + " a bien été prise en compte !");
				doGet(request, response);
			}
		} else {
			if (gameDAO.create(new beans.Game(request.getParameter("title"), Integer.parseInt(request.getParameter("min_players")), Integer.parseInt(request.getParameter("max_players"))))) {
				request.setAttribute("message", "Le jeu " + request.getParameter("title") + " a bien été ajouté !");
				doGet(request, response);
			}			
		}
	}

}
