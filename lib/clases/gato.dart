// Esta clase representa un gato, con sus datos principales.
// Se usa para guardar la información que llega desde la API.

class Gato {
    // Identificador del gato (puede ser nulo)
    String? id;
    // URL de la imagen del gato (puede ser nulo)
    String? url;
    // Ancho de la imagen (puede ser nulo)
    int? width;
    // Alto de la imagen (puede ser nulo)
    int? height;

    // Constructor de la clase Gato
    Gato({
        required this.id,
        required this.url,
        required this.width,
        required this.height,
    });

    // Este método crea un objeto Gato a partir de un mapa (json).
    // Es útil para convertir los datos que vienen de internet a un objeto de Dart.
    factory Gato.fromJson(Map<String, dynamic> json) => Gato(
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
    );

    // Este método convierte el objeto Gato a un mapa (json).
    // Es útil si quieres enviar los datos a internet o guardarlos.
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = id;
      data['url'] = url;
      data['width'] = width;
      data['height'] = height;
      return data;
    }
}