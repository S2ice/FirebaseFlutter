import 'package:firebas/features/todo/presentation/ui/info_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebas/di/service.dart';
import 'package:firebas/features/todo/presentation/controller/todo_controller.dart';
import 'package:firebas/features/todo/presentation/ui/add_todo.dart';
import 'package:firebas/features/todo/presentation/ui/list_page.dart';
import 'package:firebas/routes/router_utils.dart';

import 'package:firebas/features/todo/presentation/widget/appbar_navigation.dart';
import 'package:firebas/features/todo/presentation/widget/bottom_navigation.dart';


class AppRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Pages.home.screenPath,
        name: Pages.home.screenName,
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => service<TodoController>()..init(),
          child: Scaffold(
            appBar: AppBarNavigation(onOptionSelected: (value) {
            }),
            bottomNavigationBar: BottomNavigationExample(),
            body: const PageOne(),
          ),
        ),
        routes: [
          GoRoute(
            path: Pages.addTodo.screenPath,
            name: Pages.addTodo.screenName,
            builder: (context, state) => ChangeNotifierProvider.value(
              value: service<TodoController>(),
              child: AddTodo(),
            ),
            routes: [
              GoRoute(
                path: Pages.info.screenPath,
                name: Pages.info.screenName,
                builder: (context, state) => ChangeNotifierProvider.value(
                  value: service<TodoController>(),
                  child: Scaffold(
                    appBar: AppBarNavigation(onOptionSelected: (value){
                    }),
                    body: PageTwo(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
