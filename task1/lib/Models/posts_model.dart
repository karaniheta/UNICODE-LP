class PostsModel {
  String? context;
  String? type;
  String? sId;
  String? category;
  String? datePublished;
  String? description;
  String? image;
  String? name;
  String? prepTime;
  List<String>? recipeIngredient;
  List<RecipeInstructions>? recipeInstructions;
  String? recipeYield;
  String? totalTime;

  PostsModel(
      {this.context,
      this.type,
      this.sId,
      this.category,
      this.datePublished,
      this.description,
      this.image,
      this.name,
      this.prepTime,
      this.recipeIngredient,
      this.recipeInstructions,
      this.recipeYield,
      this.totalTime});

  PostsModel.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    type = json['@type'];
    sId = json['_id'];
    category = json['category'];
    datePublished = json['datePublished'];
    description = json['description'];
    image = json['image'];
    name = json['name'];
    prepTime = json['prepTime'];
    recipeIngredient = json['recipeIngredient'].cast<String>();
    if (json['recipeInstructions'] != null) {
      recipeInstructions = <RecipeInstructions>[];
      json['recipeInstructions'].forEach((v) {
        recipeInstructions!.add(new RecipeInstructions.fromJson(v));
      });
    }
    recipeYield = json['recipeYield'];
    totalTime = json['totalTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@context'] = this.context;
    data['@type'] = this.type;
    data['_id'] = this.sId;
    data['category'] = this.category;
    data['datePublished'] = this.datePublished;
    data['description'] = this.description;
    data['image'] = this.image;
    data['name'] = this.name;
    data['prepTime'] = this.prepTime;
    data['recipeIngredient'] = this.recipeIngredient;
    if (this.recipeInstructions != null) {
      data['recipeInstructions'] =
          this.recipeInstructions!.map((v) => v.toJson()).toList();
    }
    data['recipeYield'] = this.recipeYield;
    data['totalTime'] = this.totalTime;
    return data;
  }
}

class RecipeInstructions {
  String? type;
  String? image;
  String? name;
  String? text;

  RecipeInstructions({this.type, this.image, this.name, this.text});

  RecipeInstructions.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    image = json['image'];
    name = json['name'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['image'] = this.image;
    data['name'] = this.name;
    data['text'] = this.text;
    return data;
  }
}
