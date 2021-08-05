import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Global/G_Control.dart';
import 'package:untitled/Model/MD_PaInfo.dart';
import 'package:untitled/Provider/PRVD_PaInfo.dart';
import 'package:untitled/Ui/Drawer.dart';
import 'package:untitled/Ui/Appbar.dart';

/// 입고 화면
class PaInfoPage extends StatefulWidget {
  PaInfoPage({Key key}) : super(key: key);
  static const routeName = '/painfo';

  @override
  _PaInfoPageState createState() => _PaInfoPageState();

}

var _selValue = null;

class _PaInfoPageState extends State<PaInfoPage> {

  List<PaInfo> LS_selPaData = [];

  TextEditingController TEC_search = TextEditingController();
  TextEditingController TEC_skuCd = TextEditingController();
  TextEditingController TEC_skuNm = TextEditingController();
  TextEditingController TEC_area = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    TEC_search.dispose();
    TEC_skuCd.dispose();
    TEC_skuNm.dispose();
    TEC_area.dispose();
    super.dispose();
  }

  // DataTable에서 Pa Data 선택
  _selectedPaData(bool selected, PaInfo data) async {
    setState(() {
      if(selected){
        LS_selPaData.add(data);
      }
      else{
        LS_selPaData.remove(data);
      }
    });
  }

  _getBarCodeData(BuildContext context) async {
    String STR_BarCode = (await BarcodeScanner.scan()) as String;

    TEC_search.text = "";
    TEC_search.text = STR_BarCode;
  }

  // 입고정보 조회
  _getPaInfo(BuildContext context, Prvd_PaInfo provider) async{

    LS_selPaData = []; // 초기화

    if(TEC_search.text == null || TEC_search.text == '')
    {
      _getBarCodeData(context);
    }
    else
    {
      int I_result = await provider.getUiData(context, TEC_search.text);

      if(I_result == 0){
        showDialogOk(context, '검색된 데이터 없음', '입고 정보');
        return;
      }

      provider.getUiData(context, 'CELL_NO');
    }
  }

  Widget _buildBody() {
    return WillPopScope(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ChangeNotifierProvider<Prvd_PaInfo>(
          create: (context) => Prvd_PaInfo(),
          child: Consumer<Prvd_PaInfo>(
            builder: (context, provider, child){
              // if(provider.pa_info_data == null){
              //   provider.getPaData(context, '');
              //   return Center(child: CircularProgressIndicator());
              // }
              if (provider.uiInfo == null) {
                provider.getUiData(context, 'CELL_NO');
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
                                  flex: 5,
                                  child: new Container(
                                    height: 50,
                                    child: new TextField(
                                      cursorHeight: 25,
                                      style: TextStyle(fontSize: 20, color: Colors.black),
                                      controller: TEC_search,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'BarCode 입력',
                                      ),
                                    ),
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
                                            _getPaInfo(context, provider);
                                          },
                                        )
                                    ),
                                  )
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.all(5),
                      child: new Column(
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                  child: new Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue.shade700),
                                      // borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: new SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      // child: DataTable(
                                      //   headingRowColor: MaterialStateColor.resolveWith(
                                      //           (states) => Colors.lightBlueAccent),
                                      //   dividerThickness: 3,
                                      //   showBottomBorder: true,
                                      //   columnSpacing: 40,
                                      //   columns: [
                                      //     DataColumn(
                                      //         label: Text('순번')
                                      //     ),
                                      //     DataColumn(
                                      //         label: Text('상품코드')
                                      //     ),
                                      //     DataColumn(
                                      //         label: Text('수량')
                                      //     ),
                                      //   ],
                                      //   rows: provider.pa_info_data.paInfo.map((data) =>
                                      //       DataRow(
                                      //           // selected: selectedPaData.contains(data),
                                      //           // onSelectChanged: (b){
                                      //           //   _selectedPaData(b, data);
                                      //           // },
                                      //           cells: [
                                      //             DataCell(Text('')),
                                      //             DataCell(Text('')),
                                      //             DataCell(Text('')),
                                      //           ]
                                      //       )
                                      //   ),
                                      // ),
                                    ),
                                  )
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.all(5),
                      child: new Column(
                        children: <Widget>[
                          new Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Flexible(
                                  child: new Container(
                                    height: 30,
                                    width: 150,
                                    child: new TextField(
                                        cursorHeight: 20,
                                        style: TextStyle(fontSize: 15, color: Colors.black),
                                        controller: TEC_skuCd,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: '상품 CODE',
                                        )
                                    ),
                                  )
                              ),
                            ],
                          ),
                          new SizedBox(height: 5,),
                          new Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Flexible(
                                  child: new Container(
                                    height: 30,
                                    width: 300,
                                    child: new TextField(
                                        cursorHeight: 20,
                                        style: TextStyle(fontSize: 15, color: Colors.black),
                                        controller: TEC_skuNm,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: '상품명',
                                        )
                                    ),
                                  )
                              ),
                            ],
                          ),
                          new SizedBox(height: 5,),
                          new Row(
                            children: <Widget>[
                              new Flexible(
                                  child: new Container(
                                    height: 25,
                                    child: new Text(
                                      '· 적재수량',
                                      style: new TextStyle(fontSize: 16.0),
                                    ),
                                  )
                              ),
                              new SizedBox(width: 5,),
                              new Flexible(
                                  child: new Container(
                                      height: 30,
                                      child: new TextField(
                                          cursorHeight: 20,
                                          style: TextStyle(fontSize: 15, color: Colors.black),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'CTN',
                                          )
                                      )
                                  )
                              ),
                              new SizedBox(width: 5,),
                              new Flexible(
                                  child: new Container(
                                      height: 30,
                                      child: new TextField(
                                          cursorHeight: 20,
                                          style: TextStyle(fontSize: 15, color: Colors.black),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: '증포',
                                          )
                                      )
                                  )
                              ),
                              new SizedBox(width: 15,),
                              new Flexible(
                                  child: new Container(
                                      height: 30,
                                      child: new TextField(
                                          cursorHeight: 20,
                                          style: TextStyle(fontSize: 15, color: Colors.black),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: '수량',
                                          )
                                      )
                                  )
                              ),
                            ],
                          ),
                          new SizedBox(height: 5,),
                          new Row(
                            children: <Widget>[
                              new Flexible(
                                  child: new Container(
                                    height: 25,
                                    child: new Text(
                                      '· 적치',
                                      style: new TextStyle(fontSize: 16.0),
                                    ),
                                  )
                              ),
                              new SizedBox(width: 5,),
                              new Flexible(
                                  flex: 2,
                                  child: new Container(
                                      height: 30,
                                      child: new TextField(
                                          cursorHeight: 20,
                                          style: TextStyle(fontSize: 15, color: Colors.black),
                                          controller: TEC_area,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'AREA',
                                          )
                                      )
                                  )
                              ),
                              new SizedBox(width: 10,),
                              new Flexible(
                                  flex: 2,
                                  child: new Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.black12,
                                        border: Border.all(color: Colors.black12),
                                      ),
                                      child: new DropdownButtonHideUnderline(
                                          child: new DropdownButton<String>(
                                              isExpanded: true,
                                              value: _selValue,
                                              hint: Text('Pick Location'),
                                              items: provider.uiInfo.LS_uiInfo.map<DropdownMenuItem<String>>((data) =>
                                                  DropdownMenuItem<String>(
                                                    value: data.pCCD_NM,
                                                    child: Text(data.pCCD_NM),
                                                  )
                                              ).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  _selValue = value;
                                                  TEC_area.text = value;
                                                });
                                              }
                                          )
                                      )
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      // margin: EdgeInsets.all(5),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    child: Text('입고'),
                                    onPressed: (){

                                    },
                                  )
                              ),
                              new ButtonTheme(
                                  height: 50,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: new ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue
                                    ),
                                    child: Text('닫기'),
                                    onPressed: (){
                                      _selValue = null;
                                      Navigator.pop(context);
                                    },
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }, // builder: (context, provider, child)
          ),
        ),
      ),
      onWillPop: () {
        // Navigator.pop(context);
      },
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