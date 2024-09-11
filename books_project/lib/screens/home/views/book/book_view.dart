import 'package:books_project/base/constants/app_constants.dart';
import 'package:books_project/base/views/base_view.dart';
import 'package:books_project/components/alert_dialog.dart';
import 'package:books_project/components/my_text_field.dart';
import 'package:books_project/screens/home/views/book/book_service.dart';
import 'package:books_project/screens/home/views/book/viewmodels/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookView extends StatelessWidget {
  const BookView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(vmBuilder: (_) => BookViewModel(service: BookService()), builder: _buildScreenContent);
  }

  Widget _buildScreenContent(BuildContext context, BookViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          AppBar(
            title: const Text("Books"),
          ),
          viewModel.books.isEmpty
              ? const Center(
                  child: Text("Liste Boş"),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  shrinkWrap: true,
                  itemCount: viewModel.books.length,
                  itemBuilder: (context, index) {
                    var element = viewModel.books[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(element.kitapAdi),
                        leading: const Icon(Icons.lens_outlined),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [IconButton(onPressed: () {
                            viewModel.bookNameController.text = element.kitapAdi;
                            showDialog(
                              context: context,
                              builder: (context) => ChangeNotifierProvider<BookViewModel>.value(
                                value: viewModel,
                                child: Consumer<BookViewModel>(
                                  builder: (context, value, child) {
                                    return AlertDialog(
                                      title: MyTextField(controller: value.bookNameController),
                                      actions: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextButton(onPressed: (){
                                              value.bookNameController.text = "";
                                              Navigator.pop(context);
                                            }, child: Text("İptal")),
                                            TextButton(onPressed: ()async{
                                              bool myValue = await value.updateBookData(context,element.kitapId);
                                              value.bookNameController.text = "";
                                              if(myValue){
                                                Navigator.pop(context);
                                                await viewModel.getDatas();
                                              }
                                              else {
                                                showMyDialog(context, "haattaa");
                                              }
                                            }, child: Text("Tamam"))
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          }, icon: const Icon(Icons.edit)), IconButton(onPressed: () async{
                            await viewModel.deleteBookData(context, element.kitapId);
                            await viewModel.getDatas();

                          }, icon: Icon(Icons.clear))],
                        ),
                      ),
                    );
                  },
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ChangeNotifierProvider<BookViewModel>.value(
              value: viewModel,
              child: Consumer<BookViewModel>(
                builder: (context, value, child) {
                  return AlertDialog(
                    title: MyTextField(controller: value.bookNameController),
                    actions: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(onPressed: (){
                            value.bookNameController.text = "";
                            Navigator.pop(context);
                          }, child: Text("İptal")),
                          TextButton(onPressed: ()async{
                            bool myValue = await value.addBookData(context);
                           if(myValue){
                             Navigator.pop(context);
                             await viewModel.getDatas();
                           }
                           else {
                             showMyDialog(context, "haattaa");
                           }
                          }, child: Text("Tamam"))
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          );
        },
        backgroundColor: AppColorConstants.appBarColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
