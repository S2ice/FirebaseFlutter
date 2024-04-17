import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  final List<String> employeeNames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Сотрудники'),
              background: Image.network(
                'http://pic46.photophoto.cn/20180107/0017031088345278_b.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Ваш код для отображения элементов сотрудников здесь
                return Container();
              },
              childCount: employeeNames.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Open the search page when the FloatingActionButton is pressed
          final selectedName = await showSearch<String?>(
            context: context,
            delegate: CustomSearchDelegate(employeeNames),
          );

          // Handle the selected name from the search results if needed
          if (selectedName != null) {
            // Handle the selected name
          }
        },
        child: Icon(Icons.search),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String?> {
  final List<String> employeeNames;

  CustomSearchDelegate(this.employeeNames);

  @override
  List<Widget> buildActions(BuildContext context) {
    // Clear the search query
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Close the search page
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show the search results based on the query
    final results = employeeNames.where((name) => name.contains(query)).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            // Return the selected result when tapped
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions based on the query (this can be left empty if not needed)
    final suggestions = employeeNames.where((name) => name.contains(query)).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            // Return the selected suggestion when tapped
            close(context, suggestions[index]);
          },
        );
      },
    );
  }
}
