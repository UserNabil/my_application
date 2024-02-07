import 'package:flutter/Material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/crowdfunding/view/crowdfunding_page.dart';
import 'package:my_taraji/views/home/models/crowdfunding.dart';

class CrowdfundingCard extends StatelessWidget {
  final Crowdfunding crowdfunding;
  const CrowdfundingCard({super.key, required this.crowdfunding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CrowdfundingPage(
              crowdfunding: crowdfunding,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(crowdfunding.imageUrl ?? ''),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                MyColors.red.withOpacity(0.3),
                MyColors.red,
              ],
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      crowdfunding.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      crowdfunding.description ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
