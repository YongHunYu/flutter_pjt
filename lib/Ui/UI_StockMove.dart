import 'package:barcode_scan/platform_wrapper.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Global/G_Control.dart';
import 'package:untitled/Model/StockMove/MD_MoveFrom.dart';
import 'package:untitled/Model/StockMove/MD_MoveTo.dart';
import 'package:untitled/Provider/PRVD_StockMove.dart';
import 'package:untitled/Ui/Drawer.dart';
import 'package:untitled/Ui/Appbar.dart';

/// 재고이동 화면
class StockMovePage extends StatefulWidget {
  StockMovePage({Key key}) : super(key: key);
  static const routeName = '/stkmove';

  @override
  _StockMovePageState createState() => _StockMovePageState();

}

class _StockMovePageState extends State<StockMovePage> {

  List<FromData> LS_selFrData;
  List<ToData> LS_selToData;

  TextEditingController TEC_search = TextEditingController();
  TextEditingController TEC_toLoc = TextEditingController();

  @override
  void initState() {
    LS_selFrData = [];
    LS_selToData = [];
    super.initState();
  }

  @override
  void dispose() {
    TEC_search.dispose();
    TEC_toLoc.dispose();
    super.dispose();
  }

  // DataTable에서 From Data 선택
  _selectedFrData(bool selected, FromData data) async {
    setState(() {
      if(selected){
        LS_selFrData.add(data);
      }
      else{
        LS_selFrData.remove(data);
      }
    });
  }

  // DataTable에서 To Data 선택
  _selectedToData(bool selected, ToData toData) async {
    setState(() {
      if(selected){
        LS_selToData.add(toData);
      }
      else{
        LS_selToData.remove(toData);
      }
    });
  }

  // 재고이동 Check Dialog
  _ChkResult(BuildContext context, Prvd_StockMove provider) async {
    if(LS_selFrData.length == 0){
      showDialogOk(context, '출발 CELL을 선택하지 않았습니다!', '재고이동');
      return;
    }
    if(LS_selToData.length == 0){
      showDialogOk(context, '도착 CELL을 선택하지 않았습니다!', '재고이동');
      return;
    }
    // if(selectedFrData.first.pCELL_NO == null || selectedFrData.first.pCELL_NO == ''){
    //   showDialogOk(context, '출발 CELL을 선택하지 않았습니다!', "재고이동");
    //   return;
    // }
    // if(selectedToData.first.pCELL_NO == null || selectedToData.first.pCELL_NO == ''){
    //   showDialogOk(context, '도착 CELL을 선택하지 않았습니다!', "재고이동");
    //   return;
    // }

    bool B_result = await asyncConfirmDialog(context
        ,"출발 CELL : " + LS_selFrData.first.pCELL_NO + "\n " +
            "도착 CELL : " + LS_selToData.first.pCELL_NO +"\n " +
            "재고이동 하시겠습니까?"
        ,"재고이동");

    if (B_result == true)
    {
      int I_result = await provider.sendMoveData(context, LS_selFrData.first.pCELL_NO, LS_selToData.first.pCELL_NO);

      if(I_result == 0){
        showDialogOk(context, "재고이동하지 못하였습니다.", "재고이동");
        return;
      }
      else{
        showDialogOk(context
            ,"출발 CELL : " + provider.saveDataInfo.LS_saveData[0].pFR_CELL_NO + "\n " +
                "도착 CELL : " + provider.saveDataInfo.LS_saveData[0].pTO_CELL_NO +"\n " +
                "재고이동 하였습니다."
            ,"재고이동");
        return;
      }
    }
    else{
      showDialogOk(context ,"재고이동을 취소하였습니다.", "재고이동");
      return;
    }
  }

  _getBarCodeData(BuildContext context) async {
    String STR_BarCode = (await BarcodeScanner.scan()) as String;

    TEC_search.text = "";
    TEC_search.text = STR_BarCode;
  }

  _getFromData(BuildContext context, Prvd_StockMove provider) async {
    LS_selFrData = []; // 초기화
    int I_result = await provider.getFromData(context, TEC_search.text, '1');

    if (I_result == 0) {
      showDialogOk(context, "검색된 데이터 없음.", "Info");
      return;
    }
  }

  _getToData(BuildContext context, Prvd_StockMove provider) async {
    LS_selToData = []; // 초기화
    int I_result = await provider.getToData(context, TEC_toLoc.text, '1');

    if (I_result == 0) {
      showDialogOk(context, "검색된 데이터 없음.", "Info");
      return;
    }
  }

