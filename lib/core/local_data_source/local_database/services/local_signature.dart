// // import 'package:app/core/local_database/local_database.dart';
// // import 'package:app/models/local_data.dart';
// // import 'package:app/print/print_setting_controller.dart';
// // import 'package:app/shared/imports.dart';
// import 'package:flutter/material.dart';
// import 'package:sembast/sembast.dart';
// import 'package:signature/signature.dart';
// import 'package:gym_app_plus/core/local_data_source/local_database.dart';
// import 'package:gym_app_plus/models/local_data.dart';
// import 'package:gym_app_plus/print/print_setting_controller.dart';
// import 'package:gym_app_plus/services/di/injection.dart';
// import 'package:gym_app_plus/shared/logger.dart';

// //save representative signature to local database
// // and return  on open app
// class LocalSignatureServices extends ChangeNotifier {
//   SignatureController signatureController =
//       SignatureController(penStrokeWidth: 2);
//   SignatureController signatureControllerAfterResize =
//       SignatureController(penStrokeWidth: 2);
//   onDrawEnd() {
//     List<Point> points = [];
//     points = extractPoints([...signatureController.points]);
//     logger("points ${points.length}");
//     signatureControllerAfterResize =
//         SignatureController(points: points, penStrokeWidth: 2);
//   }

//   static const String _astDateKey = "LocalSignature";
//   final store = stringMapStoreFactory.store(_astDateKey);
//   LocalSignatureServices() {
//     logger("LocalSignatureServices");
//     signatureController = SignatureController(penStrokeWidth: 2);
//     getAll();
//   }

//   rejects() {
//     signatureController =
//         SignatureController(penStrokeWidth: 2, points: pointss);
//   }

//   List<LocalTargetsAndSelles> list = [];
//   Future save() async {
//     try {
//       onDrawEnd();
//       List<Point> points = signatureController.points;
//       logger("points ${points.length}");
//       //AppDataBase.instance.database
//       await store.delete(await getItClient<AppDataBase>().database);
//       for (var element in points) {
//         //AppDataBase.instance.database
//         store.add(
//             await getItClient<AppDataBase>().database,
//             PointX(
//                     offset: OffsetX(
//                       dx: element.offset.dx,
//                       dy: element.offset.dy,
//                     ),
//                     pressure: element.pressure,
//                     type: element.type)
//                 .toJson());
//       }
//     } catch (e) {
//       logger("error in put $_astDateKey $e");
//     }
//     notifyListeners();
//   }

//   List<Point> pointss = [];
//   Future getAll() async {
//     pointss = [];
//     try {
//       //AppDataBase.instance.database
//       final res = await store.find(await getItClient<AppDataBase>().database);
//       List<PointX> points =
//           res.map<PointX>((e) => PointX.fromJson(e.value)).toList();
//       logger(list);
//       for (var element in points) {
//         pointss.add(Point(
//             Offset(
//               element.offset.dx,
//               element.offset.dy,
//             ),
//             element.type,
//             element.pressure));
//       }
//       signatureController =
//           SignatureController(points: pointss, penStrokeWidth: 2);
//       onDrawEnd();
//     } catch (e) {
//       logger("error in get all $_astDateKey $e");
//     }
//     notifyListeners();
//   }
// }

// class PointX {
//   OffsetX offset;
//   double pressure;
//   PointType type;
//   PointX({required this.offset, required this.pressure, required this.type});
//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'offset': offset.toJson(),
//       'pressure': pressure,
//       'type': type.index
//     };
//   }

//   factory PointX.fromJson(Map<String, dynamic> map) {
//     return PointX(
//       offset: OffsetX.fromJson(map['offset'] as Map<String, dynamic>),
//       pressure: map['pressure'] as double,
//       type: PointType.values[map['type']],
//     );
//   }
// }

// class OffsetX {
//   final double dx;
//   final double dy;
//   OffsetX({required this.dx, required this.dy});
//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{'dx': dx, 'dy': dy};
//   }

//   factory OffsetX.fromJson(Map<String, dynamic> map) {
//     return OffsetX(dx: map['dx'] as double, dy: map['dy'] as double);
//   }
// }
