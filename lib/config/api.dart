class Api {
  // URL base de la API
  static const _baseUrl = 'https://devzamora.com/api-inventory';

  // Constantes para endpoints específicos de la API
  static const user = '$_baseUrl/user';        // Endpoint para operaciones relacionadas con usuarios
  static const product = '$_baseUrl/product';  // Endpoint para operaciones relacionadas con productos
  static const history = '$_baseUrl/history';  // Endpoint para operaciones relacionadas con historiales
  static const inout = '$_baseUrl/inout';      // Endpoint para operaciones relacionadas con entradas/salidas de inventario

  // Constantes para operaciones CRUD (Crear, Leer, Actualizar, Eliminar) en la API
  static const add = 'add.php';      // Endpoint para agregar datos a la API
  static const update = 'update.php'; // Endpoint para actualizar datos en la API
  static const delete = 'delete.php'; // Endpoint para eliminar datos en la API
  static const gets = 'get.php';      // Endpoint para obtener datos de la API
  static const search = 'search.php'; // Endpoint para buscar datos en la API
  static const count = 'count.php';   // Endpoint para contar datos en la API
}

