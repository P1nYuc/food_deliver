import 'dart:math';

class FoodEntity{
  String foodId;
  String picture;
  bool isBeef;
  int spicy;
  String name;
  String description;
  int price;



  FoodEntity({
    required this.foodId,
    required this.picture,
    required this.isBeef,
    required this.spicy,
    required this.name,
    required this.description,
    required this.price,
  });

    Map<String, Object?> toDocument(){
    return {
      'foodId': foodId,
      'picture': picture,
      'isBeef': isBeef,
      'spicy': spicy,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  static FoodEntity fromDocument(Map<String, dynamic> doc){
    return FoodEntity(
      foodId: doc['foodId'] as String,
      picture: doc['picture'] as String,
      isBeef: doc['isBeef'] as bool,
      spicy: doc['spicy'] as int,
      name: doc['name'] as String,
      description: doc['description'] as String,
      price: doc['price'] as int,
    );
  }
}