import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/find/new_enquiry_view_model.dart';

class NewFindWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FindViewModel>(
        converter: (store) => FindViewModel.fromStore(store),
        onInitialBuild: (viewModel) => viewModel.getCategories(),
        onWillChange: (old, viewModel) {
          if (!old.isEnquirySaved && viewModel.isEnquirySaved) {
            final snackBar =
                SnackBar(content: Text("Enquiry Saved Successfully"));
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar)
                .closed
                .then((value) => DefaultTabController.of(context).animateTo(1));
          }
          if (old.isLoading && viewModel.hasError) {
            final snackBar =
                SnackBar(content: Text(viewModel.loadingError ?? ""));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        onDispose: (store) => store.dispatch(OnClearAction(type: "Find")),
        builder: (context, viewModel) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IntrinsicHeight(
                        child: Row(children: [
                      SizedBox(
                          height: 120,
                          width: 90,
                          child: SvgPicture.asset(
                            AppVectors.find_icon,
                            height: 120,
                            width: 90,
                          )),
                      SizedBox(width: 18),
                      Expanded(
                          child: Text(
                              'Its so easy to find any thing !!!\nJust scan & Upload the product image ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Calibri',
                                fontSize: 14,
                                color: const Color(0xff1d1d1d),
                                letterSpacing: 0.26,
                                fontWeight: FontWeight.w700,
                              )))
                    ])),
                    SizedBox(height: 28),
                    Text(
                      'Categories you can find Now : ',
                      style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 16,
                        color: const Color(0xff1d1d1d),
                        letterSpacing: 0.24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                      child: Wrap(spacing: 8.0, children: [
                        ...viewModel.categories
                            .map((cat) => ChoiceChip(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                          width: 1.0,
                                          color: const Color(0xffffb517))),
                                  label: Text('${cat.categoryName}',
                                      textAlign: TextAlign.left),
                                  selected:
                                      cat.id == viewModel.selectedCategory?.id,
                                  onSelected: (bool) =>
                                      viewModel.onSelectCategory(cat, bool),
                                  labelStyle: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0.24,
                                    fontWeight: FontWeight.w600,
                                  ),

                                  selectedColor: AppColors.kPrimaryColor,
                                  // disabledColor: Colors.white,
                                ))
                            .toList(),
                        Chip(
                            label: Text(
                          'etc...',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Calibri',
                            fontSize: 12,
                            color: const Color(0xff1d1d1d),
                            letterSpacing: 0.24,
                          ),
                        ))
                      ]),
                    ),
                    FittedBox(
                      child: _UploaderView(
                        image: viewModel.scannedImage,
                        onFilePicked: viewModel.onFilePicked,
                      ),
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                    SizedBox(height: 18),
                    _Submit(
                      remarks: viewModel.remarks,
                      onSubmit: (remarks) {
                        String validate = viewModel.validateSave(remarks);
                        if (validate?.isNotEmpty ?? false)
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(validate)));
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class _UploaderView extends StatelessWidget {
  final ValueSetter<String> onFilePicked;
  final String image;

  const _UploaderView({Key key, this.onFilePicked, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openImagePickerModal(context, onFilePicked),
      child: Container(
        width: MediaQuery.of(context).size.width * 2.5 / 3,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 3),
              spreadRadius: 1.2,
            ),
          ],
        ),
        child: DottedBorder(
          padding: EdgeInsets.all(10),
          radius: Radius.circular(18.0),
          strokeCap: StrokeCap.round,
          borderType: BorderType.RRect,
          color: AppColors.kPrimaryColor,
          dashPattern: [8, 6, 8],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Scan & Upload the Image',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xff1d1d1d),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.24,
                ),
              ),
              SizedBox(height: 18),
              if (image != null)
                Image.file(File(image))
              else
                SvgPicture.asset(AppVectors.upload_icon),
            ],
          ),
        ),
      ),
    );
  }

  void openImagePickerModal(
      BuildContext context, ValueSetter<String> onFilePicked) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Select Image',
                  style: TextStyle(
                    color: AppColors.kPrimaryColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.75,
                  ),
                ),
                Divider(thickness: 1),
                SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      foregroundColor: AppColors.kPrimaryColor,
                      radius: 32,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 32,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _getImage(context, ImageSource.camera);
                        },
                      ),
                    ),
                    SizedBox(width: 14),
                    CircleAvatar(
                      foregroundColor: AppColors.kPrimaryColor,
                      radius: 32,
                      child: IconButton(
                        icon: Icon(
                          Icons.photo,
                          size: 32,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _getImage(context, ImageSource.gallery);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void _getImage(BuildContext context, ImageSource source) async {
    PickedFile image = await ImagePicker().getImage(source: source);

    if (image != null) onFilePicked(image.path);

    Navigator.pop(context);
  }
}

class _Submit extends StatefulWidget {
  final String remarks;
  final ValueSetter<String> onSubmit;

  const _Submit({Key key, this.remarks, this.onSubmit}) : super(key: key);

  @override
  __SubmitState createState() => __SubmitState();
}

class __SubmitState extends State<_Submit> {
  String _remarks;

  @override
  void initState() {
    super.initState();
    _remarks = widget.remarks ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: AppColors.kPrimaryColor, width: 0.25),
              ),
              child: TextFormField(
                  initialValue: _remarks,
                  maxLines: 2,
                  keyboardType: TextInputType.streetAddress,
                  validator: (val) {
                    return null;
                  },
                  onChanged: (val) => setState(() => _remarks = val),
                  onSaved: (val) => setState(() => {}),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    hintText: "Remarks",
                    suffixText: "",
                    focusedBorder: null,
                    border: null,
                  ))),
          SizedBox(height: 4),
          InkWell(
            onTap: () => widget.onSubmit(_remarks),
            child: Container(
                alignment: Alignment.center,
                height: 46,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: const Color(0xffff4646),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x82ff4646),
                      offset: Offset(0, 7),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Text('Enquire Now',
                    style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xffffffff),
                        letterSpacing: 0.496,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left)),
          )
        ],
      ),
    );
  }
}
