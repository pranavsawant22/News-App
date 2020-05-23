import 'dart:convert';

import 'package:newsapp/models/article.dart';
import 'package:http/http.dart' as http;
class Blogs {
  List<Article> news = [];

  Future<void> getNews() async {
    String url = "http://newsapi.org/v2/top-headlines?country=in&apiKey=d9e83e91039a4025bfebb2d02443820a";
    var response = await http.get(url);
    var js = jsonDecode(response.body);
    if (js['status'] == 'ok'){
      js['articles'].forEach((element){
        if (element['urlToImage']!=null && element['description']!=null){
           Article article = Article(
             title: element['title'],
             author: element['author'],
             description: element['description'],
             url: element['url'],
             urlToImage: element['urlToImage'],
             //publishedAt: element['publishedAt'],
             content: element['content'],
           );
           print("HI : ");
           print(article.url);
           news.add(article);
        }
      });
    }
  }
}

class NewsForCategorie {

  List<Article> news  = [];

  Future<void> getNewsForCategory(String category) async{

    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=d9e83e91039a4025bfebb2d02443820a";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],

            content: element["content"],
            url: element["url"],
          );
          news.add(article);
        }

      });
    }


  }


}