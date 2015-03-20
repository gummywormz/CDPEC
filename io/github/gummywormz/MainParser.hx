package io.github.gummywormz;
import io.github.gummywormz.Section.HeaderFooter;
/**
 * Main parser object
 * @author Paul Alves
 */

using StringTools;
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
		var lSplit = ~/\n?\r/;
		var list = lSplit.split(f);
		var dataList = new List<RetrievedSection>();
		var isSection = false;
		var section;
		for (e in list)
		{
			if (e.startsWith("@") || e.trim() == "" || e.startsWith("#")) { continue; }
			for (s in _sections)
			{
				if (s.getHeader() == e)
				{
					section = new RetrievedSection(new HeaderFooter(s.getHeader,s.getFooter));
					isSection = true;
					break;
				}
			}
		}
	}
}
