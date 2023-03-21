package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.Contest;
import beans.Player;
import connector.DBConnect;

public class PlayerDAO implements IDAO<Player> {
	Connection connect = DBConnect.getConnect();
	PreparedStatement req = null;
	ResultSet rs = null;

	@Override
	public boolean create(Player player) {
		try {
			req = connect.prepareStatement("INSERT INTO player (email, nickname) VALUES (?, ?)");
			req.setString(1, player.getEmail());
			req.setString(2, player.getNickname());
			req.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public ArrayList<Player> read() {
		ArrayList<Player> listePlayers = new ArrayList<>();
		
		try {
			req = connect.prepareStatement("SELECT * FROM player ORDER BY id ASC");
			rs = req.executeQuery();
			while (rs.next()) {
				listePlayers.add(new Player(rs.getInt("id"), rs.getString("email"), rs.getString("nickname")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listePlayers;
	}

	@Override
	public Player findByID(int ID) {
		Player playerFound = null;
		try {
			req = connect.prepareStatement("SELECT * FROM player WHERE id = ?");
			req.setInt(1, ID);
			rs = req.executeQuery();
			if (rs.next()) {
				playerFound = new Player(rs.getInt("id"), rs.getString("email"), rs.getString("nickname"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return playerFound;
	}
	
	public ArrayList<Player> findByContest(int ID) {
		ArrayList<Player> listePlayers = new ArrayList<>();
		
		try {
			req = connect.prepareStatement("SELECT * FROM player p JOIN player_contest pc ON pc.player_id = p.id WHERE pc.contest_id = ? ORDER BY p.id ASC");
			req.setInt(1, ID);
			rs = req.executeQuery();
			while (rs.next()) {
				listePlayers.add(new Player(rs.getInt("id"), rs.getString("email"), rs.getString("nickname")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listePlayers;
	}
	
	public ArrayList<Player> findOutOfContest(int ID) {
		ArrayList<Player> listePlayers = new ArrayList<>();
		
		try {
			req = connect.prepareStatement("SELECT DISTINCT p.* FROM player p LEFT JOIN player_contest pc ON pc.player_id = p.id WHERE p.id NOT IN (SELECT player_id FROM player_contest WHERE contest_id = ?) ORDER BY p.id ASC");
			req.setInt(1, ID);
			rs = req.executeQuery();
			while (rs.next()) {
				listePlayers.add(new Player(rs.getInt("id"), rs.getString("email"), rs.getString("nickname")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listePlayers;
	}
	
	public boolean addPlayerToContest(Player player, Contest contest) {
		try {
			req = connect.prepareStatement("INSERT INTO player_contest (player_id, contest_id) VALUES (?, ?)");
			req.setInt(1, player.getId());
			req.setInt(2, contest.getId());
			req.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean update(Player player) {
		try {
			req = connect.prepareStatement("UPDATE player SET email = ?, nickname = ? WHERE id = ?");
			req.setString(1, player.getEmail());
			req.setString(2, player.getNickname());
			req.setInt(3, player.getId());
			req.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean delete(Player player) {
		try {
			req = connect.prepareStatement("DELETE FROM player WHERE id = ?");
			req.setInt(1, player.getId());
			req.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean deleteFromContest(Player player, Contest contest) {
		try {
			req = connect.prepareStatement("DELETE FROM player_contest WHERE player_id = ? AND contest_id = ?");
			req.setInt(1, player.getId());
			req.setInt(2, contest.getId());
			req.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean mailExists(String email, int playerID) {
		try {
			req = connect.prepareStatement("SELECT * FROM player WHERE email = ? AND id NOT IN (?)");
			req.setString(1, email);
			req.setInt(2, playerID);
			rs = req.executeQuery();
			if (rs.next()) {
				return true;				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
