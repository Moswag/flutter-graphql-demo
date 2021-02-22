import 'package:architecture_app/services/graphql_service.dart';
import 'package:bloc/bloc.dart';
import 'books.dart';

class BooksBloc extends Bloc<BooksEvents, BooksStates> {
  GraphQLService service;

  BooksBloc() {
    service = GraphQLService();
  }

  @override
  BooksStates get initialState => BooksLoading();

  @override
  Stream<BooksStates> mapEventToState(BooksEvents event) async* {
    if (event is FetchBooksData) {
      yield* _mapFetchBooksDataToStates(event);
    }
  }

  Stream<BooksStates> _mapFetchBooksDataToStates(FetchBooksData event) async* {
    final query = event.query;
    final variables = event.variables ?? null;

    try {
      final result = await service.performMutation(query, variables: variables);

      if (result.hasException) {
        print('graphQLErrors: ${result.exception.graphqlErrors.toString()}');
        print('clientErrors: ${result.exception.clientException.toString()}');
        yield BooksLoadDataFail(result.exception.graphqlErrors[0]);
      } else {
        yield BooksLoadDataSuccess(result.data);
      }
    } catch (e) {
      print(e);
      yield BooksLoadDataFail(e.toString());
    }
  }
}