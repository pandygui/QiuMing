package org.gdpurjfys.qiuming.test;

import java.util.HashMap;

import org.junit.Test;

import com.alibaba.fastjson.JSON;

class TestEntity {
	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}

/*
 * SerializeWriter：相当于StringBuffer 
 * JSONArray：相当于List<Object>
 * JSONObject：相当于Map<String, Object>
 */

public class TestFastJson {
	@Test
	public void testFastJson() {
		TestEntity object = JSON.parseObject("{'name':'name'}",
				TestEntity.class);
		System.out.println(object.getName());
		String jsonString = JSON.toJSONString(object);
		System.out.println(jsonString);
		

		
	}
	
	@Test
	public void testToString() {
		HashMap<String, String> obj = new HashMap<String, String>();
		obj.put("name", "value");
		System.out.println(JSON.toJSONString(obj));
	}
}
