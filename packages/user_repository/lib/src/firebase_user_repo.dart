import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/user.dart';
import 'package:user_repository/src/user_repo.dart';


class FirebaseUserRepo implements UserRepository{
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }):_firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  // TODO: implement user
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser)async*{
      if(firebaseUser == null){//如果 firebaseUser 是空的，則發出一個空的 MyUser 對象。
        yield MyUser.empty;
      }else{//如果 firebaseUser 不是空的，則從 Firestore 中獲取用戶的數據。
       yield await userCollection //Firestore 中的 users 集合。
        .doc(firebaseUser.uid) //是從這個集合中獲取特定文檔（根據用戶的 UID）。
        .get() //是一個異步操作，從 Firestore 中獲取這個文檔的快照（DocumentSnapshot）。
        .then((value) => MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!))); //將 DocumentSnapshot 轉換為 MyUser 對象。
      }

    }); 

    
  }
 
  @override
  Future<void> signIn(String email, String password) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print(e.toString());
      rethrow;  
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async{
    try{
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password
        );

        myUser.userId = user.user!.uid;

        return myUser;
    }catch(e){
      print(e.toString());
      rethrow;  
    }
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> setUserData(MyUser user) async{
    try{
      await userCollection.doc(user.userId).set(user.toEntity().toDocument());
    }catch(e){
      print(e.toString());
      rethrow;  
    }
  }


}