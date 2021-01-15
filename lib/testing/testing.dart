import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('This is title.'),
                      // cancelButton: CupertinoActionSheetAction(
                      //   onPressed: () {},
                      //   child: Text('hi there'),
                      // ),
                      actions: [
                        TextButton(
                          onPressed: () {},
                          child: Text('First'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Second'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('First'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Second'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('First'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Second'),
                        ),
                      ],
                    );
                  });
            },
            child: Container(
              margin: EdgeInsets.all(8.0),
              height: (MediaQuery.of(context).size.width / 4) * 3,
              width: (MediaQuery.of(context).size.width / 4) * 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all()),
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://media.tenor.com/images/7ab4487f6903700c439db0aea7a05758/tenor.gif'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120.0,
              width: double.infinity,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      color: CupertinoColors.activeGreen,
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            color: CupertinoColors.activeBlue,
                          ),
                        );
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
