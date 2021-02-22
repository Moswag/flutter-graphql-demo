import 'package:architecture_app/blocs/home/home.dart';
import 'package:architecture_app/screens/books_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [];

  @override
  void initState() {
    super.initState();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('GraphQL Demo'),
      leading: IconButton(icon: Icon(Icons.add),onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (BuildContext con)=>BooksScreen())),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (BuildContext context, HomeStates state) {
        if (state is Loading) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: LinearProgressIndicator(),
          );
        } else if (state is LoadDataFail) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: Center(child: Text(state.error.toString())),
          );
        } else {
          data = (state as LoadDataSuccess).data['accountListing'];
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(),
          );
        }
      },
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          var item = data[index];
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Text(item['availableBalance']),
              title: Text(item['accountName']),
              subtitle: Text(item['accountNumber']),
              trailing: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: item['bankAccountType'] == 'EWallet'
                      ? Colors.red.withOpacity(0.3)
                      : item['bankAccountType'] == 'Cash 24'
                      ? Colors.green.withOpacity(0.3)
                      : Colors.amber.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Text(
                  item['bankAccountType'],
                  style: TextStyle(
                      color: item['bankAccountType'] == 'EWallet'
                          ? Colors.red
                          : item['bankAccountType'] == 'Cash 24'
                          ? Colors.green
                          : Colors.amber),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}