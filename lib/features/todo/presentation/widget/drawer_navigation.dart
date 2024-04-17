import 'package:flutter/material.dart';

class DrawerNavigation extends StatelessWidget {
  final Function(int) onDrawerItemTap;

  DrawerNavigation({required this.onDrawerItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Логотип',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Магазин'),
            onTap: () {
              onDrawerItemTap(0); 
            },
          ),
          ListTile(
            title: Text('Инфо'),
            onTap: () {
              onDrawerItemTap(1); 
            },
          ),
          ListTile(
            title: Text('Еще'),
            onTap: () {
              onDrawerItemTap(2); 
            },
          ),
          
        ],
      ),
    );
  }
}
