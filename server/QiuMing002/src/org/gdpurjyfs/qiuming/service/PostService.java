package org.gdpurjyfs.qiuming.service;

import org.gdpurjyfs.qiuming.dao.ComplainDao;
import org.gdpurjyfs.qiuming.dao.PostDao;
import org.gdpurjyfs.qiuming.dao.PraiseDao;
import org.gdpurjyfs.qiuming.dao.TagDao;
import org.gdpurjyfs.qiuming.dao.TagPraiseDao;
import org.gdpurjyfs.qiuming.entity.Complain;
import org.gdpurjyfs.qiuming.entity.Letter;
import org.gdpurjyfs.qiuming.entity.Post;
import org.gdpurjyfs.qiuming.entity.Praise;
import org.gdpurjyfs.qiuming.entity.Tag;
import org.gdpurjyfs.qiuming.entity.TagPraise;
import org.gdpurjyfs.qiuming.entity.User;

import org.gdpurjyfs.qiuming.entity.Favorite;
import org.gdpurjyfs.qiuming.dao.FavoriteDao;

public class PostService {
	/*
	 * 创建帖子 查看帖子 修改帖子 收藏帖子 点赞帖子 删除帖子 举报帖子 帖子贴标签 赞同帖子的标签
	 */

	private Post post;
	private User user;

	private String tagName; // 标签名称
	private String favoriteName; // 收藏夹名称
	private String complainReason; // 举报理由

	// TODO 创建帖子
	public String createPost() {
		PostDao postDao = new PostDao();
		String result = (String) postDao.create(this.getPost());
		return result;
	}

	// TODO 查看帖子
	public String viewPost() {
		PostDao postDao = new PostDao();
		// Post result = (Post)
		postDao.findById(this.getPost().getId());
		return "";
	}

	// TODO 修改帖子
	public String modifyPost() {
		PostDao postDao = new PostDao();
		// Post result = (Post)
		postDao.update(this.getPost());
		return "";
	}

	// TODO 收藏帖子
	public String favoritePost() {
		// 1. 获取 帖子 id
		// 2. 获取 用户 id
		// 3. 向 Favorite 中插入记录
		FavoriteDao favoriteDao = new FavoriteDao();
		Favorite favorite = new Favorite();
		favorite.setPostId(this.getPost().getId());
		favorite.setUserId(this.getUser().getId());
		favorite.setFavoriteName(this.getFavoriteName());
		favoriteDao.create(favorite);

		return "";
	}

	// TODO 点赞帖子
	// ! NOTE: 点赞或者取消赞
	public String parisePost() {
		// 1. 获取帖子 id
		// 2. 获取浏览此帖子用户的 id
		// 3. 向 Praise 写入记录
		PraiseDao praiseDao = new PraiseDao();
		Praise praise = new Praise();

		praise.setPostId(this.getPost().getId());
		praise.setUserId(this.getUser().getId());
		praiseDao.create(praise);

		return "";
	}

	// TODO 删除帖子
	public String deletePost() {
		// 1. 获取 帖子 id
		// 2. 查询是否存在
		// 3. 删除
		PostDao postDao = new PostDao();
		if (postDao.findById(this.getPost().getId()) != null) {
			postDao.delete(this.getPost().getId());
		}
		return "";
	}

	// TODO 举报帖子
	public String complainPost() {
		// 1. 举报帖子
		// 2. 向管理员发送私信
		ComplainDao complainDao = new ComplainDao();
		Complain complain = new Complain();
		complain.setPostId(this.getPost().getId());
		complain.setUserId(this.getUser().getId());
		complain.setReason(this.getComplainReason());
		String complainResult = (String) complainDao.create(complain);
		if (complainResult.equals("SUCCESS")) {
			LetterService letterServer = new LetterService();
			Letter letter = new Letter();
			letter.setContent("user" + this.getUser().getId()
					+ this.getComplainReason());
			letter.setSenderUserId(0);			// 0 is System
			letter.setReceiveUserId(1);			// 1 is Admin
			letterServer.setLetter(letter);
			letterServer.sendLetter();
		}

		return "";
	}

	// TODO 帖子贴标签 或者消除标签
	public String tagPost() {
		// 1. 添加或者删除帖子标签的赞数
		// 2. 修改帖子的赞数字段
		TagDao tagDao = new TagDao();
		Tag tag = new Tag();
		tag.setPostId(this.getPost().getId());
		tag.setTagName(tagName);
		tag.setUserId(this.getUser().getId());
		String tagResult = (String) tagDao.create(tag);
		if(tagResult.equals("SUCCESS")) {
			PostDao postDao = new PostDao();
			Post post = (Post)postDao.findById(this.getPost().getId());
			if(post != null) {
				post.setPraiseNumber(post.getPraiseNumber()-1);
				postDao.update(post);
			}
		}
		
		return "";
	}

	// TODO 赞同帖子的标签
	// 或者取消赞同帖子的标签
	public String parisePostTag() {
		// 1. 获取 post id
		// 2. 获取 user id
		// 3. 获取 tag id
		// 4. 向 TagPraise 写入记录
		// 5. 修改 Tag 的 praiseNumber 字段
		
		TagDao tagDao = new TagDao();
		Tag tag = (Tag)tagDao.findByTagName(this.getPost().getId(), this.getTagName());
		if(tag != null) {
			TagPraiseDao tagPraiseDao = new TagPraiseDao();
			
			TagPraise tagPraise = new TagPraise();
			tagPraise.setPraiseUserId(this.getUser().getId());
			tagPraise.setTagId(tag.getId());
			
			tagPraiseDao.create(tagPraise);
			// 判断是赞同还是取消赞同
			tag.setPraiseNumber(tag.getPraiseNumber() + 1);
			tagDao.update(tag);
		}
		return "";
	}

	// -------------------------------------------------

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getTagName() {
		return tagName;
	}

	public void setTagName(String tag) {
		this.tagName = tag;
	}

	public String getFavoriteName() {
		return favoriteName;
	}

	public void setFavoriteName(String favoriteName) {
		this.favoriteName = favoriteName;
	}

	public String getComplainReason() {
		return complainReason;
	}

	public void setComplainReason(String complainReason) {
		this.complainReason = complainReason;
	}
}
