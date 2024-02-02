import '../../../import.dart';

class MyPosition extends StatelessWidget {
  const MyPosition(
      {super.key,
      required this.position,
      required this.mine,
      required this.pseudo,
      required this.points,
      required this.image});
  final int position;
  final bool mine;
  final String pseudo;
  final int points;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mine == true
            ? position == 1
                ? const Color(0xffC1242D)
                : const Color(0xff272727)
            : position == 1
                ? const Color(0xffC1242D)
                : const Color(0xffFCC213),
      ),
      width: 340,
      height: mine == true ? 100 : 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            position.toString(),
            style: const TextStyle(
              color: MyColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.white, width: 3),
              color: MyColors.grey,
              borderRadius: BorderRadius.circular(50),
              image: image == null
                  ? null
                  : DecorationImage(
                      image: NetworkImage(image ?? ""),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Text(
            pseudo,
            style: const TextStyle(
              color: MyColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SvgPicture.asset(
            "images/svgs/challenge/position_icon.svg",
            // ignore: deprecated_member_use
            color: position == 1
                ? const Color(0xffFCC213)
                : mine == true
                    ? MyColors.white
                    : const Color(0xffC1242D),
          ),
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: mine == false && position != 1
                  ? const Color(0xffC1242D)
                  : const Color(0xffFCC213),
            ),
            child: Text(
              points.toString(),
              style: const TextStyle(
                color: MyColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
