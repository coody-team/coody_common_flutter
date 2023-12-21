import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkUtil {
  const DynamicLinkUtil._();

  static Future<String> generateShortLink(
    String path, {
    required String dynamicLinkUrl,
    required String packageName,
    String? socialMediaTitle,
    Uri? socialMediaImageUrl,
  }) async {
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: dynamicLinkUrl,
      link: Uri.parse('$dynamicLinkUrl$path'),
      androidParameters: AndroidParameters(
        packageName: packageName,
        // minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: packageName,
        // minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: socialMediaTitle,
        imageUrl: socialMediaImageUrl,
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    return dynamicLink.shortUrl.toString();
  }
}
