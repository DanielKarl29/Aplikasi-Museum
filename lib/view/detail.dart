import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Detail extends StatefulWidget {
  final int index;
  final List data;

  const Detail(this.data, this.index, {Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  List selectData = [];
  int selectIndex = 0;
  late Map splitJadwal;
  late Map splitLoc;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectData = widget.data;
      selectIndex = widget.index;
      splitJadwal = splitList(false);
      splitLoc = splitList(true);
    });
  }

  // fungsi pemisahan koma dari list, sama seperti explode
  splitList(bool isLoc) {
    final split = isLoc
        ? selectData[selectIndex]["lokasi_museum"].split(',')
        : selectData[selectIndex]["jadwal_museum"].split(',');

    final Map<int, String> values = {
      for (int i = 0; i < split.length; i++) i: split[i]
    };
    return values;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Museum"),
      ),
      body: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListView(children: <Widget>[
            const Padding(padding: EdgeInsets.all(8.0)),
            // Gambar dan Nama
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: selectData[selectIndex]["img_museum"].toString(),
                  height: 250,
                  width: 250,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(2, 8, 2, 12),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(8.0), //add it here
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 4),
                        child: Text(
                          textAlign: TextAlign.center,
                          selectData[selectIndex]["nama_museum"].toString(),
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ))),
              ],
            ),
            // Alamat Museum
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "Alamat",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: Text(
                      textAlign: TextAlign.center,
                      selectData[selectIndex]["alamat_museum"].toString(),
                      style: const TextStyle(fontSize: 16),
                    ))
              ],
            ),
            const Divider(height: 1),
            // Wilayah dan Jenis
            Row(
              children: const [
                Expanded(
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 4),
                            child: Text('Wilayah',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))))),
                Expanded(
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(2),
                            child: Text('Jenis',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))))),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: 2, bottom: 8),
                            child: Text(
                                textAlign: TextAlign.center,
                                selectData[selectIndex]["wilayah_museum"]
                                    .toString(),
                                style: const TextStyle(fontSize: 16))))),
                Expanded(
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: 2, bottom: 8),
                            child: Text(
                                textAlign: TextAlign.center,
                                selectData[selectIndex]["jenis_museum"]
                                    .toString(),
                                style: const TextStyle(fontSize: 16))))),
              ],
            ),
            const Divider(height: 1),
            // tipe
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 4),
                    child: Text(
                      "Tipe",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 8),
                    child: Text(
                      textAlign: TextAlign.center,
                      selectData[selectIndex]["tipe_museum"].toString(),
                      style: const TextStyle(fontSize: 16),
                    ))
              ],
            ),
            const Divider(height: 1),
            Row(
              children: const [
                Expanded(
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 4),
                            child: Text('Pemilik',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))))),
                Expanded(
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 4),
                            child: Text('Pengelola',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))))),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Center(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(2, 2, 2, 8),
                      child: Text(
                          textAlign: TextAlign.center,
                          selectData[selectIndex]["pemilik_museum"].toString(),
                          style: const TextStyle(fontSize: 16))),
                )),
                Expanded(
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 8),
                            child: Text(
                                textAlign: TextAlign.center,
                                selectData[selectIndex]["pengelola_museum"]
                                    .toString(),
                                style: const TextStyle(fontSize: 16))))),
              ],
            ),
            const Divider(height: 1),
            // Sejarah
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "Sejarah",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 4, left: 20, right: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      selectData[selectIndex]["sejarah_museum"].toString(),
                      style: const TextStyle(fontSize: 16),
                    ))
              ],
            ),
            const Divider(height: 1),
            // Jadwal
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      "Jadwal",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 10),
              shrinkWrap: true,
              itemCount: splitJadwal.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 5);
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[Text(splitJadwal[index])],
                );
              },
            ),
            const Divider(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "Lokasi",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 350,
                  alignment: Alignment.centerLeft,
                  child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(double.parse(splitLoc[0]),
                            double.parse(splitLoc[1])),
                        zoom: 17,
                      ),
                      nonRotatedChildren: const [
                        RichAttributionWidget(
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                            ),
                          ],
                        ),
                      ],
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(markers: [
                          Marker(
                            width: 35,
                            height: 45,
                            point: LatLng(double.parse(splitLoc[0]),
                                double.parse(splitLoc[1])),
                            builder: (ctx) => const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 30.0,
                            ),
                          ),
                        ])
                      ]),
                )
              ],
            )
          ])),
    );
  }
}
