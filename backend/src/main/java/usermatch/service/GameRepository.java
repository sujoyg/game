package usermatch.service;

import org.springframework.data.mongodb.repository.MongoRepository;

import usermatch.model.Game;

/**
 * Created by hooria.komal on 10/1/14.
 */
//@Repository
public interface GameRepository extends MongoRepository<Game, String> {
}
