import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Global/G_Control.dart';
import 'package:untitled/Model/MD_CellInfo.dart';
import 'package:untitled/Provider/PRVD_CellInfo.dart';
import 'package:untitled/Ui/Drawer.dart';
import 'package:untitled/Ui/Appbar.dart';

/// 셀 정보 화면
class CellInfoPage extends StatefulWidget {
  CellInfoPage({Key key}) : super(key: key);
  static const routeName = '/cellinfo';

  @override
  _CellInfoPageState createState() => _CellInfoPageState();

}

int I_radioValue1 = 0;

class _CellInfoPageState extends State<CellInfoPage> {

  bool B_sort;
  int I_sortIndex;
  List<CellInfo> LS_selData;

  TextEditingController TEC_search = TextEditingController();

  @override
  void initState() {
    B_sort = false;
    I_sortIndex = 0;
    LS_selData = [];
    super.initState();
  }

  @override
  void dispose() {
    TEC_search.dispose();
    super.dispose();
  }

  //컬럼헤더 정렬 함수.
  _onSortcolum(int columnIndex, bool ascending, Prvd_CellInfo provider) {
    if (columnIndex == 0) {
      if (ascending) {
        provider.cellInfo.LS_cellInfo
            .sort((a, b) => a.pAREA.compareTo(b.pAREA));
      } else {
        provider.cellInfo.LS_cellInfo
            .sort((a, b) => b.pAREA.compareTo(a.pAREA));
      }
    } else if (columnIndex == 1) {
      if (ascending) {
        provider.cellInfo.LS_cellInfo
            .sort((a, b) =>
            a.pISSUCASE_ID.compareTo(b.pISSUCASE_ID));
      } else {
        provider.cellInfo.LS_cellInfo
            .sort((a, b) =>
            b.pISSUCASE_ID.compareTo(a.pISSUCASE_ID));
      }
    } else if (columnIndex == 2) {
      if (ascending) {
        provider.cellInfo.LS_cellInfo
            .sort((a, b) => a.pPLT_QTY.compareTo(b.pPLT_QTY));
      } else {
        provider.cellInfo.LS_cellInfo
            .sort((a, b) => b.pPLT_QTY.compareTo(a.pPLT_QTY));
      }
    } else if (columnIndex == 3) {
      if (ascending) {
        provider.cellInfo.LS_cellInfo
            .sort((a, b) => a.pPA_TIME.compareTo(b.pPA_TIME));
      } else {
        provider.cellInfo.LS_cellInfo
            .sort((a, b) => b.pPA_TIME.compareTo(a.pPA_TIME));
      }
    }
  }

  //row 선택 함수
  _onSelectedRow(bool selected, CellInfo data) async {
    setState(() {
      if (selected) {
        LS_selData.add(data);
      } else {
        LS_selData.remove(data);
      }
    });
  }

  _handleRadioValueChange1(int value) {
    setState(() {
      I_radioValue1 = value;
    });
  }

  _getBarCodeData(BuildContext context) async {
    String STR_BarCode = await BarcodeScanner.scan().toString();

    TEC_search.text = "";
    TEC_search.text = STR_BarCode;
  }

  //데이터를 검색 조건에 따라 다시 조회하고 결과가 없을경우 메시지 처리한다.
  _getCellData(BuildContext context, Prvd_CellInfo provider) async {
    int I_result = await provider.getCellData(context, TEC_search.text, I_radioValue1.toString());

    if (I_result == 0) {
      showDialogOk(context, "검색된 데이터 없음.", "Info");
    }
  }

