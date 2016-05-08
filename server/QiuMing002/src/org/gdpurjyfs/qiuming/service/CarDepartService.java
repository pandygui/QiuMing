package org.gdpurjyfs.qiuming.service;

import org.gdpurjyfs.qiuming.dao.CarAboardDao;
import org.gdpurjyfs.qiuming.dao.CarDepartDao;
import org.gdpurjyfs.qiuming.dao.PostDao;
import org.gdpurjyfs.qiuming.entity.CarAboard;
import org.gdpurjyfs.qiuming.entity.CarDepart;
import org.gdpurjyfs.qiuming.entity.Post;
import org.gdpurjyfs.qiuming.entity.User;

public class CarDepartService {
	/*
	 * 举报发车 
	 * 上车 
	 * 发车 
	 * 设置上车权限 在 AdminService
	 */
	
	private User user;
	private CarDepart carDepart;
	
	public String complainCar() {
		// 1. userid
		// 2. car id
		// 3. post id
		// 4. 向 Complain 写入记录
		// 5. 发送信息
		
		return "";
	}
	
	public String aboardCar() {
		// 1. user id
		// 2. car id
		// 3. post id
		// 4. 判断是否有此趟车
		// 5. 判断用户是否已经上车
		// 4. CarAboard 写入记录
		CarAboardDao carAboardDao = new CarAboardDao();
		CarAboard carAboard = new CarAboard();
		carAboardDao.create(carAboard);
		
		return "";
	}
	
	public String departCar() {
		// 1. 申请发车
		// 2. 写入 CarDepart
		
		CarDepartDao carDepartDao = new CarDepartDao();
		CarDepart carDepart = new CarDepart();
		carDepartDao.create(carDepart);
		
		return "";
	}
	
	//----------------------------------------------------------
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public CarDepart getCarDepart() {
		return carDepart;
	}

	public void setCarDepart(CarDepart carDepart) {
		this.carDepart = carDepart;
	}
}
