import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/views/base_view.dart';
import 'package:flutter_fake_api/main.dart';
import 'package:flutter_fake_api/screens/profile_settings/profile_settings_service.dart';

import 'view/profile_settings_view.dart';
import 'view_model/profile_settings_view_model.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen>with RouteAware  {
  late ProfileSettingsScreenViewModel viewModel;


  @override
  void didPopNext() {
    // TODO: implement didPopNext
    super.didPopNext();
    viewModel.refresh();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  void initState() {
    super.initState();
    viewModel = ProfileSettingsScreenViewModel(service: ProfileSettingsService());
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,body: BaseView<ProfileSettingsScreenViewModel>(vmBuilder: (_) => ProfileSettingsScreenViewModel(service: ProfileSettingsService()), builder: _buildScreenContent),);
  }

  Widget _buildScreenContent(BuildContext context, ProfileSettingsScreenViewModel viewModel) {
  return IgnorePointer(
    ignoring: viewModel.isLoading,
    child: ProfileSettingsView(viewModel:viewModel),
  );

  }
}
