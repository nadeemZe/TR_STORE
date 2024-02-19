import 'package:http/http.dart' as http;

class ProductAPI {

  final String _baseUrl='jsonplaceholder.org';
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future fetchProducts() async {

    const String endPoint = '/posts';
    final Uri uri = Uri.https(_baseUrl , endPoint);

    try {
      final http.Response response =await  http.get(
        uri,
        headers: headers,
      );
      return response;

    }on Exception catch(e){
      throw e.toString();
    }

  }

  Future fetchProductDetail({required String id}) async {

    final String endPoint = '/posts/$id';
    final Uri uri = Uri.https(_baseUrl , endPoint);

    try {
      final http.Response response = await http.get(
        uri,
        headers: headers,
      );
      return response;
    }on Exception catch(e){
      throw e.toString();
    }

  }


}