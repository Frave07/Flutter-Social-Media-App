import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/home/home_page.dart';
import 'package:social_media/ui/themes/colors_frave.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({Key? key}) : super(key: key);

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  late List<AssetEntity> _mediaList = [];
  late File fileImage;

  @override
  void initState() {
    _assetImagesDevice();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _assetImagesDevice() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);

      if (albums.isNotEmpty) {
        List<AssetEntity> photos =
            await albums[0].getAssetListPaged(page: 0, size: 90);

        setState(() => _mediaList = photos);
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final storyBloc = BlocProvider.of<StoryBloc>(context);

    return BlocListener<StoryBloc, StoryState>(
      listener: (context, state) {
        if (state is LoadingStory) {
          modalLoading(context, 'Cargando...');
        } else if (state is FailureStory) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessStory) {
          Navigator.pop(context);
          modalSuccess(
            context,
            'Historia agregada!',
            onPressed: () => Navigator.pushAndRemoveUntil(
                context, routeSlide(page: const HomePage()), (_) => false),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const TextCustom(
            text: 'Galeria',
            fontSize: 19,
            letterSpacing: .8,
          ),
          leading: IconButton(
              splashRadius: 20,
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.black87)),
          actions: [
            BlocBuilder<StoryBloc, StoryState>(
              builder: (context, state) => TextButton(
                  onPressed: () {
                    if (state.image != null) {
                      storyBloc.add(OnAddNewStoryEvent(state.image!.path));
                    }
                  },
                  child: const TextCustom(
                      text: 'Hecho', fontSize: 17, color: ColorsFrave.primary)),
            )
          ],
        ),
        body: Column(
          children: [
            BlocBuilder<StoryBloc, StoryState>(
                builder: (_, state) => state.image != null
                    ? Container(
                        height: size.height * .4,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(state.image!))),
                      )
                    : Container(
                        height: size.height * .4,
                        width: size.width,
                        color: Colors.black87,
                        child: const Icon(Icons.wallpaper_rounded,
                            color: Colors.white, size: 90),
                      )),
            Expanded(
              child: Container(
                height: size.height,
                width: size.width,
                color: Colors.black,
                child: GridView.builder(
                  itemCount: _mediaList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () async {
                        fileImage = (await _mediaList[i].file)!;
                        storyBloc.add(OnSelectedImagePreviewEvent(fileImage));
                      },
                      child: FutureBuilder(
                        future: _mediaList[i].thumbnailDataWithSize(
                            const ThumbnailSize(200, 200)),
                        builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              height: 85,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(snapshot.data!))),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
