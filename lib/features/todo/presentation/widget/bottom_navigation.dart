import 'package:flutter/material.dart';
import 'package:firebas/features/todo/presentation/ui/info_page.dart';
import 'package:firebas/features/todo/presentation/ui/list_page.dart';
import 'package:firebas/features/todo/presentation/ui/more_page.dart';
import 'package:firebas/features/todo/presentation/widget/appbar_navigation.dart';
import 'package:firebas/features/todo/presentation/widget/drawer_navigation.dart';
class  BottomNavigationExample  extends StatefulWidget {
  @override
  _BottomNavigationExampleState createState() => _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<BottomNavigationExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    PageOne(),
    PageTwo(),
    PageThree(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarNavigation(onOptionSelected: _onAppBarOptionSelected,)
      ), 
      body: _selectedIndex < _pages.length ? _pages[_selectedIndex] : Container(), 
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Магазин',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Инфо',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more),
            label: 'Еще',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Обработчик нажатия на таб
      ),
      drawer: DrawerNavigation(onDrawerItemTap: _onDrawerItemTap), // Добавление бокового меню
    );
  }

  // Метод для обработки нажатия на таб
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

// Метод для обработки нажатия на пункт бокового меню
  void _onDrawerItemTap(int index) {
    Navigator.pop(context); // Закрыть боковое меню
    setState(() {
      _selectedIndex = index;
    });
  }

    // Метод для обработки выбора опции из AppBarNavigation
  void _onAppBarOptionSelected(int option) {
    switch (option) {
      case 1:
        _navigateToPage(PageOne());
        break;
      case 2:
        _navigateToPage(PageTwo());
        break;
      // Добавьте обработку других опций, если необходимо
    }
  }

  // Метод для переключения страницы
    void _navigateToPage(Widget page) {
    int pageIndex = _pages.indexWhere((widget) => widget.runtimeType == page.runtimeType);
    if (pageIndex != -1) {
      setState(() {
        _selectedIndex = pageIndex;
      });
    }
  }
}
