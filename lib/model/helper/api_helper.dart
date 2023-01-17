import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../core/shared/response_content.dart';
import '../core/shared/status_and_types.dart';

class ApiHelper {
  String url = '/api/';
  String link = 'https://api.e-maknoon.org';
  String link2 = 'https://e-maknoon.org';

  Future<bool> testConected() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // ignore: avoid_print
        print('connected');
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      // ignore: avoid_print
      print('not connected');
      return false;
    }
  }


  Future<ResponseContent> getV1<T>(String endPoint,
      {String linkCon = '', String header = ''}) async {
    final client = http.Client();
    try {
      Uri uri = Uri.parse(link + url + endPoint);
      final response = await client.get(uri, headers: {'Language': header});
      if (response.statusCode >= 200 && response.statusCode < 299) {
        try {
          var data = convert.jsonDecode(response.body);
          ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
          return result;
        } catch (e) {
          return ResponseContent(
              statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
        }
      } else if (response.statusCode >= 400 && response.statusCode < 499) {
        var data = convert.jsonDecode(response.body);
        ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
        return result;
      } else {
        return ResponseContent(
            statusCode: '-${response.statusCode.toString()}',
            message: response.body);
      }
    } catch (e) {
      return ResponseContent(
          statusCode: '0', message: 'error_connect_to_netwotk'.tr);
    }
  }
  Future<ResponseContent> getV2<T>(String endPoint,
      {String? linkApi ,String linkCon = '', String header = ''}) async {
    final client = http.Client();
    try {
      Uri uri = Uri.parse(linkApi!=null ? '$linkApi/$endPoint' : (link + url + endPoint));
      final response = await client.get(uri, headers: {'Language': header});
      if (response.statusCode >= 200 && response.statusCode < 299) {
        try {
          var data = convert.jsonDecode(response.body);
          ResponseContent result = ResponseContent.fromJsonList(data,response.statusCode);
          return result;
        } catch (e) {
          return ResponseContent(
              statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
        }
      } else if (response.statusCode >= 400 && response.statusCode < 499) {
        var data = convert.jsonDecode(response.body);
        ResponseContent result = ResponseContent.fromJsonList(data,response.statusCode);
        return result;
      } else {
        return ResponseContent(
            statusCode: '-${response.statusCode.toString()}',
            message: response.body);
      }
    } catch (e) {
      return ResponseContent(
          statusCode: '0', message: 'error_connect_to_netwotk'.tr);
    }
  }

  Future<ResponseContent> postV1<T>(String endPoint, T value,
      {String? linkApi ,String? contentType, bool withToken = false,Map<String,String>? headers}) async {
    final client = http.Client();
    try {
      Uri uri = Uri.parse((linkApi??link) + url + endPoint);
      final response = await client.post(uri, body: value, headers: {
        "Accept": "application/json",
        "Content-Type": contentType ?? ContentTypeHeaders.formUrlEncoded,
        // 'Access-Token':
        //     withToken ? Get.find<UserController>().userLogin?.token ?? '' : '',
        ...?headers    
      });

      if (response.statusCode >= 200 && response.statusCode < 299) {
        try {
          var data = convert.jsonDecode(response.body);
          ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
          return result;
        } catch (e) {
          return ResponseContent(
              statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
        }
      } else if (response.statusCode >= 400 && response.statusCode < 499) {
        var data = convert.jsonDecode(response.body);
        ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
        return result;
      } else {
        return ResponseContent(
            statusCode: '-${response.statusCode.toString()}',
            message: response.body);
      }
    } catch (e) {
      return ResponseContent(
          statusCode: '0', message: 'error_connect_to_netwotk'.tr);
    }
  }

  Future<ResponseContent> postV2<T>(String endPoint, T value,
      {String? linkApi ,String? contentType, bool withToken = false,Map<String,String>? headers}) async {
    final client = http.Client();
    try {
      Uri uri = Uri.parse(linkApi!=null ? '$linkApi/$endPoint' : (link + url + endPoint));
      final response = await client.post(uri, body: value, headers: {
        "Accept": "application/json",
        "Content-Type": contentType ?? ContentTypeHeaders.formUrlEncoded,
        // 'Access-Token':
        //     withToken ? Get.find<UserController>().userLogin?.token ?? '' : '',
        ...?headers    
      });

      if (response.statusCode >= 200 && response.statusCode < 299) {
        try {
          var data = convert.jsonDecode(response.body);
          ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
          return result;
        } catch (e) {
          return ResponseContent(
              statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
        }
      } else if (response.statusCode >= 400 && response.statusCode < 499) {
        var data = convert.jsonDecode(response.body);
        ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
        return result;
      } else {
        return ResponseContent(
            statusCode: '-${response.statusCode.toString()}',
            message: response.body);
      }
    } catch (e) { 
      return ResponseContent(
          statusCode: '0', message: 'error_connect_to_netwotk'.tr);
    }
  }

  Future<ResponseContent> postWithImages<T>(String endPoint, String filedImage,
      Map<String, String> body, List<String> filepath,
      {String header = ''}) async {
    try {
      Uri uri = Uri.parse(link + url + endPoint);
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "multipart/form-data",
       // 'Access-Token': Get.find<UserController>().userLogin?.token ?? ''
      };

      // List<http.MultipartFile> newList =filepath.map((e) async => await http.MultipartFile.fromPath(filedImage, e)).cast<http.MultipartFile>().toList();
      List<http.MultipartFile> newList = [];
      for (int i = 0; i < filepath.length; i++) {
        newList.add(await http.MultipartFile.fromPath(filedImage, filepath[i]));
      }
      var request = http.MultipartRequest('POST', uri)
        ..fields.addAll(body)
        ..headers.addAll(headers)
        ..files.addAll(newList);
      //..files.add(await http.MultipartFile.fromPath(filedImage, filepath[0]));
      var responsefromStream = await request.send();
      var response = await http.Response.fromStream(responsefromStream);
      if (responsefromStream.statusCode >= 200 && responsefromStream.statusCode < 299) {
        try {
          var data = convert.jsonDecode(response.body);
          ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
          return result;
        } catch (e) {
          return ResponseContent(
              statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
        }
      } else if (responsefromStream.statusCode >= 400 && responsefromStream.statusCode < 499) {
        var data = convert.jsonDecode(response.body);
        ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
        return result;
      } else {
        return ResponseContent(
            statusCode: responsefromStream.statusCode.toString(),
            message: response.body);
      }
    } catch (e) {
      return ResponseContent(
          statusCode: '0', message: 'error_connect_to_netwotk'.tr);
    }
  }

 
 
  Future<ResponseContent> put<T>(String endPoint, T value,
      {String? contentType, bool withToken = false}) async {
    final client = http.Client();
    try {
      Uri uri = Uri.parse(link + url + endPoint);
      final response = await client.put(uri, body: value, headers: {
        "Accept": "application/json",
        "Content-Type": contentType ?? ContentTypeHeaders.formUrlEncoded,
        // 'Access-Token':
        //     withToken ? Get.find<UserController>().userLogin?.token ?? '' : '',
      });

      if (response.statusCode >= 200 && response.statusCode < 299) {
        try {
          var data = convert.jsonDecode(response.body);
          ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
          result.statusCode = response.statusCode.toString();
          return result;
        } catch (e) {
          return ResponseContent(
              statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
        }
      } else if (response.statusCode >= 400 && response.statusCode < 499) {
        var data = convert.jsonDecode(response.body);
        ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
        return result;
      } else {
        return ResponseContent(
            statusCode: '-${response.statusCode.toString()}',
            message: response.body);
      }
    } catch (e) {
      return ResponseContent(
          statusCode: '0', message: 'error_connect_to_netwotk'.tr);
    }
  }

  Future<ResponseContent> putWithImages<T>(String endPoint, String filedImage,
      Map<String, String> body, List<String> filepath,
      {String header = ''}) async {
    try {
      Uri uri = Uri.parse(link + url + endPoint);
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "multipart/form-data",
       // 'Access-Token': Get.find<UserController>().userLogin?.token ?? ''
      };

      // List<http.MultipartFile> newList =filepath.map((e) async => await http.MultipartFile.fromPath(filedImage, e)).cast<http.MultipartFile>().toList();
      List<http.MultipartFile> newList = [];
      for (int i = 0; i < filepath.length; i++) {
        newList.add(await http.MultipartFile.fromPath(filedImage, filepath[i]));
      }
      var request = http.MultipartRequest('PUT', uri)
        ..fields.addAll(body)
        ..headers.addAll(headers)
        ..files.addAll(newList);
      var responsefromStream = await request.send();
      var response = await http.Response.fromStream(responsefromStream);
      if (responsefromStream.statusCode >= 200 && responsefromStream.statusCode < 299) {
        try {
          var data = convert.jsonDecode(response.body);
          ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
          return result;
        } catch (e) {
          return ResponseContent(
              statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
        }
      }
       else if (responsefromStream.statusCode >= 400 && responsefromStream.statusCode < 499) {
        var data = convert.jsonDecode(response.body);
        ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
        return result;
      } else {
        return ResponseContent(
            statusCode: '-${responsefromStream.statusCode.toString()}',
            message: response.body);
      }
    } catch (e) {
      return ResponseContent(
          statusCode: '0', message: 'error_connect_to_netwotk'.tr);
    }
  }


  Future<String> putPost<T>(String endPoint, {String header = ''}) async {
    final client = http.Client();
    try {
      Uri uri = Uri.parse(link + url + endPoint);
      final response = await client.put(uri, headers: {'Language': header});
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Failed";
      }
    } catch (e) {
      return 'Error';
    }
  }

  Future<ResponseContent> delete<T>(String endPoint) async {
    final client = http.Client();
    try {
      Uri uri = Uri.parse(link + url + endPoint);
      final response = await client.delete(uri, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
       // 'Access-Token': Get.find<UserController>().userLogin?.token ?? ''
      });
      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body);
        ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
        return result;
      } else if (response.statusCode >= 400 && response.statusCode < 499) {
        var data = convert.jsonDecode(response.body);
        ResponseContent result = ResponseContent.fromJson(data,response.statusCode);
        return result;
      } else {
        return ResponseContent(
            statusCode: '-${response.statusCode.toString()}',
            message: response.body);
      }
    } catch (e) {
      return ResponseContent(
          statusCode: '0', message: 'error_connect_to_netwotk'.tr);
    }
  }
}
