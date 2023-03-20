package beans;

public class Game {
	private int id;
	private String title; 
	private int min_players;
	private int max_players;
	
	public Game(int id) {
		this.id = id;
	}
	
	public Game(String title, int min_players, int max_players) {
		this.title = title;
		this.min_players = min_players;
		this.max_players = max_players;
	}
	
	public Game(int id, String title, int min_players, int max_players) {
		this.id = id;
		this.title = title;
		this.min_players = min_players;
		this.max_players = max_players;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getMin_players() {
		return min_players;
	}

	public void setMin_players(int min_players) {
		this.min_players = min_players;
	}

	public int getMax_players() {
		return max_players;
	}

	public void setMax_players(int max_players) {
		this.max_players = max_players;
	}
}
