package cdpec;
import cdpec.Restrictors;

/**
* Describes a header and footer for this section
* @param header The header / opening tag
* @param footer The footer / closing tag
*/
typedef HeaderFooter = 
{
	var header : String;
	var footer : String;
};

/**
* Describes a value
* @param name The name of the value
* @param restrictor The restrictor
*/
typedef ValueInfo = 
{
	var name : String;
	var restrictor : Restrictors;
};

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
		_valList = new List<ValueInfo>();
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
		_valList.add(val);
	}
	
	/**
	 * Returns the entire list of values
	 * @return the entire list of values
	 */
	public function returnList():List<ValueInfo>
	{
		return _valList;
	}
	
	/**
	 * Returns the header of this section
	 * @return the header of this section
	 */
	public function getHeader()
	{
		return _hf.header;
	}
	
	/**
	 * Returns the footer of this section
	 * @return the footer of this section
	 */
	public function getFooter()
	{
		return _hf.footer;
	}
	
}
