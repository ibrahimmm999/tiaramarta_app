class UrlService {
  String baseUrl =
      'https://kostiaraamarta.ashyhill-b518ef35.australiaeast.azurecontainerapps.io/';
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}
