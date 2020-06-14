class ApiPath {
  static String job({String uid, String jobId}) => '/users/$uid/jobs/$jobId';
  static String user(String uid) => '/users/$uid';
}
