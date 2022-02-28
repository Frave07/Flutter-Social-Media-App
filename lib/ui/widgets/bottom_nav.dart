part of 'widgets.dart';

class BottomNavigationFrave extends StatelessWidget {

  final int index;
  final bool isReel;

  const BottomNavigationFrave({Key? key, required this.index, this.isReel = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: isReel ? Colors.black : Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 9, spreadRadius: -4)
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ItemButtom(
            i: 1,
            index: index,
            isIcon: false,
            iconString: 'assets/svg/home_icon.svg',
            isReel: isReel,
            onPressed: () => Navigator.pushAndRemoveUntil(context, routeSlide(page: const HomePage()), (_) => false),
          ),
          _ItemButtom(
            i: 2,
            index: index,
            icon: Icons.search,
            isReel: isReel,
            onPressed: () => Navigator.pushAndRemoveUntil(context, routeSlide(page: const SearchPage()), (_) => false),
          ),
          _ItemButtom(
            i: 3,
            index: index,
            isIcon: false,
            isReel: isReel,
            iconString: 'assets/svg/movie_reel.svg',
            onPressed: () => Navigator.push(context, routeSlide(page: const ReelHomeScreen())),
          ),
          _ItemButtom(
            i: 4,
            index: index,
            icon: Icons.favorite_border_rounded,
            isReel: isReel,
            onPressed: () => Navigator.pushAndRemoveUntil(context, routeSlide(page: const NotificationsPage()), (_) => false),
          ),
          _ItemProfile()
        ],
      ),
    );
  }
}

class _ItemProfile extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushAndRemoveUntil(context, routeSlide(page: const ProfilePage()), (_) => false),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (_, state) 
          => state.user?.image != null 
            ? CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(Environment.baseUrl+ state.user!.image )
              )
            : const CircleAvatar(
                radius: 15,
                backgroundColor: ColorsFrave.primary,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
              )
      ),
    );
  }
}

class _ItemButtom extends StatelessWidget {

  final int i;
  final int index;
  final bool isIcon;
  final IconData? icon;
  final String? iconString;
  final Function() onPressed;
  final bool isReel;

  const _ItemButtom({
    Key? key,
    required this.i,
    required this.index,
    required this.onPressed,
    this.icon,
    this.iconString,
    this.isIcon = true,
    this.isReel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: ( isIcon ) 
          ? Icon(icon, color: ( i == index ) ? ColorsFrave.primary : isReel ?Colors.white : Colors.black87 , size: 28)
          : SvgPicture.asset(iconString!, height: 25, color: ( i == index ) ? ColorsFrave.primary : isReel ?Colors.white : Colors.black87),
      ),
    );
  }
}