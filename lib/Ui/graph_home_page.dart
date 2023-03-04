import 'package:demo_app/Services/api_repository.dart';
import 'package:demo_app/bloc/DictionaryBloc/dictionary_bloc_bloc.dart';
import 'package:demo_app/models/dictionary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraphHomePage extends StatefulWidget {
  const GraphHomePage({super.key});

  @override
  State<GraphHomePage> createState() => _GraphHomePageState();
}

class _GraphHomePageState extends State<GraphHomePage> {
  TextEditingController searchWordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // BlocProvider.of<DictionaryBlocBloc>(context).add(
    //   GetWordList(
    //     "hello",
    //   ),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 5, 55, 96),
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon:
                            const Icon(Icons.drag_handle, color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "ANNEX",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_alert,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 8),
                      child: TextField(
                        controller: searchWordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.search),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                            // const BorderSide(color: Colors.transparent),
                          ),
                        ),
                        // onChanged: (value) {
                        //   print("value from onChanged $value");
                        // },
                        onSubmitted: (value) {
                          print("value from submit $value");
                          BlocProvider.of<DictionaryBlocBloc>(context).add(
                            GetWordList(
                              value,
                            ),
                          );
                          searchWordController.clear();
                          // print("value from bloc $x");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<DictionaryBlocBloc, DictionaryBlocState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                print("nnnnnnnnnnnn${state.props.toString()}");
                print("x1");
                if (state is DictionaryBlocInitial) {
                  print("x2");
                  print("state x2 ${state.props}");

                  return const Center(child: CircularProgressIndicator());
                }
                //    else if (state is DictionaryBlocSearching) {
                //     return Center(child: CircularProgressIndicator());
                //  }
                else if (state is DictionaryBlocSearched) {
                  print("x3");
                  print("event theke asha state${state.words}");
                  List x = state.words;

                  return Expanded(
                    child: ListView.builder(
                        itemCount: x.length,
                        itemBuilder: (context, index) {
                          print(state.words.length);
                          return Column(
                            children: [
                              Text(state.words[index].word.toString())
                            ],
                          );
                        }),
                  );
                } else if (state is ErrorState) {
                  print("x4");

                  return Container(
                    child: Text("Error"),
                  );
                } else {
                  print("x5");
                  return Container(
                    child: Text("x5 Error"),
                  );
                }
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.payment_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.stacked_line_chart_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
        ],
      )),
    );
  }
}

//  Container(
//             color: Color.fromARGB(255, 8, 53, 90),
//             height: 300,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(Icons.abc),
//                     ),
//                     TextButton(
//                       onPressed: () {},
//                       child: Text("Annex"),
//                     ),
//                     IconButton(
//                         onPressed: () {}, icon: Icon(Icons.add_alert_rounded))
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
//                   child: TextField(
//                     controller: searchWordController,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       prefixIcon: const Icon(Icons.search),
//                       border: InputBorder.none,
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                         // const BorderSide(color: Colors.transparent),
//                       ),
//                     ),
//                     onSubmitted: (value) {
//                       print(searchWordController.text.toString());
//                       print("x1");
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//                 itemCount: 2,
//                 itemBuilder: (context, index) {
//                   return Text(searchWordController.text.toString());
//                 }),
//           )
