import 'package:app/entitis/CountryEntity.dart';
import 'package:app/entitis/EventEntity.dart';
import 'package:app/entitis/ForumEntity.dart';
import 'package:app/entitis/MessageEntity.dart';
import 'package:app/entitis/SettingsEntity.dart';
import 'package:app/entitis/enums/NotifyType.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

part 'RestClient.g.dart';

@RestApi(baseUrl: 'http://192.168.0.11:8080/api/v1/')
abstract class RestClient{
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  
  @POST("register")
  Future<void> register(@Query("uid")String uid, @Query("messageToken")String token);
  @POST("update")
  Future<void> update(@Query("uid")String uid, @Query("messageToken")String token);
  @POST("location/update")
  Future<void> locationUpdate(@Query("uid")String uid, @Query("latitude") double latitude, @Query("longitude") double longitude);
  @GET("forum")
  Future<List<ForumEntity>> getForums(@Query("uid")String uid);
  @GET("forum/{id}")
  Future<List<MessageEntity>> getForum(@Path("id")int id);
  @GET("history")
  Future<List<EventEntity>> getHistory(@Query("uid")String uid);
  @GET("events/active")
  Future<List<EventEntity>> getEvents();
  @GET("country/all")
  Future<List<CountryEntity>> findAll();
  @GET("settings")
  Future<SettingsEntity> findSettings(@Query("uid")String uid);
  @POST("saveSettings")
  Future<void> saveSettings(@Query("uid")String uid, @Query("notifyType")NotifyType? nType, @Query("minWarning")double? minWarning, @Query("country")int? country);
}
