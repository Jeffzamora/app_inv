class Product {
  // Constructor de la clase Product
  Product({
    this.code,
    this.name,
    this.stock,
    this.unit,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.exp,
  });

  // Atributos de la clase Product
  String? code; // Código del producto
  String? name; // Nombre del producto
  int? stock; // Stock del producto
  String? unit; // Unidad del producto
  String? price; // Precio del producto
  String? createdAt; // Fecha de creación del producto
  String? updatedAt; // Fecha de actualización del producto
  String? exp; // Fecha de caducidad del producto

  // Método factory para convertir un mapa (JSON) en una instancia de Product
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        code: json["code"],
        name: json["name"],
        stock: json["stock"] != null ? int.parse(json["stock"].toString()) : null,
        unit: json["unit"],
        price: json["price"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        exp: json["exp"],
      );

  // Método para convertir una instancia de Product en un mapa (JSON)
  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "stock": stock,
        "unit": unit,
        "price": price,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "exp": exp,
      };
}

