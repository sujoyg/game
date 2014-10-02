package usermatch.service;

import org.springframework.data.mongodb.repository.MongoRepository;

import usermatch.model.User;

public interface UserRepository extends MongoRepository<User, String> {
	public User findByUserId(String id);
}
