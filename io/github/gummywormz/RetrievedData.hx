package io.github.gummywormz;
/**
 * Represents retrieved data
 * @author Paul Alves
 */
class RetrievedData
{

  var _name : String;
  var _type : String;
  var _value : String;

  public function new(name:String,type:String,value:String)
  {
    _name = name;
    _type = type;
    _value = value;
  }
  
  public function getName()
  {
    return _name;
  }
  
  public function getValueAsString()
  {
    return _value;
  }
  
  public function getTypeAsString()
  {
    return _type;
  }
  
  public function getValueAsType():Dynamic
  {
    if(_type=="String"){return _value;}
    if(_type=="Float"){return Std.parseFloat(_value);}
    if (_type == "Integer") { return Std.parseInt(_value); }
	return "Error";
  }
  
  

}
