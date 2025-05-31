validateForm(String val , int min , int max){
  if(val.isEmpty){
    return " you can not enter empty values";
  }else if(val.length < min){
    return "your input can not be less than $min";
  }else if(val.length > max){
    return "your input can not be greater than $max";
  }

}