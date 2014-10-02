package usermatch.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import usermatch.model.Game;
import usermatch.model.User;
import usermatch.service.GameService;

/**
 * Created by hooria.komal on 10/1/14.
 */
@RestController
public class GameController {
	@Autowired
	GameService gameService;

	@RequestMapping("/users")
	public List<User> users() {
		return gameService.getAllUsers();
	}

	@RequestMapping("/user")
	public User getRandomUser() {
		return gameService.getUser("1");
	}
/*
	@RequestMapping("/AddUser")
	public User addUser(@RequestParam(value="id") String id, @RequestParam(value="name") String name, @RequestParam(value="email") String email) {
		return gameService.createUser(id,name,email,"");
	}*/

	/**
	 * Starts a new game and returns a game id
	 * @param email
	 * @param email
	 * @return
	 */
	@RequestMapping("/game")
	public void addGameScore(@RequestParam(value="email") String email, @RequestParam(value="score") int score) {
		gameService.createGame(email,score);
	}

	@RequestMapping("/games")
	public List<Game> getAllGameScores() {
		return gameService.getAllGames();
	}

	@RequestMapping("/bestGames")
	public List<Game> getBestGameScores(@RequestParam(value="n") int numGames) {
		return gameService.getBestGames(numGames);
	}

	@RequestMapping("/createTest")
	public void createTestData() {
		String fileName = "/home/user/hooria.txt";
		gameService.createTestUsers(fileName);
	}

}
