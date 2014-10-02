package usermatch.model;

import java.util.UUID;

import lombok.Data;

import org.springframework.data.annotation.Id;

/**
 * Created by hooria.komal on 10/1/14.
 */
@Data
public class Game implements Comparable<Game> {
	@Id
	private final String gameId;
	private final String email;
	private int score;

	public Game(String email, int score) {
		gameId = UUID.randomUUID().toString();
		this.email = email;
		this.score = score;
	}

	@Override
	public int compareTo(Game that) {
		return this.score - that.score;
	}

	public String toString() {
		return String.format(
				"Game[id=%s, user email=%s,score='%s']",
				gameId, email, score);
	}

}
