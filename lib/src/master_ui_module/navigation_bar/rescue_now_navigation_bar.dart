import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/blocs/navigation_bar_resources/navigation_bar_bloc.dart';

enum CustomerSelectedTab { home, orders, profile }

class RescueNowNavigationBar extends StatefulWidget {
  const RescueNowNavigationBar({
    Key? key,
    required this.role,
  }) : super(key: key);

  final String role;

  @override
  State<RescueNowNavigationBar> createState() => _RescueNowNavigationBarState();
}

class _RescueNowNavigationBarState extends State<RescueNowNavigationBar> {
  late CustomerSelectedTab _customerSelectedTab;

  void _handleIndexChanged(int i) {
    setState(() {
      if (widget.role == 'Customer') {
        _customerSelectedTab = CustomerSelectedTab.values[i];
        BlocProvider.of<NavigationBarBloc>(context)
            .add(ChangeScreenInNavigationBar(
          indexOfItem: i,
          role: widget.role,
        ));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.role == 'Customer') {
      _customerSelectedTab = CustomerSelectedTab.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.role == 'Customer') {
      return DotNavigationBar(
        marginR: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        paddingR: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        backgroundColor: Colors.white,
        currentIndex: CustomerSelectedTab.values.indexOf(_customerSelectedTab),
        onTap: _handleIndexChanged,
        items: [
          /// Home
          DotNavigationBarItem(
            icon: Icon(Icons.home),
            selectedColor: Color(0xffE04F4C),
            unselectedColor: Colors.grey.shade400,
          ),

          /// Orders
          DotNavigationBarItem(
            icon: Icon(CupertinoIcons.cube_box_fill),
            selectedColor: Color(0xffE04F4C),
            unselectedColor: Colors.grey.shade400,
          ),

          /// Profile
          DotNavigationBarItem(
            icon: Icon(Icons.person),
            selectedColor: Color(0xffE04F4C),
            unselectedColor: Colors.grey.shade400,
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
