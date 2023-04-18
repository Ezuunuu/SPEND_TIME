class CategoryModel {
  CategoryModel({required this.id, this.title, this.sort});
  final int id;
  final String? title;
  final int? sort;

  CategoryModel copyWith({String? title, int? sort}) {
    return CategoryModel(
        id: id,
        title: title ?? this.title,
        sort: sort ?? this.sort
    );
  }
}