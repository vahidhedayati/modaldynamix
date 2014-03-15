package modaldynamix

import java.util.List;

class ModaldynamixController {

  def grailsApplication
	def getAjaxCall(String domain,String divId,String returnController,String templateType) {
		def returnResult
		
		if ((domain)&&(!domain.equals(''))){
			returnResult= domainList(domain)
		}
		
		[returnResult:returnResult,  divId: divId , returnController:returnController, templateType:templateType]
		
	}
	
	private List domainList(def domain) {
		grailsApplication?.domainClasses?.find { it.clazz.simpleName == currentController(domain) }?.clazz?.list()
	}
	
	private String currentController(String s) {
		s.substring(0,1).toUpperCase() + s.substring(1)
	}
	
}
