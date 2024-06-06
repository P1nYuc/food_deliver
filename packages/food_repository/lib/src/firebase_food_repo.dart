import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_repository/food_repository.dart';

import 'entities/entities.dart';
import 'models/food.dart';

class FirebaseFoodRepo implements FoodRepo {
  final foodCollection = FirebaseFirestore.instance.collection('food');

  @override
  Future<List<Food>> getFood() async {
    try {
      return await foodCollection
      .get()
      .then((value) => value.docs.map(
        (e) => Food.fromEntity(FoodEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
  

}