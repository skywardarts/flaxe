import flash.utils.getQualifiedClassName;
import flash.utils.getQualifiedSuperclassName;

class abstract
{
	public function abstract()
	{
		if(getQualifiedSuperclassName(this).substr(-8) == "abstract")
			throw new Error(getQualifiedClassName(this) + " is abstract and must be extended.");
	}
}