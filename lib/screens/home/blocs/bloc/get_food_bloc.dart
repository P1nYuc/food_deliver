import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_repository/food_repository.dart';

part 'get_food_event.dart';
part 'get_food_state.dart';

class GetFoodBloc extends Bloc<GetFoodEvent, GetFoodState> {
  final FoodRepo _foodRepo;
  GetFoodBloc(this._foodRepo) : super(GetFoodInitial()) {
    on<GetFoodEvent>((event, emit)async { 
      emit(GetFoodLoading());
      try {
        List<Food> food = await _foodRepo.getFood();
        emit(GetFoodSuccess(food));
      } catch (e) {
        emit(GetFoodFailure());
      }
    });
  }
}
