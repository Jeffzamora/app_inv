class History {
  // Constructor de la clase History
  History({
    this.idHistory,
    this.listProduct,
    this.totalPrice,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  // Atributos de la clase History
  int? idHistory; // Id del historial
  String? listProduct; // Lista de productos
  String? totalPrice; // Precio total
  String? type; // Tipo de historial
  String? createdAt; // Fecha de creación
  String? updatedAt; // Fecha de actualización

  // Método factory para convertir un mapa (JSON) en una instancia de History
  factory History.fromJson(Map<String, dynamic> json) => History(
        idHistory: json["id_history"] != null
            ? int.parse(json["id_history"].toString())
            : null,
        listProduct: json["list_product"],
        totalPrice: json["total_price"],
        type: json["type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  // Método para convertir una instancia de History en un mapa (JSON)
  Map<String, dynamic> toJson() => {
        "id_history": idHistory, // Se corrigió el nombre de la clave
        "list_product": listProduct,
        "total_price": totalPrice,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

