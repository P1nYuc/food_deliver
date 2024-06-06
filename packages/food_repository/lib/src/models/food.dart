import '../entities/entities.dart';

class Food{
  String foodId;
  String picture;
  bool isBeef;
  int spicy;
  String name;
  String description;
  int price;



  Food({
    required this.foodId,
    required this.picture,
    required this.isBeef,
    required this.spicy,
    required this.name,
    required this.description,
    required this.price,

  });

  FoodEntity toEntity(){
    return FoodEntity(
      foodId: foodId,
      picture: picture,
      isBeef: isBeef,
      spicy: spicy,
      name: name,
      description: description,
      price: price,
    );
  }
  static Food fromEntity(FoodEntity entity){
    return Food(
      foodId: entity.foodId,
      picture: entity.picture,
      isBeef: entity.isBeef,
      spicy: entity.spicy,
      name: entity.name,
      description: entity.description,
      price: entity.price,
    );
  }


  
}