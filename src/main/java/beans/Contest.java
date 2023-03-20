package beans;

import java.sql.Date;

public class Contest {
	private int id;
	private Game game;
	private int playersCount;
	private Date start_date;
	private Player winner;
	
	public Contest(int id) {
		this.id = id;
	}
	
	public Contest(Game game, Date start_date) {
		this.game = game;
		this.start_date = start_date;
	}
	
	public Contest(int id, Game game, Date start_date) {
		this.id = id;
		this.game = game;
		this.start_date = start_date;
	}
	
	public Contest(Game game, int playersCount, Date start_date, Player winner) {
		this.game = game;
		this.playersCount = playersCount;
		this.start_date = start_date;
		this.winner = winner;
	}
	
	public Contest(int id, Game game, int playersCount, Date start_date, Player winner) {
		this.id = id;
		this.game = game;
		this.playersCount = playersCount;
		this.start_date = start_date;
		this.winner = winner;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Game getGame() {
		return game;
	}

	public void setGame(Game game) {
		this.game = game;
	}

	public int getPlayersCount() {
		return playersCount;
	}

	public void setPlayersList(int playersCount) {
		this.playersCount = playersCount;
	}

	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}

	public Player getWinner() {
		return winner;
	}

	public void setWinner(Player winner) {
		this.winner = winner;
	}
}
