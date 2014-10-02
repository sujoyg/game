package usermatch.model;

import java.util.UUID;

import lombok.Data;

import org.springframework.data.annotation.Id;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class User{
	@Id
	private String userId;
	private String id;
	private final String name;
	private final String email;
	private final String image;
	private static final String PATH = "http://10.25.100.88/~hooria.komal/";
/*
	public User(String id, String name, String email) {
		this.id = id;
		userId = UUID.randomUUID().toString();
		image = PATH+ getFirstName(name) + "_" + id+".png";
		this.name = name;
		this.email = email;
	}*/

	public User(String id, String name, String email,String image) {
		this.id = id;
		userId = UUID.randomUUID().toString();
		this.image = image;
		this.name = name;
		this.email = email;
	}

	private String getFirstName(String name) {
		String [] tokens = name.split(" ");
		return tokens[0];
	}

	@Override
	public String toString() {
		return String.format(
				"User[id=%s, userid=%s,name='%s', email='%s',image='%s']",
				id,userId, name, email,image);
	}
}
