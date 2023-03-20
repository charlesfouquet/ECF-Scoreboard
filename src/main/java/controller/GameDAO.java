package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.Game;
import connector.DBConnect;

public class GameDAO implements IDAO<Game> {
	Connection connect = DBConnect.getConnect();
	PreparedStatement req = null;
	ResultSet rs = null;

	@Override
	public boolean create(Game game) {
		try {
			req = connect.prepareStatement("INSERT INTO game (title, min_players, max_players) VALUES (?, ?, ?)");
			req.setString(1, game.getTitle());
			req.setInt(2, game.getMin_players());
			req.setInt(3, game.getMax_players());
			req.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public ArrayList<Game> read() {
		ArrayList<Game> listeJeux = new ArrayList<>();
		
		try {
			req = connect.prepareStatement("SELECT * FROM game ORDER BY id ASC");
			rs = req.executeQuery();
			while (rs.next()) {
				listeJeux.add(new Game(rs.getInt("id"), rs.getString("title"), rs.getInt("min_players"), rs.getInt("max_players")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listeJeux;
	}
	
	@Override
	public Game findByID(int ID) {
		Game gameFound = null;
		try {
			req = connect.prepareStatement("SELECT * FROM game WHERE id = ?");
			req.setInt(1, ID);
			rs = req.executeQuery();
			if (rs.next()) {
				gameFound = new Game(rs.getInt("id"), rs.getString("title"), rs.getInt("min_players"), rs.getInt("max_players"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return gameFound;
	}

	@Override
	public boolean update(Game game) {
		try {
			req = connect.prepareStatement("UPDATE game SET title = ?, min_players = ?, max_players = ? WHERE id = ?");
			req.setString(1, game.getTitle());
			req.setInt(2, game.getMin_players());
			req.setInt(3, game.getMax_players());
			req.setInt(4, game.getId());
			req.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean delete(Game game) {
		try {
			req = connect.prepareStatement("DELETE FROM game WHERE id = ?");
			req.setInt(1, game.getId());
			req.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
