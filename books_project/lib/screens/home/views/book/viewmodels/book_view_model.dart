import 'dart:async';

import 'package:books_project/base/viewmodels/base_view_model.dart';
import 'package:books_project/components/alert_dialog.dart';
import 'package:books_project/models/book_model.dart';
import 'package:books_project/screens/home/views/book/book_service.dart';
import 'package:flutter/material.dart';

class BookViewModel extends BaseViewModel {
  BookService service;
  List<BookModel> _books = [];
  final TextEditingController _bookNameController = TextEditingController();

  BookViewModel({required this.service});

  @override
  FutureOr<void> init() async {
    await getDatas();
  }

  Future<void> getDatas() async {
    isLoading = true;
    try {
      _books = await service.getBookDatas();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
    }
  }

  Future<bool> addBookData(BuildContext context) async {
    isLoading = true;
    try {
      if (_bookNameController.text.isNotEmpty) {
        await service.addBookData(BookModel(kitapAdi: _bookNameController.text));
        return true;
      } else {
        showMyDialog(context, "Kitap Adı boş olamaz");
        return false;
      }
    } catch (e) {
      if (context.mounted) {
        showMyDialog(context, e.toString());
      }
      return false;
    }
    finally {
      isLoading = false;
      _bookNameController.clear();
    }
  }

  Future<void> deleteBookData(BuildContext context, String bookId) async {
    isLoading = true;
    try {
      await service.deleteBookData(bookId);
    } catch (e) {
      showMyDialog(context, e.toString());
    } finally {
      isLoading = false;
    }
  }

  Future<bool> updateBookData(BuildContext context,String bookId)async{
    isLoading = true;
    try{
      if(context.mounted){
        await service.updateBookData(bookId, _bookNameController.text);
        return true;
      }
      else{
        showMyDialog(context, "Kitap adı boş olamaz");
        return false;
      }
    }
    catch(e){
      debugPrint(e.toString());
      return false;
    }
    finally{
      isLoading = false;
    }
  }

  List<BookModel> get books => _books;

  TextEditingController get bookNameController => _bookNameController;
}
