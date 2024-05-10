class User {
  // Constructor de la clase User
  User({
    this.idUser,
    this.name,
    this.email,
    this.level,
    this.createdAt,
    this.updatedAt,
  });

  // Atributos de la clase User
  int? idUser; // Id del usuario
  String? name; // Nombre del usuario
  String? email; // Correo electrónico del usuario
  String? level; // Nivel del usuario
  String? createdAt; // Fecha de creación del usuario
  String? updatedAt; // Fecha de actualización del usuario

  // Método factory para convertir un mapa (JSON) en una instancia de User
  factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["id_user"] != null
            ? int.parse(json["id_user"].toString())
            : null,
        name: json["name"],
        email: json["email"],
        level: json["level"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  // Método para convertir una instancia de User en un mapa (JSON)
  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "name": name,
        "email": email,
        "level": level,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

