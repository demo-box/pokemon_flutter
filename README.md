# pokemon_flutter
精灵宝可梦flutter app

## 技术总结
Flutter中一切皆是Widget, CSS中常用的padding, flex, wrap, position等属性在Flutter中皆是Widget;Flutter有点像React, 有有状态Widget, 无状态Widget, 有build方法, 当调用setState时, build方法会执行.
### 创建Widget
#### 创建无状态Widget
```dart
class PokemonDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null
  }
}
```
#### 创建有状态Widget
```dart
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState()
  }
}

class HomePageState extends State<HomePage> {
  @override 
  initState() {
    super.initState()
    // 一般会在这里获取初始化数据
  }

  @override
  Widget build(BuildContext context) {
    return null
  }
}

// 通过调用setState来重新build
setState(() {

})
```

### 解析JSON字符串
一般API会返回JSON格式的数据，在JavaScript中，只需要调用JSON.parse, 就可以将JSON转为Object, 而在Dart中，则没有那么简单, 需要定义Model类. pokemon_flutter使用了https://javiercbk.github.io/json_to_dart/ 这个在线工具,自动根据json生成Model类(生成的Model类，可能会有错误，需要人工修改)

### 导航
使用Navigator可以实现导航
```
Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetail(pokemon: poke)));
```

### 比较重要的Widget
#### GridView
可以用来构建一个二维网格列表，属于可滚动Widget  
```dart
GridView.count(
  crossAxisCount: 2, // 两列
  children: <Widget>[]
)
``` 
#### Hero
Hero动画会在路由切换的时候，有一个共享的Widget在新旧路由间切换，由于共享的Widget在新旧路由页面上的位置、外观可能有所差异，所以在路由切换时会逐渐过渡
```dart
// HomePage
InkWell(
  onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetail(pokemon: poke)));
  },
  child: Hero(
    tag: poke.img,
    child: Card()
  )
)

// PokemonDetail
Align(
  alignment: Alignment.topCenter,
  child: Hero(
    tag: pokemon.img, 
    child: Container(
      height: 200.0,
      width: 200.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover, image: NetworkImage(pokemon.img),
        ),
      ),
    )
  ),
),
```

#### Stack和Positioned
Stack类似Web中的绝对定位, 可以通过Positioned来指定child的位置
```dart
Stack(
  children: <Widget>[
    Positioned(
       top: MediaQuery.of(context).size.height * 0.1,
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width - 20,
        left: 10.0,
        child: Card(),
    ),
    // 其它Widget
  ]
)
```

## 教程
https://www.youtube.com/watch?v=yeXJqZCiwTQ&feature=youtu.be
