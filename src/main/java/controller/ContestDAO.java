package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.Contest;
import connector.DBConnect;

public class ContestDAO implements IDAO<Contest> {	
	Connection connect = DBConnect.getConnect();
	PreparedStatement req = null;
	ResultSet rs = null;
	GameDAO gameDAO = new GameDAO();
	PlayerDAO playerDAO = new PlayerDAO();

	@Override
	public boolean create(Contest contest) {
		try {
			req = connect.prepareStatement("INSERT INTO contest (game_id, start_date) VALUES (?, ?)");
			req.setInt(1, contest.getGame().getId());
			req.setDate(2, contest.getStart_date());
			req.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public ArrayList<Contest> read() {
		ArrayList<Contest> listeMatches = new ArrayList<>();
		
		try {
			req = connect.prepareStatement("SELECT *, COUNT(pc.player_id) as playersCount FROM contest c LEFT JOIN player_contest pc ON pc.contest_id = c.id GROUP BY c.id ORDER BY start_date DESC");
			rs = req.executeQuery();
			while (rs.next()) {
				if (rs.getInt("winner_id") == 0) {
					listeMatches.add(new Contest(rs.getInt("c.id"), gameDAO.findByID(rs.getInt("c.game_id")), rs.getInt("playersCount"), rs.getDate("start_date"), null));					
				} else if (rs.getInt("winner_id") > 0) {
					listeMatches.add(new Contest(rs.getInt("c.id"), gameDAO.findByID(rs.getInt("c.game_id")), rs.getInt("playersCount"), rs.getDate("start_date"), playerDAO.findByID(rs.getInt("c.winner_id"))));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listeMatches;
	}

	@Override
	public Contest findByID(int ID) {
		Contest matchFound = null;
		try {
			req = connect.prepareStatement("SELECT *, COUNT(pc.player_id) as playersCount FROM contest c LEFT JOIN player_contest pc ON pc.contest_id = c.id WHERE c.id = ? GROUP BY c.id");
			req.setInt(1, ID);
			rs = req.executeQuery();
			if (rs.next()) {
				if (rs.getInt("winner_id") == 0) {
					matchFound = new Contest(rs.getInt("c.id"), gameDAO.findByID(rs.getInt("c.game_id")), rs.getInt("playersCount"), rs.getDate("start_date"), null);
				} else if (rs.getInt("winner_id") > 0) {
					matchFound = new Contest(rs.getInt("id"), gameDAO.findByID(rs.getInt("c.game_id")), rs.getInt("playersCount"), rs.getDate("start_date"), playerDAO.findByID(rs.getInt("c.winner_id")));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return matchFound;
	}

	@Override
	public boolean update(Contest contest) {
		try {
			req = connect.prepareStatement("UPDATE contest SET game_id = ?, start_date = ? WHERE id = ?");
			req.setInt(1, contest.getGame().getId());
			req.setDate(2, contest.getStart_date());
			req.setInt(3, contest.getId());
			req.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean delete(Contest contest) {
		try {
			req = connect.prepareStatement("DELETE FROM contest WHERE id = ?");
			req.setInt(1, contest.getId());
			req.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
