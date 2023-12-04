class UrlService {
  String baseUrl =
      'https://kostiaraamarta.politesky-22f54108.eastus.azurecontainerapps.io/';
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}