  Widget _buildBody() {
    return WillPopScope(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ChangeNotifierProvider<Prvd_StockMove>(
            create: (context) => Prvd_StockMove(),
            child: Consumer<Prvd_StockMove>(
              builder: (context, provider, child) {
                if (provider.fromDataInfo == null) {
                  provider.getFromData(context, TEC_search.text, '1');
                  return Center(child: CircularProgressIndicator());
                }

                if(provider.toDataInfo == null){
                  provider.getToData(context, TEC_toLoc.text, '1');
                  return Center(child: CircularProgressIndicator());
                }
                return Center(
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.all(5),
                        child: new Column(
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  flex: 4,
                                  child: new Container(
                                    height: 50,
                                    child: new TextField(
                                      cursorHeight: 25,
                                      style: TextStyle(fontSize: 20, color: Colors.black),
                                      controller: TEC_search,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Cell No OR BarCode 입력',
                                      ),
                                    ),
                                  ),
                                ),
                                new SizedBox(width: 5,),
                                new Flexible(
                                    flex: 1,
                                    child: new Container(
                                        height: 50,
                                        child: new ButtonTheme(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: new ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.blue
                                              ),
                                              child: Icon(
                                                Icons.search_rounded,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                _getFromData(context, provider);
                                              }
                                          ),
                                        )
                                    )
                                ),
                                new SizedBox(width: 5,),
                                new Flexible(
                                    flex: 1,
                                    child: new Container(
                                        height: 50,
                                        child: new ButtonTheme(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: new ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.blue
                                              ),
                                              child: Icon(
                                                Icons.camera_alt_outlined,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                _getBarCodeData(context);
                                              }
                                          ),
                                        )
                                    )
                                ),
                              ],
                            ),
                            new SizedBox(height: 5),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                    child: new Container(
                                      height: 200,
                                      child: new SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          headingRowColor: MaterialStateColor.resolveWith(
                                                  (states) => Colors.lightBlueAccent),
                                          dividerThickness: 3,
                                          showBottomBorder: true,
                                          columnSpacing: 40,
                                          columns: [
                                            DataColumn(
                                              label: Text('FROM CELL'),
                                            ),
                                            DataColumn(
                                              label: Text('CELL 단수'),
                                            ),
                                            DataColumn(
                                              label: Text('상품코드'),
                                            ),
                                            DataColumn(
                                              label: Text('LOT NO'),
                                            ),
                                            DataColumn(
                                              label: Text('수량'),
                                            ),
                                          ],
                                          rows: provider.fromDataInfo.LS_fromData.map((data) =>
                                              DataRow(
                                                  selected: LS_selFrData.contains(data),
                                                  onSelectChanged: (b){
                                                    _selectedFrData(b, data);
                                                  },
                                                  cells: [
                                                    DataCell(Text(data.pCELL_NO)),
                                                    DataCell(Text(data.pCELL_SEQ)),
                                                    DataCell(Text(data.pITEM_CD)),
                                                    DataCell(Text(data.pLOT_NO)),
                                                    DataCell(Text(data.pITEM_QTY)),
                                                  ]
                                              )
                                          ).toList(),
                                        ),
                                      ),
                                    )
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      new DottedLine(dashColor: Colors.blue,),
                      new Container(
                        margin: EdgeInsets.all(5),
                        child: new Column(
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  flex: 5,
                                  child: new Container(
                                    height: 50,
                                    child: new TextField(
                                      cursorHeight: 25,
                                      style: TextStyle(fontSize: 20, color: Colors.black),
                                      controller: TEC_toLoc,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Cell No OR BarCode 입력',
                                      ),
                                    ),
                                  ),
                                ),
                                new SizedBox(width: 5,),
                                new Flexible(
                                    flex: 1,
                                    child: new Container(
                                        height: 50,
                                        child: new ButtonTheme(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: new ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.blue
                                              ),
                                              child: Icon(
                                                Icons.search_rounded,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                _getToData(context, provider);
                                              }
                                          ),
                                        )
                                    )
                                ),
                              ],
                            ),
                            new SizedBox(height: 5,),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                    child: new Container(
                                      height: 200,
                                      child: new SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: new DataTable(
                                          headingRowColor: MaterialStateColor.resolveWith(
                                                  (states) => Colors.lightBlueAccent),
                                          dividerThickness: 3,
                                          showBottomBorder: true,
                                          // columnSpacing: 50,
                                          columns: [
                                            DataColumn(
                                              label: Text('TO CELL'),
                                            ),
                                            DataColumn(
                                              label: Text('CELL 단수'),
                                            ),
                                            DataColumn(
                                              label: Text('CELL 제한구분'),
                                            ),
                                          ],
                                          rows: provider.toDataInfo.LS_toData.map((data) =>
                                              DataRow(
                                                  selected: LS_selToData.contains(data),
                                                  onSelectChanged: (b){
                                                    _selectedToData(b, data);
                                                  },
                                                  cells: [
                                                    DataCell(Text(data.pCELL_NO)),
                                                    DataCell(Text(data.pCELL_SEQ)),
                                                    DataCell(Text(data.pCELL_LMT_CD)),
                                                  ]
                                              )
                                          ).toList(),
                                        ),
                                      ),
                                    )
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      new DottedLine(dashColor: Colors.blue,),
                      new Container(
                          margin: EdgeInsets.all(5),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new ButtonTheme(
                                      height: 50,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: new ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.blue
                                        ),
                                        child: Text('재고이동'),
                                        onPressed: (){
                                          _ChkResult(context, provider);
                                        },
                                      )
                                  )
                                ],
                              )
                            ],
                          )
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        onWillPop: () {
          // Navigator.pop(context);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(STR_appTitle: '재고이동',),
      drawer: Sub_MenuPage(),
      body: _buildBody(),
    );
  }
}