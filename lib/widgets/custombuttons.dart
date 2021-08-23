import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
 final String? text;
 final void Function()? onPressed;
 final bool? outlineBtn;
 final bool? isLoading;

 CustomBtn({this.text, this.outlineBtn,this.onPressed , this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
       onTap: onPressed,
      child: Container(
         height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
            color: Colors.black,
            borderRadius: BorderRadius.circular(12.0)
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: Stack(
          children: [
               Visibility(
                 visible: _isLoading ? false : true,
                 child: Text(
                  text??"Text",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
              ),
               ),
            Visibility(
                visible: _isLoading,
                child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
