package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ContestDAO;
import controller.GameDAO;
import controller.PlayerDAO;

/**
 * Servlet implementation class Contests
 */
@WebServlet("/contests")
public class Contests extends HttpServlet {
	private static final long serialVersionUID = 1L;
	GameDAO gameDAO = new GameDAO();
	PlayerDAO playerDAO = new PlayerDAO();
	ContestDAO contestDAO = new ContestDAO();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Contests() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("id") != null) {
			if (request.getParameter("act").equals("delete")) {
				if (contestDAO.delete(new beans.Contest(Integer.parseInt(request.getParameter("id"))))) {
					request.setAttribute("message", "Suppression effectuée !");
				} else {
					request.setAttribute("message", "Erreur lors de la suppression !");
				}
			} else if (request.getParameter("act").equals("update")) {
				request.setAttribute("matchToUpdate", contestDAO.findByID(Integer.parseInt(request.getParameter("id"))));
			} else if (request.getParameter("act").equals("playersList")) {
				request.setAttribute("contestID", request.getParameter("id"));
				request.setAttribute("playersList", playerDAO.findByContest(Integer.parseInt(request.getParameter("id"))));
			} else if (request.getParameter("act").equals("deleteFromContest")) {
				if (playerDAO.deleteFromContest(new beans.Player(Integer.parseInt(request.getParameter("id"))), new beans.Contest(Integer.parseInt(request.getParameter("contest"))))) {
					request.setAttribute("message", "Suppression effectuée !");
				} else {
					request.setAttribute("message", "Erreur lors de la suppression !");
				}
				request.setAttribute("contestID", request.getParameter("contest"));
				request.setAttribute("playersList", playerDAO.findByContest(Integer.parseInt(request.getParameter("contest"))));
			}
		}
		request.setAttribute("listeJeux", gameDAO.read());
		request.setAttribute("listeMatches", contestDAO.read());
		request.getRequestDispatcher("/vue/contests/contests.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("idUpdate") != null) {
			if (request.getParameter("start_dateUpdate").isEmpty()) {
				request.setAttribute("message", "Erreur : la date n'a pas été saisie");
			} else if (Integer.parseInt(request.getParameter("gameIDUpdate")) == 0) {
				request.setAttribute("message", "Erreur : aucun jeu saisi");
			} else {
				if (contestDAO.update(new beans.Contest(Integer.parseInt(request.getParameter("idUpdate")), gameDAO.findByID(Integer.parseInt(request.getParameter("gameIDUpdate"))), java.sql.Date.valueOf(request.getParameter("start_dateUpdate"))))) {
					request.setAttribute("message", "La mise à jour pour ce match a bien été prise en compte !");
				}
			}
			doGet(request, response);
		} else {
			if (request.getParameter("start_date").isEmpty()) {
				request.setAttribute("message", "Erreur : la date n'a pas été saisie");
			} else if (Integer.parseInt(request.getParameter("gameID")) == 0) {
				request.setAttribute("message", "Erreur : aucun jeu saisi");
			} else {
				if (contestDAO.create(new beans.Contest(gameDAO.findByID(Integer.parseInt(request.getParameter("gameID"))), java.sql.Date.valueOf(request.getParameter("start_date"))))) {
					request.setAttribute("message", "Match ajouté !");
				}
			}
			doGet(request, response);
		}
	}

}
