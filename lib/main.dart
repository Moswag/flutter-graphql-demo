import 'package:architecture_app/blocs/books/books.dart';
import 'package:architecture_app/screens/home_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/home/home.dart';
import 'blocs/simple_delegate.dart';

void main() {
 // BlocSupervisor.delegate = MySimpleBlocDelegate();
  runApp(MyApp());
}

String query = r'''
query {
  accountListing(customerId:"9LNB1478945360957261"){
    ledgerBalance
    availableBalance
    bankAccountType
    currency
    accountName
    accountNumber
}
}
''';

String bookQuery = r'''
query{
  books{
    title
    author
  }
}
''';
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider<HomeBloc>(
        create: (BuildContext context) => HomeBloc()..add(FetchHomeData(query)),
      ),
        BlocProvider<BooksBloc>(
          create: (BuildContext context) => BooksBloc()..add(FetchBooksData(bookQuery)),
        ),
      ],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    ),
    );
  }
}

