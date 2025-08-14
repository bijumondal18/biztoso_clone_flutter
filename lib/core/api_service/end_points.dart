class ApiEndPoints{
  static const String baseAuth = 'http://16.171.250.86:7521/api/';
  static const String baseCore = 'http://16.171.250.86:7524/api/';

  static const String getLanguageUrl = '${baseAuth}user/get_language';

  static const String loginWithEmailUrl = '${baseAuth}user/emailLogin';

  static const String getConnectionList = '${baseCore}network/connection/connection-list';
  static const String sentConnectionRequestList = '${baseCore}network/connection/list-send-request';
  static const String receivedConnectionRequestList = '${baseCore}network/connection/list-recevied-request';

}