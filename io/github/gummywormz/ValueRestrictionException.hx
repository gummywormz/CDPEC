package io.github.gummywormz;

/**
 * Represents an error while trying to parse values that fail a Restrictor
 * @see io.github.gummywormz.Restrictors
 * @author Paul Alves
 */
class ValueRestrictionException
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