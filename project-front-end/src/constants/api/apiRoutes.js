const API_ROUTES = {
  login: '/api/v1/auth',
  signup: '/users',
  groups: '/api/v1/group',
  userGroups: '/api/v1/user/groups',
  user: '/api/v1/user',
  publicPosts: '/api/v1/posts',
  userPosts: '/api/v1/user/post',
  post: '/api/v1/user/post',
  tags: '/api/v1/tags',
  tagPublicPosts: '/api/v1/tag',
  postVote: '/api/v1/post',
  postDetails: '/api/v1/posts',
  comments: '/api/v1/post',
  answer: '/api/v1/post',
  addBookmark: '/api/v1/post',
  deleteBookmark: '/api/v1/bookmark',
  userBookmarkPost: '/api/v1/user/bookmark_post',
  reply: '/api/v1/comment',
  updateUser: '/api/v1/user',
  users: '/api/v1/users',
  createGroup: '/api/v1/group',
  logout: '/api/v1/logout',
  comment: '/api/v1/comment',
  acceptAnswer: '/api/v1/comment',
};

export default API_ROUTES;
