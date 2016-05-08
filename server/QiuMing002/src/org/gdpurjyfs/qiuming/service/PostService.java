package org.gdpurjyfs.qiuming.service;

import java.util.ArrayList;
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
	private FavoriteDao favoriteDao = new FavoriteDao();
	private ComplainDao complainDao = new ComplainDao();

	private Post post;
	private User user;

	private String tagName; // 标签名称
	private String favoriteName; // 收藏夹名称
	private String complainReason; // 举报理由

	/**
	 * 获取用户的帖子列表
	 ***/
	public List<Post> getUserPostList(User user, long index, long size) {
		return postDao.getPostList(user.getId(), index, size);
	}

	/**
	 * 获取帖子列表
	 ***/
	public List<Post> getPostList(long index, long size) {
		return postDao.getPostList(index, size);
	}

	/**
	 * 创建帖子
	 ***/
	public String createPost(Post post) {
		// userId title content
		return (String) postDao.create(post);
	}

	/**
	 * 查看帖子
	 ***/
	public Post viewPost(long postId) {
		return (Post) postDao.findById(postId);
	}

	/**
	 * 修改帖子
	 ***/
	public String modifyPost(Post post) {
		/* SUCCESS NONE */
		return (String) postDao.update(post);
	}

	/**
	 * 获取用户指定收藏夹所有的帖子
	 ***/
	public List<Post> getUserFavoriteList(long userId, String favoriteName) {
		List<Favorite> favorites = favoriteDao.getUserFavoriteList(userId,
				favoriteName);
		// 这里要填充 Post
		List<Post> favoritePosts = new ArrayList<Post>();
		for (Favorite f : favorites) {
			Post p = viewPost(f.getPostId());
			if (p != null) {
				favoritePosts.add(p);
			}
		}
		return favoritePosts;
	}

	/**
	 * 分段获取用户的收藏列表
	 ***/
	public List<Favorite> getUserFavoriteList(long userId, long index, long size) {
		return favoriteDao.getUserFavoriteList(userId, index, size);
	}

	/**
	 * 收藏帖子
	 ***/
	public String favoritePost(long userId, long postId, String favoriteName) {
		return (String) favoriteDao.create(new Favorite(userId, postId,
				favoriteName));
	}

	/**
	 * 取消收藏帖子
	 ***/
	public String unfavoritePost(long userId, long postId, String favoriteName) {
		return favoriteDao.delete(userId, postId, favoriteName);
	}

	public Favorite checkUserFavoritePost(long userId, long postId,
			String favoriteName) {
		return favoriteDao.find(userId, postId, favoriteName);
	}

	/**
	 * 点赞帖子
	 *  1. 获取帖子 id 
	 *  2. 获取浏览此帖子用户的 id 
	 *  3. 向 Praise 写入记录
	 ***/
	public String parisePost(long userId, long postId) {

		String result = (String) praiseDao.create(new Praise(userId, postId));
		if (result.equals(CommonDao.SUCCESS)) {
			return postDao.addPraiseNumber(postId);
		} else {
			return result;
		}
	}

	/**
	 * 取消赞帖子
	 ***/
	public String unparisePost(long userId, long postId) {
		String result = praiseDao.delete(userId, postId);
		if (result.equals(CommonDao.SUCCESS)) {
			return postDao.subPraiseNumber(postId);
		} else {
			return result;
		}
	}

	/**
	 * 获取帖子的赞数
	 ***/
	public long getPostPariseNumber(long postId) {
		Post post = (Post) postDao.findById(postId);
		if (post != null) {
			// System.out.println("PostService "+ postId
			// +" getPostPariseNumber:"+post.getPraiseNumber());
			return post.getPraiseNumber();
		} else {
			return 0;
		}
	}

	/**
	 * 查询用户是否点赞某篇帖子 不小于 0 的话就是用户已经点赞过了
	 ***/
	public Praise checkUserParisePost(long userId, long postId) {
		return praiseDao.findById(userId, postId);
	}

	/**
	 * 删除帖子
	 ***/
	public String deletePost(long postId) {
		return (String) postDao.delete(postId);
	}

	/**
	 * 举报帖子 
	 * 1. 举报帖子
	 * 2. 向管理员发送私信?
	 ***/
	// TODO 举报帖子
	public String complainPost(long userId, long postId, String reason) {
		return (String) complainDao.create(new Complain(userId, postId, reason));
//			LetterService letterServer = new LetterService();
//			Letter letter = new Letter();
//			letter.setContent("user" + this.getUser().getId()
//					+ this.getComplainReason());
//			letter.setSenderUserId(0); // 0 is System
//			letter.setReceiveUserId(1); // 1 is Admin
//			letterServer.setLetter(letter);
//			letterServer.sendLetter();
		
	}

	// TODO 帖子贴标签 或者消除标签
	public String tagPost(long userId, long postId, String tagName) {
		// 1. 添加或者删除帖子标签的赞数
		// 2. 修改帖子的赞数字段
		TagDao tagDao = new TagDao();
		Tag tag = new Tag();
		tag.setPostId(postId);
		tag.setTagName(tagName);
		tag.setUserId(userId);
		String tagResult = (String) tagDao.create(tag);
		if (tagResult.equals("SUCCESS")) {
			PostDao postDao = new PostDao();
			Post post = (Post) postDao.findById(postId);
			if (post != null) {
				post.setPraiseNumber(post.getPraiseNumber() - 1);
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
		// Tag tag = (Tag)tagDao.findByTagName(this.getPost().getId(),
		// this.getTagName());
		// if(tag != null) {
		// TagPraiseDao tagPraiseDao = new TagPraiseDao();
		//
		// TagPraise tagPraise = new TagPraise();
		// tagPraise.setPraiseUserId(this.getUser().getId());
		// tagPraise.setTagId(tag.getId());
		//
		// tagPraiseDao.create(tagPraise);
		// // 判断是赞同还是取消赞同
		// tag.setPraiseNumber(tag.getPraiseNumber() + 1);
		// tagDao.update(tag);
		// }
		return "";
	}

	// -------------------------------------------------

}
