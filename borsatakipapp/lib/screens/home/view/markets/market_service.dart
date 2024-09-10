import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fake_api/base/services/firebase_service.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';

import '../../../../base/services/network_service.dart';
import '../../../../models/money_model.dart';
import '../../../../translations/locale_keys.g.dart';

class MarketService {
  Future<NetworkResponseServices> fetchDatas(String type) async {
    var dio = Dio();

    String url = 'https://api.collectapi.com/economy/currencyToAll?int=1&base=$type';

    try {
      /*
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'authorization': 'apikey ${LocaleConstants.apiKey}',
            'content-type': 'application/json',
          },
        ),
      );

       */

      /*

      debugPrint(response.toString());

      if (response.statusCode == 200) {
        debugPrint(response.data['response'].toString());
        return NetworkResponseServices(isSucces: true, data: response.data, errorMessage: LocaleKeys.progressSuccess);
      } else {
        return NetworkResponseServices(isSucces: false, data: null, errorMessage: response.statusMessage.toString());
      }

       */
      var collectionRef = await FirebaseService.firebaseFirestore.collection('kurlar').get();
      return NetworkResponseServices(
          isSucces: true,
          data: collectionRef.docs
              .map(
                (e) => MoneyModel.fromMap(e.data(), null),
              )
              .toList(),
          errorMessage: LocaleKeys.progressSuccess.locale);
    } catch (e) {
      return NetworkResponseServices(isSucces: false, data: null, errorMessage: e.toString());
    }
  }

  Future<NetworkResponseServices> updateBalanceValue(double value, bool IsIncrement) async {
    User? currentUser = FirebaseService.firebaseAuth.currentUser;
    try {
      if (currentUser != null) {
        await FirebaseService.firebaseFirestore
            .collection('myUsers')
            .doc(currentUser.uid)
            .update({'balance': FieldValue.increment(IsIncrement ? value : -value)});
        return NetworkResponseServices(isSucces: true, data: null, errorMessage: LocaleKeys.progressSuccess.locale);
      } else {
        throw Exception(LocaleKeys.userEmptyError);
      }
    } catch (e) {
      return NetworkResponseServices(isSucces: false, data: null, errorMessage: e.toString());
    }
  }

  Future<int> getFollowedByListLength() async {
    User? currentUser = FirebaseService.firebaseAuth.currentUser;
    try {
      if (currentUser != null) {
        return await FirebaseService.firebaseFirestore.collection('myUsers').doc(currentUser.uid).collection('favorites').get().then(
              (value) => value.docs.length,
            );
      } else {
        throw Exception(LocaleKeys.userEmptyError);
      }
    } catch (e) {
      throw FirebaseException(plugin: e.toString());
    }
  }
}
