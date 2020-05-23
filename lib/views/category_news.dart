import 'package:flutter/material.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/article.dart';
import 'package:newsapp/views/article_view.dart';
class CategoryNewsSelected extends StatefulWidget {
  final String Categorynewshome;
  CategoryNewsSelected({this.Categorynewshome});
  @override
  _CategoryNewsSelectedState createState() => _CategoryNewsSelectedState();
}
bool _loading=false;
class _CategoryNewsSelectedState extends State<CategoryNewsSelected> {
  List<Article> articlemodel = new List<Article>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{
    NewsForCategorie newsClass = NewsForCategorie();
    await newsClass.getNewsForCategory(widget.Categorynewshome);
    articlemodel = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.share,))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body:SingleChildScrollView(
        child: Container(
          child:Column(
            children: <Widget>[
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

              ),
            ],

          ),
        ),
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
      child: _loading?Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
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

                  ),),
                SizedBox(height: 20,),
              ],
            )
        ),
      ),
    );
  }

}