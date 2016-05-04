package org.gdpurjyfs.qiuming.service;

import org.gdpurjyfs.qiuming.dao.LetterDao;
import org.gdpurjyfs.qiuming.entity.Letter;
import org.gdpurjyfs.qiuming.entity.User;

public class LetterService {
	private User user;
	private Letter letter;
	
	// TODO 发送私信
	public String sendLetter() {
		LetterDao letterDao = new LetterDao();
		letterDao.create(this.getLetter());
		return "";
	}
	
	// TODO 删除私信
	public String deleteLetter() {
		// 1. 设置 letter_id
		LetterDao letterDao = new LetterDao();
		letterDao.delete(this.getLetter().getId());
		return "";
	}
	
	//---------------------------------------------
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Letter getLetter() {
		return letter;
	}

	public void setLetter(Letter letter) {
		this.letter = letter;
	}
}
