import 'package:flutter_fake_api/base/services/firebase_service.dart';
import 'package:flutter_fake_api/base/services/network_service.dart';

import '../../../../translations/locale_keys.g.dart';

class SearchService {
  Future<NetworkResponseServices> getCoinsDatas() async {
    try {
      var coinCollectionRef = await FirebaseService.firebaseFirestore.collection('coins').get();
      var coinDocs = coinCollectionRef.docs;
      return NetworkResponseServices(isSucces: true, data: coinDocs, errorMessage: LocaleKeys.progressSuccess);
    } catch (e) {
      return NetworkResponseServices(isSucces: false, data: null, errorMessage: e.toString());
    }
  }
}
