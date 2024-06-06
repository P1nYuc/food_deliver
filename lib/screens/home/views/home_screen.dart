import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_deliver/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:food_deliver/screens/home/blocs/bloc/get_food_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          children: [
            // Image.asset(
            //   'assets/lurofan.jpg',
            //   scale: 14,
            // ),
            Icon(Icons.fastfood, color: Colors.yellow[800]),
            Text(
              'Food',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Colors.yellow[800],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: Icon(CupertinoIcons.arrow_right_to_line),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<GetFoodBloc, GetFoodState>(
          bloc: BlocProvider.of<GetFoodBloc>(context),
          builder: (context, state) {
            print('state: $state');
            if (state is GetFoodLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            else if (state is GetFoodSuccess){
              
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //number of columns
                    crossAxisSpacing: 10, //spacing between the columns
                    mainAxisSpacing: 10, //spacing between the rows
                    childAspectRatio: 0.5, //aspect ratio of the grid view
                  ),
                  itemCount: state.food.length,
                  itemBuilder: (context, int i) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.network(
                            state.food[i].picture,
                            width: 200, // Set your desired width here
                            height: 200, // Set your desired height here
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red[800],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8.0),
                                    child: Text(
                                      state.food[i].isBeef ? '🥩Beef' : 'NO-Beef',
                                      style: TextStyle(
                                        color: state.food[i].isBeef ? Colors.brown : Colors.grey[800],
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green[800],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8.0),
                                    child: Text(
                                      state.food[i].spicy==1?'NO-Spicy': state.food[i].spicy==2?'🌶️🌶️':'🌶️🌶️🌶️',
                                      style: TextStyle(
                                        color:
                                         state.food[i].spicy==1?Colors.blue:
                                          state.food[i].spicy==2?Colors.orange:
                                          Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              state.food[i].name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              state.food[i].description,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 10,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '\$'+state.food[i].price.toString(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
              }   else {
                return const Center(child: Text('Failed to load food'));
              }
              
            },
        ),
      ),
    );
  }
}