  Widget _buildBody() {
    return WillPopScope(
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ChangeNotifierProvider<Prvd_CellInfo>(
            create: (context) => Prvd_CellInfo(),
            child: Consumer<Prvd_CellInfo>(
              builder: (context, provider, child) {
                if (provider.cellInfo == null) {
                  provider.getCellData(context, TEC_search.text, I_radioValue1.toString());
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: <Widget>[
                    new Container(
                        margin: EdgeInsets.all(10),
                        //컨테이너에 테두리를 친다.
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.shade700),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.all(10),
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.all(0.0),
                              ),
                              // new Text(
                              //   '조회옵션',
                              //   style: new TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     fontSize: 18.0,
                              //   ),
                              // ),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Radio(
                                    value: 0,
                                    groupValue: I_radioValue1,
                                    activeColor: Colors.green,
                                    onChanged: _handleRadioValueChange1,
                                  ),
                                  new Text(
                                    '품목코드',
                                    style: new TextStyle(fontSize: 16.0),
                                  ),
                                  new Radio(
                                    value: 1,
                                    groupValue: I_radioValue1,
                                    activeColor: Colors.green,
                                    onChanged: _handleRadioValueChange1,
                                  ),
                                  new Text(
                                    '저장위치',
                                    style: new TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              new Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        //color: Colors.red,
                                        height: 50,
                                        child: new TextField(
                                          cursorHeight: 25,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black),
                                          autofocus: true,
                                          //focusNode: FocusID,
                                          controller: TEC_search,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: '저장위치 또는 품목코드',
                                          ),
                                        ),
                                      )
                                  ),
                                  Flexible(
                                      fit: FlexFit.loose,
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        child: new RaisedButton(
                                            textColor: Colors.white,
                                            color: Colors.blue,
                                            child: Text('조 회'),
                                            onPressed: () {
                                              _getCellData(context, provider);
                                            }
                                        ),
                                      )
                                  ),
                                  // barcode scan
                                  Flexible(
                                      fit: FlexFit.loose,
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        child: new RaisedButton(
                                          color: Colors.blue,
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            _getBarCodeData(context);
                                          },
                                        ),
                                      )
                                  ),
                                ],
                              )
                            ]
                        )
                    ),
                    Container(
                      padding: EdgeInsets.all(30),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              '재고정보',
                              style: new TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            new Padding(
                              padding: new EdgeInsets.all(1.0),
                            ),
                          ]),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.lightBlueAccent),
                          dividerThickness: 3,
                          showBottomBorder: true,
                          sortAscending: B_sort,
                          sortColumnIndex: I_sortIndex,
                          columnSpacing: 35,
                          columns: [
                            DataColumn(
                                label: Text('저장위치'),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    B_sort = !B_sort;
                                    I_sortIndex = columnIndex;
                                  });
                                  _onSortcolum(columnIndex, ascending, provider);
                                },
                                tooltip: '입고된 저장위치를 의미합니다.'),
                            DataColumn(
                                label: Text('품목코드'),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    B_sort = !B_sort;
                                    I_sortIndex = columnIndex;
                                  });
                                  _onSortcolum(columnIndex, ascending, provider);
                                },
                                tooltip: '입고된 품목코드를 의미합니다.'),
                            DataColumn(
                                label: Text('수량'),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    B_sort = !B_sort;
                                    I_sortIndex = columnIndex;
                                  });
                                  _onSortcolum(columnIndex, ascending, provider);
                                },
                                tooltip: '입고된 수량을 의미합니다.'),
                            DataColumn(
                                label: Text('입고일자'),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    B_sort = !B_sort;
                                    I_sortIndex = columnIndex;
                                  });
                                  _onSortcolum(columnIndex, ascending, provider);
                                },
                                tooltip: '입고되 시간을 의미합니다.'),
                          ],
                          rows: provider.cellInfo.LS_cellInfo.map((data) =>
                          // we return a DataRow every time
                          DataRow(
                              selected: LS_selData.contains(data),
                              onSelectChanged: (b) {
                                _onSelectedRow(b, data);
                              },
                              // List<DataCell> cells is required in every row2
                              cells: [
                                DataCell(Text(data.pAREA)),
                                DataCell(Text(data.pISSUCASE_ID)),
                                DataCell(Text(data.pPLT_QTY)),
                                DataCell(Text(data.pPA_TIME)),
                              ])).toList(),
                        ),
                      ),
                    )
                  ],
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
      appBar: appBar(STR_appTitle: '재고조회',),
      drawer: Sub_MenuPage(),
      body: _buildBody(),
    );
  }
}