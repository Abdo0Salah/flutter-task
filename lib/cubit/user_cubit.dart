import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_route/cubit/user_state.dart';

import '../apiModels/ProductModel.dart';
import '../repositories/user_repository.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepository) : super(UserInitial());

  final UserRepository userRepository;

  final List<Products> products = [];

  getProducts() async {
    emit(UserLoadingState());
    final response = await userRepository.getProducts();
    response.fold(
          (errMessage) => emit(UserFailureState(errMessage: errMessage)),
          (productList) {
        products
          ..clear()
          ..addAll(productList);
        emit(UserSuccessState());
      },
    );
  }
}
