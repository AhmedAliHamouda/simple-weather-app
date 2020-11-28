import 'package:http/http.dart' as http;
import 'dart:convert';


class NetworkService{
  NetworkService(this.url);

 final String url;

 Future getDataWeather() async{

   http.Response httpResponse = await http.get(url);
   if (httpResponse.statusCode == 200) {
     String weatherData = httpResponse.body;
     return jsonDecode(weatherData);
   } else {
     print(httpResponse.statusCode);
   }
 }

}