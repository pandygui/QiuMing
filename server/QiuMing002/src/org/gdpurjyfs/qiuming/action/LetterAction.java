package org.gdpurjyfs.qiuming.action;

public class LetterAction {
	private String username;
	private String focusUsername;
	private String letter;

	// TODO 发送私信
	public String sendLetter() {
		return "";
	}
	
	// TODO 删除私信
	public String deleteLetter() {
		return "";
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFocusUsername() {
		return focusUsername;
	}

	public void setFocusUsername(String focusUsername) {
		this.focusUsername = focusUsername;
	}

	public String getLetter() {
		return letter;
	}

	public void setLetter(String letter) {
		this.letter = letter;
	}
}
