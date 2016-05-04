package org.gdpurjyfs.qiuming.entity;

public class CarDepart extends Post{
	private long carId;
	private long postId;
	private long plateNumber;
	private int state;
		
	public CarDepart() {
		
	}

	public long getCarId() {
		return carId;
	}
	public void setCarId(long carId) {
		this.carId = carId;
	}
	public long getPostId() {
		return postId;
	}
	public void setPostId(long postId) {
		this.postId = postId;
	}
	public long getPlateNumber() {
		return plateNumber;
	}
	public void setPlateNumber(long plateNumber) {
		this.plateNumber = plateNumber;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
	
	
}
