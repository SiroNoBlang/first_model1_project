package test_master;
/*
CREATE TABLE test_master_news (
	NUM INT PRIMARY KEY,
	NICKNAME VARCHAR(20) NOT NULL,
	PASS VARCHAR(20) NOT NULL,
	SUBJECT VARCHAR(50) NOT NULL,
	CONTENT VARCHAR(2000) NOT NULL,
	CREATE_DATE DATE NOT NULL,
	READCOUNT INT NOT NULL
);
 */
import java.sql.Date;

public class Master_news_DTO {
	private int num;
	private String nickname;
	private String pass;
	private String subject;
	private String content;
	private Date create_date;
	private int readcount;
	
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	@Override
	public String toString() {
		return "BoardBean [num=" + num + ", nickname=" + nickname + ", pass=" + pass + ", subject=" + subject
				+ ", content=" + content + ", create_date=" + create_date + ", readcount=" + readcount + "]";
	}
}
