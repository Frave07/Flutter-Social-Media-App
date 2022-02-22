part of 'widgets.dart';

class BottomNavigationFrave extends StatelessWidget {

  final int index;

  const BottomNavigationFrave({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 55,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: -5)
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
            onPressed: () => Navigator.pushAndRemoveUntil(context, routeSlide(page: const HomePage()), (_) => false),
          ),
          _ItemButtom(
            i: 2,
            index: index,
            icon: Icons.search,
            onPressed: () => Navigator.pushAndRemoveUntil(context, routeSlide(page: const SearchPage()), (_) => false),
          ),
          _ItemButtom(
            i: 3,
            index: index,
            icon: Icons.add_circle_outline_rounded,
            onPressed: () => Navigator.pushAndRemoveUntil(context, routeSlide(page: const AddPostPage()), (_) => false),
          ),
          _ItemButtom(
            i: 4,
            index: index,
            icon: Icons.favorite_border_rounded,
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
                backgroundColor: ColorsFrave.primaryColorFrave,
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

  const _ItemButtom({
    Key? key,
    required this.i,
    required this.index,
    required this.onPressed,
    this.icon,
    this.iconString,
    this.isIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: ( isIcon ) 
          ? Icon(icon, color: ( i == index ) ? ColorsFrave.primaryColorFrave : Colors.black87 , size: 28)
          : SvgPicture.asset(iconString!, height: 25, color: ( i == index ) ? ColorsFrave.primaryColorFrave : Colors.black87 ),
      ),
    );
  }
}