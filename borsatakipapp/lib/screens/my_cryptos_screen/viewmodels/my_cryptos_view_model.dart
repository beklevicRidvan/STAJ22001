import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/viewmodels/base_view_model.dart';
import 'package:flutter_fake_api/models/my_crypto_model.dart';
import 'package:flutter_fake_api/screens/my_cryptos_screen/my_cryptos_screen_service.dart';

class MyCryptosViewModel extends BaseViewModel{
  MyCryptosScreenService service;
  List<MyCryptoModel> myCryptos = [];
  MyCryptosViewModel({required this.service});
  @override
  FutureOr<void> init() async{
      await fetchDatas();
  }

  Future<void> fetchDatas()async{
    isLoading = true;
    try{
       myCryptos = await service.getDatas();
    }
    catch(e){
      debugPrint(e.toString());
    }
    finally{
      isLoading = false;
    }
  }

  Future<bool> deleteAndSellCrypto(MyCryptoModel myCryptoModel)async{
    isLoading = true;
    try{
      await service.sellCrypto(myCryptoModel.cryptoModel.coinId, myCryptoModel.totalPrice);
      return true;
    }
    catch(e){
      debugPrint(e.toString());
      return false;
    }
    finally{
      isLoading = false;
    }
  }

}