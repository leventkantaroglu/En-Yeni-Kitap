import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/models/book.dart';
import 'package:enyenikitap/models/bookCategory.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Books with ChangeNotifier {
  Firestore _firestore;
  List<Book> homePageBooks = [];
  List<Book> publisherBooks = [];
  List<Book> bookCategoryBooks = [];
  Book currentHomeTabBook=Book.withEmptyValues();
  Book currentPublisherTabBook=Book.withEmptyValues();
  Book currentBookCategoryTabBook=Book.withEmptyValues();
  Book currentMemberTabBook=Book.withEmptyValues();

  Books() {
    //this.list=list;
    this._firestore = Firestore.instance;
    // getBooksDataFromDataSource();
    //print("init Books");
  }
/* 
  getBooksDataFromDataSource() async {
    var snapshots = await _firestore
        .collection("books")
        //.limit(20) // !!! limit is 20
        .getDocuments();
    snapshots.documents.forEach((snapshot) {
      Book curBook = Book.fromDataSource(snapshot.data, snapshot.documentID);
      this.bookList.add(curBook);
    });
    notifyListeners();
  } */

/*   Book currentBook(uid) {
    print("test");
    list.forEach((Book bookListItem) {
      if (bookListItem.uid == uid) {
        return bookListItem;
      }else{
        print("not found");
      }
    });
  } */

  getBookCategoryDetails(bookUid, bookCategoryUid) async {
    _firestore = Firestore.instance;
    var query = await _firestore
        .collection("bookCategories")
        .document(bookCategoryUid)
        .get();

    bookCategoryBooks.forEach((listItem) {
      if (listItem.uid == bookUid) {
        if (query.data != null) {
          listItem.bookCategory =
              BookCategory.fromDataSource(query.data, query.documentID);
        } else {
          //print("-->O" + query.data.toString());
          listItem.bookCategory = BookCategory.withDefaultValues();
        }
        notifyListeners();
      }
    });
  }

  void getHomeBooks(limit) async {
    var snapshots = await _firestore
        .collection("books")
        //.limit(limit) //!!! limit 20 for homepage
        .getDocuments();
    if (snapshots != null) {
      homePageBooks.clear();
      snapshots.documents.forEach((snapshot) {
        Book curBook = Book.fromDataSource(snapshot.data, snapshot.documentID);
        homePageBooks.add(curBook);
      });
      notifyListeners();
    }
  }

  void getBooksByType(type, uid) async {
    String criteriaField;
    switch (type) {
      case "bookCategory":
        criteriaField = "bookCategory";
        // bookCategoryBooks.clear();
        break;
      case "publisher":
        criteriaField = "publisher";
        //publisherBooks.clear();
        break;
      default:
    }

    var snapshots = await _firestore
        .collection("books")
        .where(criteriaField, isEqualTo: uid)
        .getDocuments();

    if (snapshots != null) {
      switch (type) {
        case "bookCategory":
          //criteriaField = "bookCategory";
          bookCategoryBooks.clear();
          break;
        case "publisher":
          //criteriaField = "publisher";
          publisherBooks.clear();
          break;
        default:
      }
      //notifyListeners();
      snapshots.documents.forEach((snapshot) {
        Book curBook = Book.fromDataSource(snapshot.data, snapshot.documentID);
        switch (type) {
          case "bookCategory":
            bookCategoryBooks.add(curBook);
            break;
          case "publisher":
            publisherBooks.add(curBook);
            break;
          default:
        }
      });
      notifyListeners();
    }
  }

  getPublisherDetails({@required uid, @required source}) async {
    //_firestore = Firestore.instance;
    var query = await _firestore.collection("publishers").document(uid).get();
    if (query.data != null) {
      switch (source) {
        case "home":
          currentHomeTabBook.publisher =
              Publisher.fromDataSource(query.data, query.documentID);
          break;
        case "bookCategory":
          currentBookCategoryTabBook.publisher =
              Publisher.fromDataSource(query.data, query.documentID);
          break;
        case "publisher":
          currentPublisherTabBook.publisher =
              Publisher.fromDataSource(query.data, query.documentID);
          break;
        case "member":
          currentMemberTabBook.publisher =
              Publisher.fromDataSource(query.data, query.documentID);
          break;
        default:
      }
      //this.publisher = Publisher.fromDataSource(query.data, query.documentID);
    } else {
      switch (source) {
        case "home":
          currentHomeTabBook.publisher =
              Publisher.withDefaultValues();
          break;
        case "bookCategory":
          currentBookCategoryTabBook.publisher =
              Publisher.withDefaultValues();
          break;
        case "publisher":
          currentPublisherTabBook.publisher =
              Publisher.withDefaultValues();
          break;
        case "member":
          currentMemberTabBook.publisher =
              Publisher.withDefaultValues();
          break;
        default:
      }
      //this.publisher = Publisher.withDefaultValues();
    }
    notifyListeners();
  }
}
