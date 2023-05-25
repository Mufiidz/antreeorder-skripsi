import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/seat.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:flutter/material.dart';

class SeatsSection extends StatefulWidget {
  final List<Seat> seats;
  final void Function(Seat seat) onClick;
  const SeatsSection({Key? key, required this.seats, required this.onClick})
      : super(key: key);

  @override
  State<SeatsSection> createState() => _SeatsSectionState();
}

class _SeatsSectionState extends State<SeatsSection> {
  late Seat _selectedSeat;
  @override
  void initState() {
    _selectedSeat = widget.seats.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AntreeText("Makan dimana?",
                style: AntreeTextStyle.medium.bold, fontSize: 18),
            AntreeSpacer(),
            Expanded(
                child: AntreeList(
              widget.seats,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, item, index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: item.id == _selectedSeat.id
                            ? Colors.black
                            : Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    onTap: () {
                      setState(() {
                        _selectedSeat = item;
                      });
                      widget.onClick(item);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AntreeText(
                            item.title,
                            style: AntreeTextStyle.bold,
                          ),
                          item.capacity > 0
                              ? AntreeText(
                                  'Kapasitas untuk ${item.capacity} orang.',
                                  textColor: Colors.black45,
                                  fontSize: 10,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
