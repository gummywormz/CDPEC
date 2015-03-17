package io.github.gummywormz;
/**
 * Main parser object
 * @author Paul Alves
 */

 Using StringTools;
class MainParser
{
	
	var _sections : List<Section>;

	public function new() 
	{
		_sections = new List<Section>();
	}
	
	/**
	 * Adds a section to this parser
	 * @param	s The section to add
	 */
	public function addSection(s:Section)
	{
		_sections.add(s);
	}

	public function parseFile(f:String)
	{
		var lSplit = ~/\n?\r;
		var list = lSplit.split(f);
		for (e in f)
		{
			if (e.startsWith("@") || e.trim()=="")
		}
	}
}
