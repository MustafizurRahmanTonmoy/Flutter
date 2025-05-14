import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassNumTEConroller =
      TextEditingController(text: '1');

  List<WaterTrack> WaterTrackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Water Tracker')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWaterTrackerCounter(),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: _buildWaterTrackListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterTrackListView() {
    return ListView.separated(
        itemCount: WaterTrackList.length,
        itemBuilder: (context, index) {
          final WaterTrack waterTrack = WaterTrackList[index];
          return ListTile(
            title:  Text('${waterTrack.dateTime.hour}:${waterTrack.dateTime.minute}'),
            subtitle: Text('${waterTrack.dateTime.day}/${waterTrack.dateTime.month}/${waterTrack.dateTime.year}'),
            leading: CircleAvatar(child: Text('${waterTrack.noOfGlass}')),
            trailing: IconButton(
              onPressed: () => _onTapDelete(index),
              icon: Icon(Icons.delete),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        );
  }

  Widget _buildWaterTrackerCounter() {
    return Column(
      children: [
        Text(
          getTotalGlassCount().toString(),
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        const Text(
          'Glass/s',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 50,
                child: TextField(
                  controller: _glassNumTEConroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8)),
                )),
            TextButton(
              onPressed: _onTapAddWaterTrack,
              child: const Text('Add'),
            ),
          ],
        ),
      ],
    );
  }

  int getTotalGlassCount() {
    int counter = 0;
    for (WaterTrack t in WaterTrackList) {
      counter += t.noOfGlass;
    }
    return counter;
  }

  void _onTapAddWaterTrack() {
    if (_glassNumTEConroller.text.isEmpty) {
      _glassNumTEConroller.text = '1';
    }
    final int noOfglass = int.tryParse(_glassNumTEConroller.text) ?? 1;
    WaterTrack waterTrack =
        WaterTrack(noOfGlass: noOfglass, dateTime: DateTime.now());
    WaterTrackList.add(waterTrack);
    setState(() {});
  }
  
  void _onTapDelete(int index){
    WaterTrackList.removeAt(index);
    setState(() {});
  }
}

class WaterTrack {
  final int noOfGlass;
  final DateTime dateTime;

  WaterTrack({required this.noOfGlass, required this.dateTime});
}
