package modaldynamix

import java.util.List;

class ModaldynamixController {
def contextPath
  def grailsApplication
	def getAjaxCall(String domain,String divId) {
		def returnResult= domainList(domain)
		println "-------------"+grailsApplication?.metadata['app.name']
		render(contextPath:"/"+grailsApplication?.metadata['app.name'] ,template: divId+'Display', model: [returnResult:returnResult,  divId: divId ])
	}
	
	private List domainList(def domain) {
		grailsApplication?.domainClasses?.find { it.clazz.simpleName == currentController(domain) }?.clazz?.list()
	}
	
	private String currentController(String s) {
		s.substring(0,1).toUpperCase() + s.substring(1)
	}
	
}
