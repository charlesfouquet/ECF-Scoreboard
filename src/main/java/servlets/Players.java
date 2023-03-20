package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.PlayerDAO;

/**
 * Servlet implementation class Players
 */
@WebServlet("/players")
public class Players extends HttpServlet {
	private static final long serialVersionUID = 1L;
	PlayerDAO playerDAO = new PlayerDAO();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Players() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("id") != null) {
			if (request.getParameter("act").equals("delete")) {
				if (playerDAO.delete(new beans.Player(Integer.parseInt(request.getParameter("id"))))) {
					request.setAttribute("message", "Suppression effectuée !");
				} else {
					request.setAttribute("message", "Erreur lors de la suppression !");
				}
			} else if (request.getParameter("act").equals("update")) {
				request.setAttribute("playerToUpdate", playerDAO.findByID(Integer.parseInt(request.getParameter("id"))));
			}
		}
		request.setAttribute("listeJoueurs", playerDAO.read());
		request.getRequestDispatcher("/vue/players/players.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("idUpdate") != null) {
			if (playerDAO.update(new beans.Player(Integer.parseInt(request.getParameter("idUpdate")), request.getParameter("emailUpdate"), request.getParameter("nicknameUpdate")))) {
				request.setAttribute("message", "La mise à jour pour " + request.getParameter("nicknameUpdate") + " a bien été prise en compte !");
				doGet(request, response);
			}
		} else {
			if (playerDAO.create(new beans.Player(request.getParameter("email"), request.getParameter("nickname")))) {
				request.setAttribute("message", "Le joueur " + request.getParameter("nickname") + " a bien été ajouté !");
				doGet(request, response);
			}			
		}
	}

}
