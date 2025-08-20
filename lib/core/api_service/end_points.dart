class ApiEndPoints {
  static const String baseAuth = 'http://16.171.250.86:7521/api/';
  static const String baseCore = 'http://16.171.250.86:7524/api/';
  static const String basePost = 'http://16.171.250.86:7522/api/';

  static const String getLanguageUrl = '${baseAuth}user/get_language';

  static const String loginWithEmailUrl = '${baseAuth}user/emailLogin';

  static const String getCurrentUsersConnectionList =
      '${baseCore}network/connection/connection-list';
  static const String allConnectionList =
      '${baseCore}network/connection/list-user';
  static const String sentConnectionRequestList =
      '${baseCore}network/connection/list-send-request';
  static const String receivedConnectionRequestList =
      '${baseCore}network/connection/list-recevied-request';
  static const String acceptConnectionRequestList =
      '${baseCore}network/connection/accept-request';
  static const String declineConnectionRequestList =
      '${baseCore}network/connection/decline-request';
  static const String cancelConnectionRequestList =
      '${baseCore}network/connection/cancle-request';
  static const String sendConnectionRequest =
      '${baseCore}network/connection/send-request';

  static const String getChatList =
      '${baseCore}network/inbox/chat/get-user-chats';

  static const String fetchProfileDetails = '${baseAuth}user/details';
  static const String fetchBlogList = '${baseAuth}user/menu/list-blog';

  static const String feedListUrl =
      '${basePost}marketPlace/post/home-post-list-with-pagination';
}
