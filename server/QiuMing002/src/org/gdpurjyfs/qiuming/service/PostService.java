package org.gdpurjyfs.qiuming.service;

import java.util.List;

import org.gdpurjyfs.qiuming.dao.CommentDao;
import org.gdpurjyfs.qiuming.dao.CommonDao;
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

@SuppressWarnings("unused")
public class PostService {
	/*
	 * 创建帖子 查看帖子 修改帖子 收藏帖子 点赞帖子 删除帖子 举报帖子 帖子贴标签 赞同帖子的标签
	 */

	private PostDao postDao = new PostDao();
	private PraiseDao praiseDao = new PraiseDao();
	
	private Post post;
	private User user;

	private String tagName; // 标签名称
	private String favoriteName; // 收藏夹名称
	private String complainReason; // 举报理由

	public List<Post> getUserPostList(User user, long index, long size) {
		return postDao.getPostList(user.getId(), index, size);
	}
	
	// 创建帖子
	public String createPost(Post post) {
		// userId title content
		return (String) postDao.create(post);
	}
	
	// 查看帖子
	public Post viewPost(long postId) {
		return (Post) postDao.findById(postId);
	}
	
	// 修改帖子
	public String modifyPost(Post post) {
		return (String) postDao.update(post);
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

	// 点赞帖子
	public String parisePost(long userId, long postId) {
		// 1. 获取帖子 id
		// 2. 获取浏览此帖子用户的 id
		// 3. 向 Praise 写入记录		
		
		String result = (String) praiseDao.create(new Praise(userId, postId));
		if(result.equals(CommonDao.SUCCESS)) {
			return postDao.addPraiseNumber(postId);
		} else {
			return result;
		}
	}
	
	// 取消赞
	public String unparisePost(long userId, long postId) {
		String result = praiseDao.delete(userId, postId);
		if(result.equals(CommonDao.SUCCESS)) {
			return postDao.subPraiseNumber(postId);
		} else {
			return result;
		}
	}
	
	public long getPostPariseNumber(long postId) {
		Post post = (Post) postDao.findById(postId);
		if(post != null) {
			System.out.println("PostService "+ postId +" getPostPariseNumber:"+post.getPraiseNumber());
			return post.getPraiseNumber();
		} else {
			return 0;
		}
	}
	
	// 查询用户是否点赞某篇帖子
	// 不小于 0  的话就是找到了
	public Praise checkUserParisePost(long userId, long postId) {
		return  praiseDao.findById(userId, postId);
	}

	// TODO 删除帖子
	public String deletePost(long postId) {
		return (String) postDao.delete(postId);
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
		
		// TagDao tagDao = new TagDao();
		// Tag tag = (Tag)tagDao.findByTagName(this.getPost().getId(), this.getTagName());
//		if(tag != null) {
//			TagPraiseDao tagPraiseDao = new TagPraiseDao();
//			
//			TagPraise tagPraise = new TagPraise();
//			tagPraise.setPraiseUserId(this.getUser().getId());
//			tagPraise.setTagId(tag.getId());
//			
//			tagPraiseDao.create(tagPraise);
//			// 判断是赞同还是取消赞同
//			tag.setPraiseNumber(tag.getPraiseNumber() + 1);
//			tagDao.update(tag);
//		}
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
