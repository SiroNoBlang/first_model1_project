package test_member;

import java.sql.Date;

/*
CREATE DATABASE test_exam;

USE test_exam;

CREATE TABLE test_member (
	NICKNAME VARCHAR(20) UNIQUE NOT NULL,
	ID VARCHAR(12) PRIMARY KEY,
	PASS VARCHAR(20) NOT NULL,
	NAME VARCHAR(15) NOT NULL,
	PHONE VARCHAR(15) NOT NULL,
	POSTCODE VARCHAR(30),
	ADDRESS VARCHAR(50),
	GENDER VARCHAR(6),
	JOB VARCHAR(15) NOT NULL,
	EMAIL VARCHAR(50),
	JOIN_DATE DATE NOT NULL
);
*/

public class MemberDTO {
	private String nickname;
	private String id;
	private String pass;
	private String name;
	private String phone;
	private String job;
	private String gender;
	private String email;
	private String postcode;
	private String address;
	private Date date;
	
	public MemberDTO() {}

	public MemberDTO(String nickname, String id, String pass, String name, String phone, String job, String gender,
			String email, String postcode, String address, Date date) {
		super();
		this.nickname = nickname;
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.phone = phone;
		this.job = job;
		this.gender = gender;
		this.email = email;
		this.postcode = postcode;
		this.address = address;
		this.date = date;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

}
