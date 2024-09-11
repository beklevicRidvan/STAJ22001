import 'package:books_project/base/services/firebase_service.dart';
import 'package:books_project/models/book_model.dart';

class BookService {
  Future<List<BookModel>> getBookDatas() async {
    List<BookModel> books = [];
    try {
      var bookCollectionRef = await FirebaseService.firebaseFirestore.collection("books").get();
      var bookDocs = bookCollectionRef.docs;
      books = bookDocs
          .map(
            (e) => BookModel.fromMap(e.data()),
          )
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
    return books;
  }

  Future<void> addBookData(BookModel bookModel) async {
    try {
      String bookId = FirebaseService.firebaseFirestore.collection("books").doc().id;
      await FirebaseService.firebaseFirestore.collection("books").doc(bookId).set(bookModel.toMap(bookId));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteBookData(String bookId) async {
    try {
      await FirebaseService.firebaseFirestore.collection("books").doc(bookId).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateBookData(String bookId, String updatedBookName) async {
    try {
      await FirebaseService.firebaseFirestore.collection("books").doc(bookId).update({"kitapAdi": updatedBookName});
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
