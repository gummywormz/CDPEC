package io.github.gummywormz;
import io.github.gummywormz.Section.HeaderFooter;
import io.github.gummywormz.RetrievedData;

/**
 * Represents a list of sections retrieved from the parser
 * @author Paul Alves
 */
class RetrievedSection
{

	var _hf:HeaderFooter;
	var _dList:List<RetrievedData>;
	
	/**
	 * Constructs a new retrievedsection
	 * @param	header Header of the section
	 * @param	footer Footer of the section
	 */
	public function new(header:String,footer:String) 
	{
		_hf = {header: header, footer:footer};
		_dList = new List<RetrievedData>();
	}
	
	/**
	 * Adds retrieved data to the section
	 * @param	r Data to add
	 */
	public function addData(r:RetrievedData)
	{
		_dList.add(r);
	}
	
	/**
	 * Returns the data list
	 * @return the data list
	 */
	public function returnList()
	{
		return _dList;
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
