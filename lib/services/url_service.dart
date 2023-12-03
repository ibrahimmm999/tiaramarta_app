class UrlService {
  String baseUrl = 'http://10.0.2.2:8000/';
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}
