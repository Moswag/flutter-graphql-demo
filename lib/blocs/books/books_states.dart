import 'package:equatable/equatable.dart';

abstract class BooksStates extends Equatable {
  BooksStates();

  @override
  List<Object> get props => null;
}

class BooksLoading extends BooksStates {
  BooksLoading() : super();
}

class BooksLoadDataSuccess extends BooksStates {
  final dynamic data;

  BooksLoadDataSuccess(this.data) : super();

  @override
  List<Object> get props => data;
}

class BooksLoadDataFail extends BooksStates {
  final dynamic error;

  BooksLoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}