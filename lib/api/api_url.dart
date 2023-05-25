class ApiUrl {
  static const baseUrl = 'http://192.168.20.107:3000/api/v1/';

  static const apiGetPublicKey = '${baseUrl}public-key';

  // user api
  // todo: api: login, register,
  static const apiLogin = '${baseUrl}auth/login';
  static const apiRegister = '${baseUrl}auth/register';

  // product api
  // todo: get product poppular, get all product, get productbyID, add product to cart, search product by name
  static const apiGetAllProduct = '${baseUrl}product?page=1&pageSize=20';
  static const apiGetProductById = '${baseUrl}product/';
  static const apiGetProductByName =
      '${baseUrl}product/search?page=1&pageSize=6&name=';

  // todo: api: get table category, seaarch product by category,
  static const apiGetAllCategory = '${baseUrl}categories';
  static const apiGetProductbyCategory =
      '${baseUrl}product/category/';
  static const apiPostAddtoCart = '${baseUrl}carts';

// quý
  // todo: order: get all order by userId, create order
  // todo : user: get user by userId, change info user
  // todo: order-detail: get orderdetail by orderId
  // todo: address: get address by userId, change address
}
