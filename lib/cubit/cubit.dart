import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sporta/cubit/states.dart';
import 'package:sporta/models/message_model.dart';
import 'package:sporta/models/post_model.dart';
import 'package:sporta/models/user_model.dart';
import 'package:sporta/modules/home/home_screen.dart';
import 'package:sporta/modules/login/login_screen.dart';
import 'package:sporta/modules/notification/notification_screen.dart';
import 'package:sporta/modules/profile/profile_screen.dart';
import 'package:sporta/modules/seacrh/search_screen.dart';
import 'package:sporta/shared/components/constants.dart';
import 'package:sporta/shared/network/local/cashed_helper.dart';
import 'package:sporta/shared/styles/icon_broken.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  bool isSignIn = true;
  bool isTrainee = true;
  bool isSubscribe = false;
  int currentIndex = 0;
  bool profileUpdate = false;
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];
  List<String> titles = [
    'الرئيسية',
    'البحث',
    'الاشعارات',
    'الملف الشخصي',
  ];
  List<SalomonBottomBarItem> items = [
    SalomonBottomBarItem(
      icon: const Icon(IconBroken.Home),
      title: const Text('الرئيسية'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(IconBroken.Search),
      title: const Text('البحث'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(IconBroken.Notification),
      title: const Text('الاشعارات'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(IconBroken.Profile),
      title: const Text('الملف الشخصي'),
    ),
  ];

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    print(currentIndex);
    emit(ChangeBottomNAVIndexSuccess());
  }

  void updateProfileState() {
    profileUpdate = !profileUpdate;
    emit(UpdateProfileSuccess());
  }

  void changBetweenSignInAndSignUp(bool state) {
    isSignIn = state;
    emit(SinInAndSignUpChangeState());
  }

  void changBetweenTraineeAndTraining(bool state) {
    isTrainee = state;
    emit(TraineeAndTrainingChangeState());
  }

  void registerByEmail({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String city,
    required String age,
    required String gender,
    String? trainingType,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      uId = value.user!.uid;
      CashedHelper.putData(key: uIdKey, value: uId);
      createUser(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        city: city,
        age: age,
        gender: gender,
        trainingType: trainingType,
      );
      print(value.user!.uid);
      currentIndex = 0;
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  void loginByEmail({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      uId = value.user!.uid;
      CashedHelper.putData(key: uIdKey, value: uId);
      print(value.user!.uid);
      currentIndex = 0;
      getUserDetails();
      emit(LoginSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }

  UserModel? userModel;
  void createUser({
    required String name,
    required String email,
    required String phoneNumber,
    required String city,
    required String age,
    required String gender,
    String? trainingType,
  }) {
    // emit(UploadUserDataLoadingState());
    userModel = UserModel(
      name: name,
      gender: gender,
      trainingType: trainingType,
      age: age,
      city: city,
      email: email,
      phoneNumber: phoneNumber,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel!.toMap())
        .then((value) {
      emit(UploadUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UploadUserDataErrorState());
    });
  }

  void getUserDetails() {
    if (uId.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        userModel = UserModel.fromJson(value.data());
        print(allUsers.toString());
        emit(GetAllUserDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetAllUserDataErrorState());
      });
    }
  }

  void logout({
    required BuildContext context,
  }) {
    CashedHelper.removeData(key: uIdKey);
    isTrainee = true;
    isSignIn = true;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(),
      ),
      (route) => false,
    );
    emit(LogoutSuccessState());
  }

  void updateUserData({
    required String name,
    required String email,
    required String phoneNumber,
    required String city,
  }) {
    emit(UpdateUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).update({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
    }).then((value) {
      profileUpdate = true;
      getUserDetails();
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataErrorState());
    });
  }

  List<UserModel> allUsers = [];
  Future<void> getAllUsers() async {
    if (uId.isNotEmpty) {
      if (userModel!.trainingType == null) {
        FirebaseFirestore.instance
            .collection('users')
            .snapshots()
            .listen((event) {
          allUsers = [];
          for (var element in event.docs) {
            if (element.data()['trainingType'] != null) {
              if (element.data()['uId'] != uId) {
                allUsers.add(UserModel.fromJson(element.data()));
              }
            }
          }
          print(allUsers[0].name.toString());
        });
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .snapshots()
            .listen((event) {
          allUsers = [];
          for (var element in event.docs) {
            if (element.data()['trainingType'] == null) {
              if (element.data()['uId'] != uId) {
                allUsers.add(UserModel.fromJson(element.data()));
              }
            }
          }
          print(allUsers[0].name.toString());
          print(allUsers.toString());
        });
      }
    }
  }

  void sendMessage({
    required String text,
    required String receiverID,
    required String dateTime,
  }) {
    MessageModel model = MessageModel(
      dateTime: dateTime,
      receiverId: receiverID,
      senderId: uId,
      text: text,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      getMessages(receiverId: receiverID);
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      getMessages(receiverId: receiverID);
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({
    required String receiverId,
  }) {
    {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .orderBy('dateTime')
          .snapshots()
          .listen((event) {
        messages = [];
        for (var element in event.docs) {
          messages.add(MessageModel.fromJson(element.data()));
        }
        print('Messages : $messages');
        // emit(GetMessageSuccessState());
      }).onError((error) {
        getMessages(receiverId: receiverId);
      });
    }
  }

  File? postImage;
  final ImagePicker postPicker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await postPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(CreatePostImageSuccessState());
    } else {
      print('Not found any image');
      emit(CreatePostImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(PostImageRemoveState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
        emit(CreatePostImageSuccessState());
      }).catchError((error) {
        emit(CreatePostImageErrorState());
      });
    }).catchError((error) {
      emit(CreatePostImageErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    var postModel = PostModel(
      name: userModel!.name,
      postImage: postImage ?? '',
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      isTrainee: userModel!.trainingType == null ? true : false,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];
  void getPosts() {
    if (userModel!.trainingType == null) {
      FirebaseFirestore.instance
          .collection('posts')
          .orderBy('dateTime')
          .snapshots()
          .listen((event) {
        posts = [];
        likes = [];
        event.docs.forEach(
          (element) {
            if (!element.data()['isTrainee'] || uId == element.data()['uId']) {
              element.reference.collection('Likes').get().then((value) {
                likes.add(value.docs.length);
                emit(GetPostsLikesSuccessState());
              }).catchError((error) {});
              postsId.add(element.id);
              posts.add(
                PostModel.fromJson(element.data()),
              );
            }
          },
        );
      });
    } else {
      FirebaseFirestore.instance
          .collection('posts')
          .orderBy('dateTime')
          .snapshots()
          .listen((event) {
        posts = [];
        likes = [];
        event.docs.forEach(
          (element) {
            if (element.data()['isTrainee'] || uId == element.data()['uId']) {
              element.reference.collection('Likes').get().then((value) {
                likes.add(value.docs.length);
                emit(GetPostsLikesSuccessState());
              }).catchError((error) {});
              postsId.add(element.id);
              posts.add(
                PostModel.fromJson(element.data()),
              );
            }
          },
        );
      });
    }
  }

  void likePost(postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel!.uId)
        .set({'Like': true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LikePostErrorState());
    });
  }

  void submitSearch() {
    emit(SubmitSearchSuccess());
  }

  void subscribeChange() {
    isSubscribe = !isSubscribe;
    emit(SubscribeSuccess());
  }
}
