import 'package:books_project/base/views/base_view.dart';
import 'package:books_project/components/nonnuble_text.dart';
import 'package:books_project/screens/home/views/profile/profile_service.dart';
import 'package:books_project/screens/home/views/profile/viewmodels/profile_view_model.dart';
import 'package:books_project/utils/sharredpref_util.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(vmBuilder: (_)=> ProfileViewModel(service: ProfileService()), builder: _buildScreenContent);  }

  Widget _buildScreenContent(BuildContext context, ProfileViewModel viewModel) {
    return Column(
      children: [
        AppBar(title: const Text("Profile"),),
       Expanded(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             const Text("EMAİL"),
             Center(
               child: Card(
                 margin: const EdgeInsets.symmetric(horizontal: 16),
                 child: ListTile(
                   title: NonnullableText(text: SharedPreferencesUtil().getEmail()),
                 ),
               ),
             ),
             const SizedBox(height: 30,),
             const Text("FULL NAME"),
             Center(
               child: Card(
                 margin: const EdgeInsets.symmetric(horizontal: 16),

                 child: ListTile(
                   title: NonnullableText(text: SharedPreferencesUtil().getFullName()),
                 ),
               ),
             ),
           ],
         ),
       )
      ],
    );
  }
}
