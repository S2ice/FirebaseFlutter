class TodoEntity {
  final String id;
  final String name;
  final String description; 
  final double price;
  final String category;
  bool isCheck;

  TodoEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.isCheck = false,
  });
}
