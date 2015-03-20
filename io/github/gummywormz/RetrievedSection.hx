package io.github.gummywormz;
import io.github.gummywormz.Section.HeaderFooter;

/**
 * ...
 * @author Paul Alves
 */
class RetrievedSection
{

	var _hf:HeaderFooter;
	var _dList:List<RetrievedData>;
	
	public function new(hf:HeaderFooter) 
	{
		_hf = hf;
		_dList = new List<RetrievedData>();
	}
	
	public function addData(r:RetrievedData)
	{
		_dList.add(r);
	}
	
	public function returnList()
	{
		return _dList;
	}
	
	
}