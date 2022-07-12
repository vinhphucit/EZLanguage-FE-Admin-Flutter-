class PagingList<T> {
  PagingList({
    this.items,
    this.start,
    this.limit,
    this.totalItems,
    this.query,
  });

  List<T>? items;
  int? start;
  int? limit;
  int? totalItems;
  String? query;

  factory PagingList.fromJson(Map<String, dynamic> json) => PagingList(
        items:
            List<T>.from(json["items"].map((x) => (T as dynamic).fromJson(x))),
        start: json["start"],
        limit: json["limit"],
        totalItems: json["totalItems"],
        query: json["query"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => (x as dynamic).toJson())),
        "start": start,
        "limit": limit,
        "totalItems": totalItems,
        "query": query,
      };
}
