package cdpec;

/**
 * Represents an error while parsing the file
 * @author Paul Alves
 */
class ParserException
{

var _error : String;
	
	/**
	 * Constructs a new exception
	 * @param	msg The message to throw
	 */
	public function new(msg:String) 
	{
		_error = msg;
	}
	
	/**
	 * Returns the error message associated with this exception
	 * @return the error message
	 */
	public function getMessage()
	{
		return _error;
	}
	
}