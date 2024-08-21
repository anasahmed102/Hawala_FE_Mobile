import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hawala/features/auth/prenstation/view/login_screen/pages/test_list.dart';
import 'package:hawala/features/customer/presentation/cubit/customers_cubit.dart';
import 'package:hawala/features/hawala/presentation/cubit/hawala_cubit.dart';
import 'package:hawala/features/hawala/presentation/view/pages/hawala_list.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/service/profile_notifier_service.dart';
import 'package:hawala/shared/context_extension.dart';
import 'package:hawala/shared/enums.dart';
import 'package:hawala/shared/responsive.dart';

late TextEditingController _username;

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    getItClient<CustomersCubit>().getData(
        showMessage: ShowMessageEnum.showBothToast,
        source: DataSource.checkNetwork);
    getItClient<HawalaCubit>().getData(
        showMessage: ShowMessageEnum.showBothToast,
        source: DataSource.checkNetwork);
    super.initState();

    _username = TextEditingController();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showDialog(
          //   context: context,
          //   builder: (_) => AlertDialog(
          //     title: const Text("Add Todo"),
          //     content: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: TextField(
          //             controller: _username,
          //             decoration: const InputDecoration(
          //                 border: OutlineInputBorder(
          //                     borderRadius:
          //                         BorderRadius.all(Radius.circular(16))),
          //                 filled: true,
          //                 prefixIcon: Icon(
          //                   Icons.task,
          //                 ),
          //                 labelText: "Todo name"),
          //           ),
          //         ),
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width * 0.24,
          //           child: MaterialButton(
          //             color: Colors.amber,
          //             onPressed: () {
          //               final model =
          //                   CustomersModel(customerName: _username.text);
          //               getItClient<AddUpdateDeleteCustomerCubit>()
          //                   .addCustomer(model);
          //               // if (_username.text.isEmpty) return;
          //               // setState(() {
          //               //   _username.text = "";
          //               // });
          //               // Navigator.pop(context);
          //             },
          //             child: const Center(
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 children: [
          //                   Icon(
          //                     Icons.add,
          //                     color: Colors.white,
          //                   ),
          //                   SizedBox(
          //                     width: 10,
          //                   ),
          //                   Text(
          //                     "Add",
          //                     style: TextStyle(color: Colors.white),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: _widgetOptions,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.book),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: context.primaryColor,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
      ),
    );
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const HawalaListWidget(),
    const CustomersListWidget(),
    const Text("data"),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 200.h,
        ),
        Center(
          child: ElevatedButton(
            child: const Text("data"),
            onPressed: () {
              getItClient<ProfileNotifier>().signOut(true);
            },
          ),
        )
      ],
    )
  ];
}



  // String _getAppBarTitle() {
  //   switch (_selectedIndex) {
  //     case 0:
  //       return "products_appbar".tr(context);
  //     case 1:
  //       return 'Discovery'.tr(context);
  //     case 2:
  //       return 'Library'.tr(context);
  //     case 3:
  //       return 'Settings'.tr(context);
  //     default:
  //       return 'Default Title'; // Replace with your desired default title
  //   }
  // }