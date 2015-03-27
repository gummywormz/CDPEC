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

  /**
   * Constructs new RetrievedData
   * @param	name Original name
   * @param	type Either String, Float, or Integer
   * @param	value The value as a string
   */
  public function new(name:String,type:String,value:String)
  {
    _name = name;
    _type = type;
    _value = value;
  }
  
  /**
   * Returns the name associated with this data
   * @return the name associated with this data
   */
  public function getName()
  {
    return _name;
  }
  
  /**
   * Returns the value of this data as a string
   * @return the value of this data as a string
   */
  public function getValueAsString()
  {
    return _value;
  }
  
  /**
   * Returns the data's type as a string
   * @return the data's type as a string
   */
  public function getTypeAsString()
  {
    return _type;
  }
  
  /**
   * Returns this data's value as its native type
   * @return this data's value as its native type
   */
  public function getValueAsType():Dynamic
  {
    if(_type=="String"){return _value;}
    if(_type=="Float"){return Std.parseFloat(_value);}
    if (_type == "Integer") { return Std.parseInt(_value); }
	return "Error";
  }
  
  

}
