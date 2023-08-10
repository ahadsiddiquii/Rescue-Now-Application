import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/blocs/navigation_bar_resources/navigation_bar_bloc.dart';

enum CustomerSelectedTab { home, orders, profile }

enum DriverSelectedTab { home, orders, profile }

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
  late DriverSelectedTab _driverSelectedTab;

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
      if (widget.role == 'Driver') {
        _driverSelectedTab = DriverSelectedTab.values[i];
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
    if (widget.role == 'Driver') {
      _driverSelectedTab = DriverSelectedTab.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.role == 'Customer') {
      return DotNavigationBar(
        marginR: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        paddingR: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        currentIndex: CustomerSelectedTab.values.indexOf(_customerSelectedTab),
        onTap: _handleIndexChanged,
        items: [
          /// Home
          DotNavigationBarItem(
            icon: const Icon(Icons.home),
            selectedColor: const Color(0xffE04F4C),
            unselectedColor: Colors.grey.shade400,
          ),

          /// Orders
          DotNavigationBarItem(
            icon: const Icon(CupertinoIcons.cube_box_fill),
            selectedColor: const Color(0xffE04F4C),
            unselectedColor: Colors.grey.shade400,
          ),

          /// Profile
          DotNavigationBarItem(
            icon: const Icon(Icons.person),
            selectedColor: const Color(0xffE04F4C),
            unselectedColor: Colors.grey.shade400,
          ),
        ],
      );
    }
    if (widget.role == 'Driver') {
      return DotNavigationBar(
        marginR: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        paddingR: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        currentIndex: DriverSelectedTab.values.indexOf(_driverSelectedTab),
        onTap: _handleIndexChanged,
        items: [
          /// Home
          DotNavigationBarItem(
            icon: const Icon(Icons.home),
            selectedColor: const Color(0xffE04F4C),
            unselectedColor: Colors.grey.shade400,
          ),

          /// Orders
          DotNavigationBarItem(
            icon: const Icon(CupertinoIcons.cube_box_fill),
            selectedColor: const Color(0xffE04F4C),
            unselectedColor: Colors.grey.shade400,
          ),

          /// Profile
          DotNavigationBarItem(
            icon: const Icon(Icons.person),
            selectedColor: const Color(0xffE04F4C),
            unselectedColor: Colors.grey.shade400,
          ),
        ],
      );
    }
    return const SizedBox();
  }
}
