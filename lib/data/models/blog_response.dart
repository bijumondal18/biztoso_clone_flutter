sealed class TitledRow {}

class HeaderRow extends TitledRow {
  final String title;

  HeaderRow(this.title);
}

class BlogRow extends TitledRow {
  final BlogContent blog;

  BlogRow(this.blog);
}

/// actual response model
///
class BlogResponse {
  String? message;
  Result? result;

  BlogResponse({this.message, this.result});

  BlogResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result = json['result'] != null
        ? new Result.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  List<BlogContent>? marketing;
  List<BlogContent>? technologyInnovation;
  List<BlogContent>? lifestyle;
  List<BlogContent>? inspirationPersonalGrowth;
  List<BlogContent>? test;
  List<BlogContent>? sampleText;

  Result({
    this.marketing,
    this.technologyInnovation,
    this.lifestyle,
    this.inspirationPersonalGrowth,
    this.test,
    this.sampleText,
  });

  Result.fromJson(Map<String, dynamic> json) {
    if (json['Marketing'] != null) {
      marketing = <BlogContent>[];
      json['Marketing'].forEach((v) {
        marketing!.add(new BlogContent.fromJson(v));
      });
    }
    if (json['Technology & Innovation'] != null) {
      technologyInnovation = <BlogContent>[];
      json['Technology & Innovation'].forEach((v) {
        technologyInnovation!.add(new BlogContent.fromJson(v));
      });
    }
    if (json['Lifestyle'] != null) {
      lifestyle = <BlogContent>[];
      json['Lifestyle'].forEach((v) {
        lifestyle!.add(new BlogContent.fromJson(v));
      });
    }
    if (json['Inspiration & Personal Growth'] != null) {
      inspirationPersonalGrowth = <BlogContent>[];
      json['Inspiration & Personal Growth'].forEach((v) {
        inspirationPersonalGrowth!.add(new BlogContent.fromJson(v));
      });
    }
    if (json['test'] != null) {
      test = <BlogContent>[];
      json['test'].forEach((v) {
        test!.add(new BlogContent.fromJson(v));
      });
    }
    if (json['sample text'] != null) {
      sampleText = <BlogContent>[];
      json['sample text'].forEach((v) {
        sampleText!.add(new BlogContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.marketing != null) {
      data['Marketing'] = this.marketing!.map((v) => v.toJson()).toList();
    }
    if (this.technologyInnovation != null) {
      data['Technology & Innovation'] = this.technologyInnovation!
          .map((v) => v.toJson())
          .toList();
    }
    if (this.lifestyle != null) {
      data['Lifestyle'] = this.lifestyle!.map((v) => v.toJson()).toList();
    }
    if (this.inspirationPersonalGrowth != null) {
      data['Inspiration & Personal Growth'] = this.inspirationPersonalGrowth!
          .map((v) => v.toJson())
          .toList();
    }
    if (this.test != null) {
      data['test'] = this.test!.map((v) => v.toJson()).toList();
    }
    if (this.sampleText != null) {
      data['sample text'] = this.sampleText!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BlogContent {
  String? sId;
  String? category;
  String? createdAt;
  String? title;
  String? summary;
  String? blogImage;

  BlogContent({
    this.sId,
    this.category,
    this.createdAt,
    this.title,
    this.summary,
    this.blogImage,
  });

  BlogContent.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    createdAt = json['createdAt'];
    title = json['title'];
    summary = json['summary'];
    blogImage = json['blog_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category'] = this.category;
    data['createdAt'] = this.createdAt;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['blog_image'] = this.blogImage;
    return data;
  }
}
