import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/domain/blocs/post/post_bloc.dart';

class AppPermission {

  final ImagePicker _picker = ImagePicker();


  Future<void> permissionAccessGalleryOrCameraForCover(PermissionStatus status, BuildContext context, ImageSource source) async {

    switch (status){
    
      case PermissionStatus.granted:
          final XFile? imagePath = await _picker.pickImage(source: source);
          if( imagePath != null ){
            BlocProvider.of<UserBloc>(context).add( OnUpdatePictureCover( imagePath.path ));
          }
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }


  Future<void> permissionAccessGalleryOrCameraForProfile(PermissionStatus status, BuildContext context, ImageSource source) async {

    switch (status){
    
      case PermissionStatus.granted:
          final XFile? imagePath = await _picker.pickImage(source: source);
          if( imagePath != null ){
            BlocProvider.of<UserBloc>(context).add( OnUpdatePictureProfile( imagePath.path ));
          }
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }


  Future<void> permissionAccessGalleryOrCameraForNewPost(PermissionStatus status, BuildContext context, ImageSource source) async {

    switch (status){
    
      case PermissionStatus.granted:
          final XFile? imagePath = await _picker.pickImage(source: source);
          if( imagePath != null ){
            BlocProvider.of<PostBloc>(context).add( OnSelectedImageEvent( File(imagePath.path) ));
          }
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }
  
  
  Future<void> permissionAccessGalleryMultiplesImagesNewPost(PermissionStatus status, BuildContext context) async {

    switch (status){
    
      case PermissionStatus.granted:
          final List<XFile?>? imagePath = await _picker.pickMultiImage();
          if( imagePath != null ){
            for (var image in imagePath) { 
              BlocProvider.of<PostBloc>(context).add( OnSelectedImageEvent( File(image!.path) ));
            }
          }
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }




}