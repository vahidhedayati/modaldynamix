package modaldynamix

import java.util.List;

class ModaldynamixController {

  def grailsApplication
  
  /*
   * Controller Action: getTemplate
   * 
   * This gets a domainListing of provided domain and produces the display and Form pages within plugin call
   *   	
   */
  def getTemplate(String domain,String divId,String returnController,String templateType,String fromPlugin) {
	  def returnResult
	  if ((domain)&&(!domain.equals(''))){
		  returnResult= domainList(domain)
	  }
	  [returnResult:returnResult,  divId: divId , returnController:returnController, templateType:templateType,fromPlugin:fromPlugin]
  }
	
  /*
   * Controller Action: getiTemplate
   * 
   * Simply makes a call back to your own application to load up a form for iframe calls
   *  
   */
  def getiTemplate(String modalTemplatePage,String fromPlugin) {
	  [modalTemplatePage:modalTemplatePage,fromPlugin:fromPlugin]
  }
	
  /*
   * domainList 
   * 
   * Does a search across available domains, if found it will list it and return results 
   * 
   */
  private List domainList(def domain) {
	  grailsApplication?.domainClasses?.find { it.clazz.simpleName == currentController(domain) }?.clazz?.list()
  }
	
  /*
   * used by above to produce uppercase,lowercase domain name so it can find it
   * 
   */
  private String currentController(String s) {
	  s.substring(0,1).toUpperCase() + s.substring(1)
  }
	
}
