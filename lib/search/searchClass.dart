class Search {
  String criteria;
  String category;
  String brand;
  String model;
  String year;
  String serie;
  String nextCriteria;
  Search({criteria,category,brand,model,year,serie,nextCriteria}){
    this.criteria=criteria;
    this.category=category;
    this.brand=brand;
    this.model=model;
    this.year=year;
    this.nextCriteria=nextCriteria;
  }
  factory Search.criteriaIsCategory(){
    return Search(
      criteria: "category",
      nextCriteria:"brand"
    );
  }
  factory Search.criteriaIsBrand({reqCategory}){
    return Search(
      criteria: "brand",
      category: reqCategory,
       nextCriteria:"model"
    );
  }
  factory Search.criteriaIsModel({reqCategory,reqBrand}){
    return Search(
      criteria: "model",
      category: reqCategory,
      brand: reqBrand,
       nextCriteria:"year"
    );
  }
}
