/// [url]이 Network Image Url일 경우 true
bool isNetworkImage(String url) {
  return url.startsWith('http') || url.startsWith('https');
}
