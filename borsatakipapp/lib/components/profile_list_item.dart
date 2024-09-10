import 'package:flutter/material.dart';
import 'package:flutter_fake_api/utils/navigation_utils.dart';

import '../base/constants/app_constants.dart';

class ProfileListItem extends StatelessWidget {
  final int index;
  final int length;
  final Function() func;
  final String title;
  final Function() favoritesFunc;
  const ProfileListItem({super.key,required this.index,required this.length,required this.func,required this.title,required this.favoritesFunc});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 6),
      color: AppColorConstants.containerColor,
      child: ListTile(
        title:  Text(title),
        leading: index == length -1 ? const Icon(Icons.logout) : const Icon(Icons.play_arrow_sharp),
        onTap: (){
          if(index == length -1){
            func();
          }
          else if(index == 0){
            NavigationUtils.navigateToProfileSettingsScreen(context);
          }
          else if(index == 1){
            favoritesFunc();
          }
          else {

          }
        },
      ),
    );
  }
}
