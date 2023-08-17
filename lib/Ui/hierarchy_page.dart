import 'package:demo_app/utils/customscroll.dart';
import 'package:flutter/material.dart';

class HierarchyScreen extends StatefulWidget {
  const HierarchyScreen({super.key});

  @override
  State<HierarchyScreen> createState() => _HierarchyScreenState();
}

class _HierarchyScreenState extends State<HierarchyScreen> {
  ScrollController _controller = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  //   _controller.animateTo(_controller.offset + 60,
  //       duration: Duration(milliseconds: 500), curve: Curves.linear);
  // }

  // void _animateToPosition(double position) {
  //   _controller.animateTo(
  //     position,
  //     duration: Duration(milliseconds: 500),
  //     curve: Curves.easeInOut,
  //   );
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                key: const ValueKey(4),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(0.0),

                    child: ExpansionTile(
                      title: SizedBox(
                        height: 100,
                        child: Card(
                          color: Colors.amber,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: const ListTile(
                            leading: Text("Leading"),
                            trailing: Text("trailing"),
                          ),
                        ),
                      ),
                      children: [
                        ListView.builder(
                            // key: ValueKey(3),
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return ExpansionTile(
                                title: SizedBox(
                                  height: 100,
                                  child: Card(
                                    color: Colors.amber,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const ListTile(
                                      leading: Text("Leading"),
                                      trailing: Text("trailing"),
                                    ),
                                  ),
                                ),
                                children: [
                                  NotificationListener<ScrollEndNotification>(
                                    onNotification: (scrollState) {
                                      if (scrollState
                                              is ScrollEndNotification &&
                                          scrollState.metrics.pixels != 400) {
                                        Future.delayed(
                                                const Duration(
                                                    milliseconds: 100),
                                                () {})
                                            .then((s) {
                                          _controller.animateTo(200,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.ease);
                                        });
                                      }
                                      return false;
                                    },
                                    child: ListView.builder(
                                      key: const ValueKey(2),
                                      itemCount: 10,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: const [
                                              Text("data                    "),
                                              Text("data                    "),
                                              Text("data                    "),
                                              Text("data                    "),
                                              Text("data                    "),
                                              Text("data                    "),
                                            ],
                                          ),
                                        );
                                      },
                                      // scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                  const Text("datat   "),
                                  const Text("datat   "),
                                  const Text("datat   "),
                                  const Text("datat   ")
                                ],
                              );
                            }),
                      ],
                    ),
                    // ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
