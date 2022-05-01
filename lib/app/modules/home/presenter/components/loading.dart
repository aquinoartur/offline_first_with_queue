import 'package:flutter/cupertino.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: CupertinoActivityIndicator(
          color: Color.fromARGB(255, 70, 69, 69),
        ),
      ),
    );
  }
}
