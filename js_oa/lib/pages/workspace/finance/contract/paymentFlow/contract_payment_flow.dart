import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:js_oa/controller/upload/upload_image_controller.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/pages/workspace/approve/workflow/workflow.dart';
import 'package:js_oa/pages/workspace/controller/contract_controller.dart';
import 'package:js_oa/pages/workspace/controller/contract_payment_flow_controller.dart';
import 'package:js_oa/pages/workspace/entity/contract_entity.dart';
import 'package:js_oa/pages/workspace/widgets/customRadio.dart';
import 'package:js_oa/pages/workspace/widgets/download.dart';
import 'package:js_oa/service/upload/upload_file_type.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:js_oa/utils/other/toast_util.dart';
import 'package:js_oa/utils/permission/camera_access_util.dart';
import 'package:js_oa/utils/permission/photos_access_util.dart';
import 'package:js_oa/widgets/alert_sheet/action_sheet_widget.dart';
import 'package:js_oa/widgets/alert_sheet/alert_dialog_widget.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ContractPaymentFlow extends StatefulWidget {
  ContractPaymentFlow({Key? key}) : super(key: key);

  @override
  _ContractPaymentFlowState createState() => _ContractPaymentFlowState();
}

class _ContractPaymentFlowState extends State<ContractPaymentFlow> {
  int? contractId = Get.arguments;
  late int chooseClientGroupValue = 0;
  late int paymentTypeGroupValue = 0;
  ContractPaymentFlowController controller =
      Get.put(ContractPaymentFlowController());
  final personInfoCtrl = Get.put(UploadImageController());

