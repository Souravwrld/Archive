import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:JazakAllah/application/utility/colors.dart';
import 'package:JazakAllah/presentation/ui/screens/chat_screen.dart';
import 'package:JazakAllah/presentation/ui/utility/assets_path.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    Key? key,
    required this.text,
    required this.chatMessageType,
  }) : super(key: key);

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 2 / 3;
    final isUserMessage = chatMessageType == ChatMessageType.user;
    final borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(isUserMessage ? 20 : 8),
      bottomRight: Radius.circular(isUserMessage ? 8 : 20),
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
    );

    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(maxWidth: maxWidth),
        decoration: BoxDecoration(
          color: isUserMessage
              ? AppColors.colorGradient2Start
              : AppColors.colorWhiteHighEmp,
          borderRadius: borderRadius,
        ),
        child: isUserMessage
            ? Text(
                text,
                style: TextStyle(
                  color: AppColors.colorWhiteHighEmp,
                  fontSize: 14.sp,
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    AssetsPath.contentCopyIconSVG,
                  ),
                ],
              ),
      ),
    );
  }
}
