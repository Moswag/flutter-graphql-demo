import 'package:equatable/equatable.dart';

abstract class BooksEvents extends Equatable {
  BooksEvents();

  @override
  List<Object> get props => null;
}

class FetchBooksData extends BooksEvents {
  final String query;
  final Map<String, dynamic> variables;

  FetchBooksData(this.query, {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}