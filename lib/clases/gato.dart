class Gato {
    String? id;
    String? url;
    int? width;
    int? height;

    Gato({
        required this.id,
        required this.url,
        required this.width,
        required this.height,
    });

    factory Gato.fromJson(Map<String, dynamic> json) => Gato(
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = id;
      data['url'] = url;
      data['width'] = width;
      data['height'] = height;
      return data;
    }
}