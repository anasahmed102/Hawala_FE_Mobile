import 'dart:convert';

import 'package:hawala/shared/enums.dart';
import 'package:hawala/shared/logger.dart';




class ResRemote<T> {
  String body;
  ParseBody parseBody;
  T Function(Map<String, dynamic> json) fromJsonModel;
  ResRemote(
      {required this.body,
      required this.fromJsonModel,
      required this.parseBody});
}

List<T> parseBodyList<T>(ResRemote<T> responseBody,
    {required Function(dynamic e) onError}) {
  try {
    logger(
        "responseBodyresponseBody ${responseBody.runtimeType} ${responseBody.parseBody} ${responseBody.body}");
    final body = jsonDecode(responseBody.body);
    if (responseBody.parseBody == ParseBody.direct) {
      return List<T>.from(
          body.map((itemsJson) => responseBody.fromJsonModel(itemsJson)));
    } else if (responseBody.parseBody == ParseBody.row) {
      return List<T>.from(body['rows']
          .map((itemsJson) => responseBody.fromJsonModel(itemsJson)));
    } else if (responseBody.parseBody == ParseBody.towLevelList) {
      return List<T>.from(
          body[0].map((itemsJson) => responseBody.fromJsonModel(itemsJson)));
    }
    return <T>[];
  } catch (e, c) {
    onError(e);
    // recordError(e, c);
    logger("parseBody $e");
    return <T>[];
  }
}

T? parseBodyOne<T>(ResRemote<T> responseBody,
    {required Function(dynamic e) onError}) {
  try {
    final body = jsonDecode(responseBody.body);
    logger("responseBody.parseBody ${responseBody.parseBody}");
    if (responseBody.parseBody == ParseBody.direct) {
      return responseBody.fromJsonModel(body);
    } else if (responseBody.parseBody == ParseBody.row) {
      return responseBody.fromJsonModel(body['rows']);
    } else if (responseBody.parseBody == ParseBody.towLevelList) {
      return responseBody.fromJsonModel(body[0][0]);
    } else if (responseBody.parseBody == ParseBody.none) {
      return null;
    }
    //responseBody.fromJsonModel(body)
    return null;
  } catch (e, c) {
    onError(e);
    // recordError(e, c);
    logger("parseBodyOne $e");
    return null;
  }
}
