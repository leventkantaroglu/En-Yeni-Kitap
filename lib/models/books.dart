import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/models/book.dart';
import 'package:enyenikitap/models/bookCategories.dart';
import 'package:enyenikitap/models/bookCategory.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Books with ChangeNotifier {
  Firestore _firestore;
  List<Book> homePageBooks = [];
  List<Book> publisherBooks = [];
  List<Book> bookCategoryBooks = [];
  Book currentHomeTabBook = Book.withEmptyValues();
  Book currentPublisherTabBook = Book.withEmptyValues();
  Book currentBookCategoryTabBook = Book.withEmptyValues();
  Book currentMemberTabBook = Book.withEmptyValues();

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

  getBookCategoryDetails({uid, source}) async {
    var query = await _firestore.collection("bookCategories").document(uid).get();
    if (query.data != null) {
      switch (source) {
        case "home":
          currentHomeTabBook.bookCategory =
              BookCategory.fromDataSource(query.data, query.documentID);
          break;
        case "bookCategory":
          currentBookCategoryTabBook.bookCategory =
              BookCategory.fromDataSource(query.data, query.documentID);
          break;
        case "publisher":
          currentPublisherTabBook.bookCategory =
              BookCategory.fromDataSource(query.data, query.documentID);
          break;
        case "member":
          currentMemberTabBook.bookCategory =
              BookCategory.fromDataSource(query.data, query.documentID);
          break;
        default:
      }
    } else {
      switch (source) {
        case "home":
          currentHomeTabBook.bookCategory = BookCategory.withDefaultValues();
          break;
        case "bookCategory":
          currentBookCategoryTabBook.bookCategory = BookCategory.withDefaultValues();
          break;
        case "publisher":
          currentPublisherTabBook.bookCategory = BookCategory.withDefaultValues();
          break;
        case "member":
          currentMemberTabBook.bookCategory = BookCategory.withDefaultValues();
          break;
        default:
      }
    }
    notifyListeners();
  }

  static Future getHomeBooks(limit) async {
    var _firestore = Firestore.instance;
    List<Book> curBooks = [];
    var snapshots = await _firestore
        .collection("books")
        .orderBy("publishDate", descending: true)
        //.limit(limit) //!!! limit 20 for homepage
        .getDocuments();
    if (snapshots != null) {
      snapshots.documents.forEach((snapshot) {
        Book curBook = Book.fromDataSource(snapshot.data, snapshot.documentID);
        curBooks.add(curBook);
      });
    }
    return curBooks;
  }

  static Future getBooksByType(type, uid) async {
    var _firestore = Firestore.instance;
    List<Book> curBooks = [];
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
          //bookCategoryBooks.clear();
          break;
        case "publisher":
          //criteriaField = "publisher";
          //publisherBooks.clear();
          break;
        default:
      }
      //notifyListeners();
      snapshots.documents.forEach((snapshot) {
        Book curBook = Book.fromDataSource(snapshot.data, snapshot.documentID);
        curBooks.add(curBook);
        /* switch (type) {
          case "bookCategory":
            //bookCategoryBooks.add(curBook);
            break;
          case "publisher":
            //publisherBooks.add(curBook);
            break;
          default:
        } */
      });

      //notifyListeners();
    }
    return curBooks;
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
          currentHomeTabBook.publisher = Publisher.withDefaultValues();
          break;
        case "bookCategory":
          currentBookCategoryTabBook.publisher = Publisher.withDefaultValues();
          break;
        case "publisher":
          currentPublisherTabBook.publisher = Publisher.withDefaultValues();
          break;
        case "member":
          currentMemberTabBook.publisher = Publisher.withDefaultValues();
          break;
        default:
      }
      //this.publisher = Publisher.withDefaultValues();
    }
    notifyListeners();
  }
}
