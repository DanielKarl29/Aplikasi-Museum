import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeView createState() => HomeView();
}

class HomeView extends State<Home> {
  // loading
  bool isLoading = true;
  // link API (NO AUTH!)
  final String apiLink = "http://210.210.131.44:9090/museumid/api.php";
  // store variable
  List storedData = [];
  List loadData = [];

  @override
  initState() {
    super.initState();
    observeData();
  }

  // Ambil data dari API
  Future observeData() async {
    try {
      final response = await http.get(Uri.parse(apiLink));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          loadData = data;
          storedData = data;
        });
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  // pemprosess kolom pencarian
  void searchFunc(String search) async {
    List results = [];

    if (search.isEmpty) {
      results = storedData;
    } else {
      results = storedData
          .where((data) =>
              data["nama_museum"].toLowerCase().contains(search.toLowerCase()) |
              data["alamat_museum"]
                  .toLowerCase()
                  .contains(search.toLowerCase()))
          .toList();
    }
    setState(() {
      loadData = results;
    });
  }

  Widget showList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            autofocus: false,
            onChanged: (value) => searchFunc(value),
            decoration: InputDecoration(
              hintText: 'Nama Museum / Lokasi',
              labelStyle: const TextStyle(fontSize: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffixIcon: const Icon(Icons.search),
              contentPadding: const EdgeInsets.all(15),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: storedData.isNotEmpty
                ? ListView.builder(
                    itemCount: loadData.length,
                    itemBuilder: (context, index) => Card(
                      key: ValueKey(loadData[index]["id_museum"]),
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8),
                          leading: CachedNetworkImage(
                            imageUrl: loadData[index]["img_museum"].toString(),
                            height: 50,
                            width: 50,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          title: Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 4),
                              child: Text(
                                loadData[index]['nama_museum'],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Alamat
                              const Text('Alamat',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        2), //apply padding to all four sides
                                child: Text(loadData[index]["alamat_museum"]
                                    .toString()),
                              )
                            ],
                          ),
                          // pindah route ke detail (detail.dart) apabila list di klik
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Detail(loadData, index)));
                          },
                        ),
                      ),
                    ),
                  )
                : const Text(
                    'Data Tidak Ditemukan',
                    style: TextStyle(fontSize: 15),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Museum Indonesia'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Museum Indonesia'),
            ),
            body: RefreshIndicator(
                onRefresh: observeData, child: showList(context)));
  }
}
