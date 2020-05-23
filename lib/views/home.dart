import 'package:flutter/cupertino.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/main.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/article.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/helper/news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapp/views/article_view.dart';
import 'package:newsapp/views/category_news.dart';
import 'package:flutter_tts/flutter_tts.dart';
class MyHomePage extends StatefulWidget {
  @override

  _MyHomePageState createState() => _MyHomePageState();

}
int count=0;
bool flag = true;
final FlutterTts flutterTts = FlutterTts();

String h = "us";
class _MyHomePageState extends State<MyHomePage> {

  List<CategoryModel> categories = new List<CategoryModel>();
 List<Article> articlemodel = new List<Article>();
 bool _loading = true;


 @override
   void initState(){
    super.initState();
    categories = getCategory();
    get_News();
  }
  get_News() async{
Blogs newsClass = Blogs();
await newsClass.getNews();
articlemodel = newsClass.news;
setState(() {
  _loading = false;
});
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Stay ',
            style:TextStyle(
              fontSize: 28,
              fontFamily: 'Banger',
              letterSpacing: 2.0,
              color: Colors.black
            )),
            Text('Updated',
              style: TextStyle(
                fontFamily: 'Pacifico',
                letterSpacing: 2.0,
                color: Colors.blueAccent,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),

      body: _loading?Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ):
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[

              Container(
                height: 90,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                  return Category(
                    imageUrl: categories[index].imageUrl,
                    CategoryName: categories[index].CategoryName,
                  );
                    }),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(itemCount: articlemodel.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context,index){
                  return BlogTile(
                    news_img: articlemodel[index].urlToImage,
                    title: articlemodel[index].title,
                    desc: articlemodel[index].description,
                    url: articlemodel[index].url,
                  );
                },),

              )
            ],

          ),
        ),
      ),

    );
  }
}
class Category extends StatelessWidget {
  final String imageUrl,CategoryName;
  Category({this.imageUrl,this.CategoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
onTap: ()=>{
  Navigator.push(context,MaterialPageRoute(
      builder: (context)=>CategoryNewsSelected(Categorynewshome: flag?CategoryName:h,)
  ))
},
      child: Container(
        margin: EdgeInsets.all(4),
        child:Stack(
          children: <Widget>[
            ClipRRect(borderRadius: BorderRadius.circular(13),

                child: CachedNetworkImage(imageUrl: imageUrl,height: 80,width: 120,fit: BoxFit.cover,filterQuality: FilterQuality.low,)),
            Container(
              height: 80,width: 120,
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.black38,

              ) ,
              alignment: Alignment.center,
              child: Text(CategoryName,
              style: TextStyle(
                color:Colors.white,

              ),),
            )

          ],

        )
      ),
    );
  }
}
class BlogTile extends StatelessWidget {
  final news_img,title,desc,url;
  BlogTile({@required this.news_img,@required this.title,@required this.desc,@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>{
        Navigator.push(context,MaterialPageRoute(
            builder: (context)=>ArticleView(postUrl: url)
        ))
      },
      child: Container(
padding: EdgeInsets.symmetric(horizontal: 9),
        child:Column(
          children: <Widget>[
            SizedBox(height: 7,),
            ClipRRect(
              child: Image.network(news_img),
              borderRadius: BorderRadius.circular(9),
            ),

            Text(title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20

            ),),
            Text(desc,
            style: TextStyle(
              color: Colors.black38

            ),
            ),
FlatButton(onPressed: ()=>{
  _speak(desc),
}, child: Text('To Listen')),

            SizedBox(height: 20),
          ],
        )
      ),
    );
  }
Future _speak(String s) async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(s);
}
}
