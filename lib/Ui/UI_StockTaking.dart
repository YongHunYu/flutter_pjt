import 'package:barcode_scan/platform_wrapper.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Global/G_Control.dart';
import 'package:untitled/Provider/PRVD_StockTaking.dart';
import 'package:untitled/Ui/Drawer.dart';

/// 재고실사 화면
class StockTakingPage extends StatefulWidget {
  StockTakingPage({Key key}) : super(key: key);
  static const routeName = '/stktaking';

  @override
  _StockTakingPageState createState() => _StockTakingPageState();

}

var _selValue = '00';

class _StockTakingPageState extends State<StockTakingPage> {

  // 입력조건 컨트롤러 선언
  TextEditingController TEC_search = TextEditingController();
  TextEditingController TEC_sku = TextEditingController();
  TextEditingController TEC_skuNm = TextEditingController();
  TextEditingController TEC_lotNo = TextEditingController();
  TextEditingController TEC_skuQty = TextEditingController();
  TextEditingController TEC_cellLoc = TextEditingController();
  TextEditingController TEC_reMark = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    TEC_search.dispose();
    TEC_sku.dispose();
    TEC_skuNm.dispose();
    TEC_lotNo.dispose();
    TEC_skuQty.dispose();
    TEC_cellLoc.dispose();
    TEC_reMark.dispose();

    super.dispose();
  }

  _getData(BuildContext context, Prvd_StockTaking provider) async{
    int I_result = await provider.getTakingData(context, TEC_search.text);

    if(I_result == 0){
      TEC_sku.text = '';
      TEC_skuNm.text = '';
      TEC_lotNo.text = '';

      showDialogOk(context, '검색된 데이터가 없습니다.', '재고실사');
      return;
    }
    else{
      TEC_sku.text = provider.takingDataInfo.LS_takingData[0].pITEM_CD;
      TEC_skuNm.text = provider.takingDataInfo.LS_takingData[0].pITEM_NM;
      TEC_lotNo.text = provider.takingDataInfo.LS_takingData[0].pLOT_NO;
    }
  }

  _getBarCode(BuildContext context) async {
    String STR_BarCode = await BarcodeScanner.scan().toString();

    TEC_search.text = "";
    TEC_search.text = STR_BarCode;
  }

  Widget _buildAppBar(BuildContext context, Prvd_StockTaking provider) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            '재고실사',
            style: new TextStyle(fontSize: 16.0),
          )
        ],
      ),
      backgroundColor: Colors.blue,
      centerTitle: true,
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.search_rounded),
          color: Colors.white,
          tooltip: '조회',
          onPressed: () {
            _getData(context, provider);
          },
        ),
        new IconButton(
          icon: new Icon(Icons.camera_alt_outlined),
          color: Colors.white,
          tooltip: '바코드등록',
          onPressed: () {
            _getBarCode(context);
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return WillPopScope(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ChangeNotifierProvider<Prvd_StockTaking>(
            create: (context) => Prvd_StockTaking(),
            child: Consumer<Prvd_StockTaking>(
              builder: (context, provider, child) {
                if (provider.uiInfo == null) {
                  provider.getUiData(context, 'INV_CNT_INFO');
                  return Center(child: CircularProgressIndicator());
                }
                if(provider.takingDataInfo == null){
                  provider.getTakingData(context, TEC_search.text);
                  return Center(child: CircularProgressIndicator());
                }
                return Center(
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      new Container(
                        child: new Column(
                          children: <Widget>[
                            new SizedBox(height: 5,),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 300,
                                  child: new TextField(
                                    cursorHeight: 25,
                                    style: TextStyle(fontSize: 20, color: Colors.black),
                                    // autofocus: true,
                                    controller: TEC_search,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Cell No 입력',
                                      // icon: Icon(Icons.search_rounded,size: 20,)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new SizedBox(height: 5,),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 300,
                                  child: new TextField(
                                    cursorHeight: 25,
                                    style: TextStyle(fontSize: 20, color: Colors.black),
                                    enabled: false,
                                    controller: TEC_sku,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'SKU',
                                      // icon: Icon(Icons.search_rounded,size: 20,)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new SizedBox(height: 5,),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 300,
                                  child: new TextField(
                                    cursorHeight: 25,
                                    style: TextStyle(fontSize: 20, color: Colors.black),
                                    enabled: false,
                                    controller: TEC_skuNm,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'SKU명',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new SizedBox(height: 5,),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 300,
                                  child: new TextField(
                                    cursorHeight: 25,
                                    style: TextStyle(fontSize: 20, color: Colors.black),
                                    enabled: false,
                                    controller: TEC_lotNo,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'LOT',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new SizedBox(height: 10,),
                            new DottedLine(dashColor: Colors.blue,),
                            new SizedBox(height: 10,),
                          ],
                        ),
                      ),
                      new Container(
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.blue.shade700)
                        // ),
                        child: new Column(
                          children: <Widget>[
                            new SizedBox(height: 5,),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 300,
                                  child: new TextField(
                                    cursorHeight: 25,
                                    style: TextStyle(fontSize: 20, color: Colors.black),
                                    controller: TEC_skuQty,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: '수량',
                                      // icon: Icon(Icons.search_rounded,size: 20,)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new SizedBox(height: 5,),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 300,
                                  child: new TextField(
                                    cursorHeight: 25,
                                    style: TextStyle(fontSize: 20, color: Colors.black),
                                    controller: TEC_cellLoc,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: '저장위치',
                                      // icon: Icon(Icons.search_rounded,size: 20,)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new SizedBox(height: 5,),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 300,
                                  child: new TextField(
                                    cursorHeight: 25,
                                    style: TextStyle(fontSize: 20, color: Colors.black),
                                    controller: TEC_reMark,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: '비고',
                                      // icon: Icon(Icons.search_rounded,size: 20,)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new SizedBox(height: 5,),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 52,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          Flexible(
                                            fit: FlexFit.loose,
                                            flex: 2,
                                            child: Container(
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: new Text(
                                                '실사항목 : ',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex : 3,
                                            child: Container(
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: new DropdownButton<String>(
                                                underline: Container(height: 0,),
                                                isExpanded: true,
                                                value: _selValue,
                                                items: provider.uiInfo.LS_uiInfo.map<DropdownMenuItem<String>>((data) =>
                                                    DropdownMenuItem<String>(
                                                      value: data.pCCD_CD,
                                                      child: Text(data.pCCD_NM),
                                                    )
                                                ).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selValue = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            new SizedBox(height: 10,),
                            new DottedLine(dashColor: Colors.blue,),
                            new SizedBox(height: 10,),
                          ],
                        ),
                      ),
                      new Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  height: 100,
                                  // color: Colors.blue,
                                  decoration: BoxDecoration(
                                      boxShadow: <BoxShadow>[

                                      ]
                                  ),
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
                                              child: new RaisedButton(
                                                  textColor: Colors.white,
                                                  color: Colors.blue,
                                                  child: Text('저장하기'),
                                                  onPressed: (){

                                                  }
                                              ),
                                            ),
                                            new SizedBox(width: 5,),
                                            new ButtonTheme(
                                              height: 50,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: new RaisedButton(
                                                  textColor: Colors.white,
                                                  color: Colors.blue,
                                                  child: Text('실사완료'),
                                                  onPressed: (){

                                                  }
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
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
      appBar: _buildAppBar(context, Prvd_StockTaking()),
      drawer: Sub_MenuPage(),
      body: _buildBody(),
    );
  }
}