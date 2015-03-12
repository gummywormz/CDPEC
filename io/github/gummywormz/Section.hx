package io.github.gummywormz;
import io.github.gummywormz.CoreTypes.*;
	
/**
 * Describes a section of the file
 * @author Paul Alves
 */
class Section
{
	
	var _hf : HeaderFooter;
	var _valList : List<ValueInfo>;

	/**
	 * Constructs a new Section
	 * @param	hf The header and footer that identifies this section
	 */
	public function new(hf:HeaderFooter) 
	{
		setHeaderFooter(hf);
		_valList = new List<ValueInfo>;
	}
	
	/**
	 * Sets the header and footer for this section
	 * @param	hf HeaderFooter to set
	 */
	public function setHeaderFooter(hf:HeaderFooter)
	{
		_hf = hf;
	}
	
	/**
	 * Adds a value to the list of possible values
	 * @param	val The value to add
	 */
	public function addValue(val:ValueInfo)
	{
		_valList.add();
	}
	
	/**
	 * Returns the entire list of values
	 * @return the entire list of values
	 */
	public function returnList()
	{
		return _valList;
	}
	
}