  @override
  void initState() {
    controller.indata.contractId = contractId.toString();
    controller.getContractInfo(contractId: contractId);
    controller.getWorkflowDefinition(code: "Payment");
    controller.getPaymentType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("????????????"),
        actions: [
          TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.contractPaymentHistory,
                    arguments: controller.contract.value.id);
              },
              child: Text(
                "????????????",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("????????????"),
                        SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          color: Colors.white,
                          child: Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "???????????????${controller.contract.value.contractTypeName ?? " ??????"}",
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "???????????????${controller.contract.value.contractNumber ?? " ??????"}",
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "???????????????${controller.contract.value.clientSourceName ?? " ??????"}",
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "????????????${clientListString(controller.contract.value.clients ?? [])}",
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "??????????????????${clientListString(controller.contract.value.privies ?? [])}",
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "????????????${clientListString(controller.contract.value.thirdParties ?? [])}",
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "???????????????${controller.contract.value.realName ?? " ??????"}",
                                ),
                              ],
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("????????????"),
                        SizedBox(height: 8),
                        Obx(() {
                          return controller.contract.value.clients != null
                              ? clientList(
                                  controller.contract.value.clients ?? [])
                              : Container();
                        })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("??????"),
                        SizedBox(height: 8),
                        Text(
                            "1.???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? 2.???????????????????????????????????????????????????????????????????????????????????????"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("?????????"),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Icon(Icons.star_rate,
                                  size: 12, color: Colors.red),
                              SizedBox(width: 4),
                              Text(
                                "????????????",
                                style: TextStyle(color: JSColors.textWeakColor),
                              ),
                              Expanded(
                                  child: TextField(
                                controller: controller.clientController,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("?????????"),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Icon(Icons.star_rate,
                                  size: 12, color: Colors.red),
                              SizedBox(width: 4),
                              Text(
                                "??????????????????",
                                style: TextStyle(color: JSColors.textWeakColor),
                              ),
                              Expanded(
                                  child: TextField(
                                controller: controller.agencyController,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("????????????"),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Icon(Icons.star_rate,
                                  size: 12, color: Colors.red),
                              SizedBox(width: 4),
                              Text(
                                "??????????????????????????????",
                                style: TextStyle(color: JSColors.textWeakColor),
                              ),
                              Expanded(
                                  child: TextField(
                                controller: controller.moneyController,
                                style: TextStyle(fontSize: 14),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("????????????"),
                        SizedBox(height: 8),
                        paymentTime(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("??????????????????"),
                        SizedBox(height: 8),
                        Obx(() {
                          return controller.paymentTypedata.length > 0
                              ? paymentType()
                              : Container();
                        })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("????????????"),
                        SizedBox(height: 8),
                        explain(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("??????"),
                        SizedBox(height: 8),
                        Container(
                          color: Colors.white,
                          constraints: BoxConstraints(
                              maxHeight: 150,
                              maxWidth: double.infinity,
                              minHeight: 50.0,
                              minWidth: double.infinity),
                          padding: EdgeInsets.all(16),
                          child: TextField(
                            maxLines: null,
                            controller: controller.remarkController,
                            style: TextStyle(fontSize: 14),
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration.collapsed(
                              hintText: "???????????????500?????????",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("????????????"),
                        SizedBox(height: 8),
                        Obx(() {
                          return controller.workflowInfo.value.workflowSteps !=
                                  null
                              ? WorkFlow(
                                  flowInfo: controller.workflowInfo.value)
                              : Container();
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            )),
            Container(
              height: 60,
              width: double.infinity,
              // color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextButton(
                    onPressed: () {
                      if (controller.checkInfo()) {
                        showCupertinoDialog(
                          context: context,
                          builder: (ctx) => AlertDialogWidget(
                            title: "????????????",
                            confirmTitle: "??????",
                            confirmPressed: () {
                              controller.createPayment(
                                  successCallBack: (value) {
                                ContractController ctl =
                                    Get.put(ContractController());
                                ctl.paymentLoad();
                                EasyLoading.showSuccess("????????????");
                                Get.back();
                              });
                            },
                          ),
                        );
                      }
                    },
                    child: Text(
                      "??????",
                      // style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget clientList(List<ClientLists> clients) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: clients.length,
              itemBuilder: (buildContext, index) {
                return CustomRadio<int>(
                  value: index,
                  groupValue: chooseClientGroupValue,
                  lable: Text(clients[index].name!),
                  onChanged: (value) {
                    setState(() {
                      chooseClientGroupValue = value;
                      controller.chooseClient.value = clients[value];
                      controller.clientController.text = clients[value].name!;
                    });
                  },
                );
              })
        ],
      ),
    );
  }

  Widget paymentTime() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Row(
        children: [
          Icon(Icons.star_rate, size: 12, color: Colors.red),
          SizedBox(width: 4),
          Text(
            "?????????????????????",
            style: TextStyle(color: JSColors.textWeakColor),
          ),
          Expanded(
              child: TextField(
            controller: controller.timeController,
            keyboardType: TextInputType.none,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            style: TextStyle(fontSize: 14),
            onTap: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2021, 1, 1, 00, 01),
                  maxTime: DateTime(2099, 12, 31, 23, 59), onConfirm: (date) {
                controller.timeController.text =
                    DateFormat("yyyy-MM-dd HH:mm:ss").format(date).toString();
                controller.indata.paymentTime = date.toUtc().toString();
              }, locale: LocaleType.zh);
            },
          ))
        ],
      ),
    );
  }

  Widget paymentType() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.paymentTypedata.length,
              itemBuilder: (buildContext, index) {
                return CustomRadio<int>(
                  value: index,
                  groupValue: paymentTypeGroupValue,
                  lable: Text(controller.paymentTypedata[index].name!),
                  onChanged: (value) {
                    setState(() {
                      paymentTypeGroupValue = value;
                      controller.indata.paymentChannelId =
                          controller.paymentTypedata[value].id;
                    });
                  },
                );
              })
        ],
      ),
    );
  }

  Widget explain() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 105,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.star_rate, size: 12, color: Colors.red),
              SizedBox(width: 4),
              Expanded(child: Text("??????????????????")),
              GestureDetector(
                onTap: () {
                  Download().doDownloadOperation(
                    "????????????",
                    callback: (receivedBytes, totalBytes) {
                      EasyLoading.showProgress(
                          (receivedBytes / totalBytes).toDouble(),
                          maskType: EasyLoadingMaskType.black,
                          status:
                              '${((receivedBytes / totalBytes) * 100).toStringAsFixed(0)}%');
                      if ((receivedBytes / totalBytes) >= 1) {
                        EasyLoading.dismiss();
                        ToastUtil.showToast("????????????,????????????????????????");
                      }
                    },
                  );
                },
                child: Text(
                  "????????????",
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              GetBuilder<UploadImageController>(
                  init: UploadImageController(),
                  builder: (_) {
                    print(_.assets.length);
                    return _.assets.length == 0
                        ? Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.add_box_outlined,
                              color: Colors.grey.shade400,
                            ),
                          )
                        : imageAssetWidget(_.assets.first,
                            height: 50, width: 50);
                  }),
              SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  _takePhoto(context);
                },
                child: Text("????????????"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget imageAssetWidget(
    AssetEntity entity, {
    double? width,
    double? height,
  }) {
    return Image(
      image: AssetEntityImageProvider(entity, isOriginal: false),
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  /*??????*/
  _takePhoto(BuildContext ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (context) => ActionSheetWidget(
        actionTitles: ["??????", "?????????????????????"],
        onPressed: (context, index) async {
          Get.back();
          switch (index) {
            case 0:
              AssetEntity? entity =
                  await CameraAccessUtil.cameraImage(context: ctx);
              if (entity != null) {
                personInfoCtrl.assets = [entity];
                personInfoCtrl.uploadImage(
                    assets: [entity],
                    fileType: UploadFileType.payment,
                    success: (entity) {
                      controller.indata.attachment = entity.fileUrl;
                    });
              }

              break;
            case 1:
              {
                List<AssetEntity>? assets =
                    await PhotosAccessUtil.pickerPhotoImage(context: ctx);
                if (assets != null && assets.isNotEmpty)
                  personInfoCtrl.assets = assets;
                personInfoCtrl.uploadImage(
                    assets: assets!,
                    fileType: UploadFileType.payment,
                    success: (entity) {
                      controller.indata.attachment = entity.fileUrl;
                    });
              }
          }
        },
      ),
    );
  }

  String clientListString(List<ClientLists> clients) {
    String clientStr = "";
    if (clients.length > 0) {
      for (ClientLists item in clients) {
        clientStr += item.name! + " ";
      }
    }
    return clientStr == "" ? "??????" : clientStr;
  }
}
