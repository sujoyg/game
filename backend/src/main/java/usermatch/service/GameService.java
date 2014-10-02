package usermatch.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Component;

import usermatch.model.Game;
import usermatch.model.User;

/**
 * Created by hooria.komal on 10/1/14.
 */
@EnableAutoConfiguration
@Component
public class GameService {

	private static String IMAGE_PATH = "https://d3bql97l1ytoxn.cloudfront.net/profilePics/";

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private GameRepository gameRepository;


	public static void main(String[] args) {
		GameService service = new GameService();
		//String fileName = "/Users/hooria.komal/Documents/Notes/UsersList";
		String fileName = "/Users/hooria.komal/Documents/Notes/hooria_1.txt";
		service.createTestUsers(fileName);
	}

	public List<User> getAllUsers() {
		List<User> allUsers = new ArrayList<User>();
		System.out.println("Users found with findAll():");
		System.out.println("-------------------------------");
		for (User user : userRepository.findAll()) {
			allUsers.add(user);
		}
		return allUsers;
	}

	public User getUser(String userId) {
		User user = userRepository.findByUserId(userId);
		return user;
	}

	public User createUser(String id, String name, String email, String img) {
		User user = new User(id, name, email, img);
		System.out.println("created user " + user);
		insertUser(user);
		return user;
	}

	private void insertUser(User user) {
		userRepository.save(user);
	}

	public void createGame(String email, int score) {
		Game game = new Game(email, score);
		gameRepository.save(game);
	}

	public List<Game> getAllGames() {
		List<Game> allGames = new ArrayList<Game>();
		System.out.println("Games found with findAll():");
		System.out.println("-------------------------------");
		for (Game game : gameRepository.findAll()) {
			allGames.add(game);
			System.out.println(game);
		}
		return allGames;
	}

	public List<Game> getBestGames(int n) {
		List<Game> allGames = new ArrayList<Game>();
		System.out.println("Games found with findAll():");
		System.out.println("-------------------------------");
		for (Game game : gameRepository.findAll()) {
			allGames.add(game);
			System.out.println(game);
		}
		Collections.sort(allGames);
		ArrayList<Game> sortedList = new ArrayList<Game>();
		int maxIndex = allGames.size() - 1;
		int count = 0;
		for (int i = allGames.size() -1; i >=0; i--) {
			if (count == n)
				break;
			sortedList.add(allGames.get(i));
			count++;
		}
		return sortedList;
	}

	public void createTestUsers(String fileName) {
		try {
			final Scanner s = new Scanner(new File(fileName));
			userRepository.deleteAll();
			int ids = 0;
			while (s.hasNextLine()) {
				final String line = s.nextLine();
				String[] tokens = line.split(",");
				String id = String.valueOf(ids++);
				String firstName = tokens[2];
				String lastName = tokens[3];
				String email = tokens[4];
				if (email.contains("+"))
					continue;
				String image = tokens[5];
				if (image == null || image.isEmpty() || image.trim().equals("NULL"))
					continue;
				String imageURL = IMAGE_PATH + image.trim();
				String name = firstName.trim() + " " + lastName.trim();
				User user = new User(id, name, email, imageURL);
				insertUser(user);
				System.out.println("Creating user " + user);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
}
