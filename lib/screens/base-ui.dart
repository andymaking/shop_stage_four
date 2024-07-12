import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../utils/widget_extensions.dart';
import '../data/services/local/theme.service.dart';
import 'base-vm.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final bool notDefaultLoading;
  final Color? loaderColor;
  final Widget Function(
      BuildContext context, T model, ThemeModel theme, Widget? child)? builder;
  final Function(T)? onModelReady;
  final Function(T)? onMount;
  final Function(T)? onDisposeModel;
  final Function(AppLifecycleState, T)? didChangeAppLifecycleState;

  const BaseView(
      {Key? key, this.builder, this.onModelReady, this.onDisposeModel, this.notDefaultLoading=false, this.onMount, this.loaderColor, this.didChangeAppLifecycleState})
      : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> with WidgetsBindingObserver {

  String? currentLocale;
  T model = locator<T>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    currentLocale = model.localeService.language;
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
    if (widget.onMount != null) {
      widget.onMount!(model);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(widget.didChangeAppLifecycleState != null){
      widget.didChangeAppLifecycleState!(state, model);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    if (widget.onDisposeModel != null) {
      widget.onDisposeModel!(model);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (_) => model,
        child: Consumer2<T, ThemeModel>(
          builder: (_, model, theme,  __) => Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTap: FocusManager.instance.primaryFocus?.unfocus,
                        child: widget.builder!.call(_, model, theme, __)
                    ),
                  ),
                ],
              ),
              model.isLoading && widget.notDefaultLoading==true?
              SmallLoader(color: widget.loaderColor,) : 0.0.sbH ,
            ],
            //widget.builder!,
          ),
        )
    );
  }
}

class SmallLoader extends StatelessWidget {
  final Color? color;
  const SmallLoader({
    super.key, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: [
          const ModalBarrier(color: Colors.transparent),
          Container(
            height: 70,
            width: 70,
            color: color!=null? (color!.withOpacity(0.3)) : Theme.of(context).primaryColor.withOpacity(0.3),
            child: Center(
                child: SpinKitRing(
                  color: color ?? Theme.of(context).primaryColor,
                  size: 50.sp,
                )),
          )
        ]);
  }
}