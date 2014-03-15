package modaldynamix

class ModalDynamixTagLib {
  
	/*
	 * This loads in customised bootstrap.css and default bootstrap.js
	 * If your site already has these then no need to run, otherwise: 
	 *  
	 * <r:layoutResources />
	 * <g:loadbootstrap/>
	 * </head>
	 * 
	 *(notice the extra tag loadbootstrap above)
	 *In your main file to run in overall site 
	 *OR just call this on a specific gsp page if you have specific use
	 */
	 
	def loadbootstrap= {
		out << g.render(contextPath: pluginContextPath,template: 'loadbootstrap')
	}
	
	
	def showTopScript= {attrs,body->
		
		if (!attrs.divId) {
			throwTagError("Tag [loadShowScript] is missing required attribute [divId]")
		}
		
		if (!attrs.scriptName) {
			throwTagError("Tag [loadShowScript] is missing required attribute [scriptName]")
		}
		
		out << """
			<script type="text/javascript">
 	 		function ${attrs.scriptName}() {
 	 	 		\$('#${attrs.divId}').show();
 	 		}
 	 	    </script>
           """
	}

	def modalForm={attrs,body ->
		
		
		/*
		 * Attribute: close
		 * 
		 * This simply sets the close button value if not defined it defaults to X
		 * 
		 */
		
		if (!attrs.close) {
			attrs.close='X'
		}
		
		
		
		
		
		/*
		 *  Attribute: ModalTemplate
		 *  
		 *  This calls the actual modalbox required to process your action.
		 *  The supported plugin calls are:
		 *  
		 *   Iframe: '/modaldynamix/modaliframe'
		 *   Remote Form: '/modaldynamix/modalRemoteForm'
		 *   Self Posting: form: '/modaldynamix/modalSelfPostForm'
		 *   Basic Form: '/modaldynamix/modalbasic' 
		 *   
		 *   
		 *   If you have noticed the attribute is given a URI to the template within plugin, 
		 *   this of course can easily be overridden by your a call to a new modalbox call 
		 *   within your own application  
		 *  		 
		 */
		if (!attrs.modalTemplate) {
			throwTagError("Tag [modalForm] is missing required attribute [modalTemplate]")
		}
		
		
		/*
		 *  Attribute: ModalTemplatePage
		 *
		 *  This calls the form within your own grails application.
		 *  and depending on modalTemplate defined different types of
		 *  forms need to be provided.
		 *
		 *  so if you chose:
		 * =====================================================================
		 * 
		 *  modalTemplate='/modaldynamix/modalRemoteForm' (Using Remote Form)
		 *  
		 *  Your modalTemplatePage would call the default grails _forms.gsp
		 *  which contains just the fields for the form
		 *
		 *  modalTemplatePage="/myLocalDomain/form"
		 *
		 * =====================================================================
		 *  
		 *  modalTemplate='/modaldynamix/modaliframe' (using iframes) OR
		 *  modalTemplate='/modaldynamix/modalSelfPostForm' (using SelfPost Form):
		 *  
		 *  Your modalTemplatePage would call a template within your application
		 *  that contains a complete form with all tags for the form, in this example
		 *  I have called formSelfPost from the demo site which is a full form
		 *
		 *  modalTemplatePage="/myLocalDomain/formSelfPost"
		 * =====================================================================
		 *  
		 * Just remember this is a template provided by your own application
		 *   
		 */
		
		if (!attrs.modalTemplatePage) {
			throwTagError("Tag [modalForm] is missing required attribute [modalTemplate]")
		}
		
	
		/*
		 * Attribute: queryController
		 * This by default calls modaldynamix controller within this plugin
		 *
		 * It simply carries out calls to return information from your own application
		 * 
		 * You can override this by setting:
		 *  queryController='MyController'
		 * 
		 * 
		 */
		if (!attrs.queryController) {
			attrs.queryController="modaldynamix"
		}
		
		// This is the default Action for this field is getAjaxCall which resides in above default controller [OVERRIDABLE just set queryAction="myAction" ]
		/*
		 * Attribute: queryAction
		 * This by default calls getTemplate controller within this plugin
		 *
		 * It simply carries out calls to return templates from within your own application.
		 * These two actions basically show :
		 * 
		 * Your_DivId_[Display]
		 * Your_DivId_[Form]
		 * 
		 * Templates that you have already defined on the main page doing the call
		 *
		 * You can override this by setting:
		 *  queryAction='MyAction'
		 *
		 *
		 */
		
		if (!attrs.queryAction) { 
			attrs.queryAction="getTemplate"
		}
		
		
		
		// Specific checks for modalRemoteForm call within plugin:
		if (attrs.modalTemplate.equals('/modaldynamix/modalRemoteForm')) {
			VerifyRemoteFormAttrs(attrs)
		}
		
		// Specific configuration + checks for modaliframe call within plugin:
		if (attrs.modalTemplate.equals('/modaldynamix/modaliframe')) {
			verifyIframe(attrs)
			
			
		
		}	
		
		
		out << g.render(contextPath: pluginContextPath,template: attrs.modalTemplate, model: [attrs:attrs])
		
	}
	
	
	
	private void verifyIframe(attrs) {
		
		/*
		 * Attribute: modalJsTemplate
		 *
		 * ONLY REQUIRED IF: RemoteForm/modaliframe Template is defined
		 *
		 * This simply sets the value of js file to call on backend plugin
		 * which gets added to work with when user clicks close or form remotely actions
		 * + then closes.
		 *
		 */
		
		attrs.modalJsTemplate='/modaldynamix/modal-js'
		
		 
		/*
		 * Attribute: iController
		 * This by default calls modaldynamix controller within this plugin
		 *
		 * It simply carries out a call to the controller that will return your iframe form
		 * later put together to return a full url
		 * this plugin can display this form 
	
		 *
		 * You can override this by setting:
		 *  queryiController='MyController'
		 *
		 *
		 */
		if (!attrs.iController) {
			attrs.iController=attrs.queryController
		}
		
		
		
		/*
		 * Attribute: queryiAction
		 * This by default calls getiTemplate controller within this plugin
		 *
		 * It simply carries out calls to return templates from within your own application.
		 
		 *
		 * 
		 * Templates that you have already defined on the main page doing the call
		 *
		 * You can override this by setting:
		 *  queryiAction='MyAction'
		 *
		 *
		 */
		
		if (!attrs.iAction) {
			attrs.iAction="getiTemplate"
		}
		
		
		def g = new org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib()
		attrs.url=g.createLink(controller: ''+attrs.iController+'', action: ''+attrs.iAction+'', params:attrs, ,  absolute: 'true')
		
	}
	
	private void VerifyRemoteFormAttrs(attrs){
		
	
		
		/*
		 * Attribute: modalJsTemplate
		 *
		 * ONLY REQUIRED IF: RemoteForm/modaliframe Template is defined
		 *
		 * This simply sets the value of js file to call on backend plugin
		 * which gets added to work with when user clicks close or form remotely actions
		 * + then closes.
		 *
		 */
		
		attrs.modalJsTemplate='/modaldynamix/modal-js'
	  
	  /*
	   * Attribute: submitValue
	   *
	   * ONLY REQUIRED IF: RemoteForm Template is defined
	   *
	   * This simply sets the value for your submit value on the remote Form
	   *
	   */
	  if (!attrs.submitValue) {
		  attrs.submitValue="Submit"
	  }
	  
	  
	  /*
	   * Attribute: submitController
	   *
	   * ONLY REQUIRED IF: RemoteForm Template is defined
	   *
	   * Will throw an error if not set - this is your controller that needs to be called to post the form to
	   *
	   *
	   */
	  if (!attrs.submitController) {
		  throwTagError("Tag [modalForm] is missing required attribute [submitController]")
	  }
	  
	  /*
	   * Attribute: submitAction
	   *
	   * ONLY REQUIRED IF: RemoteForm Template is defined
	   *
	   * Will throw an error if not set - this is your action within the controller that needs to be called to post the form to
	   * Typically:
	   *
	   *  submitAction="save"
	   *
	   *  if _form has been called will be sufficient
	   *
	   *
	   */
	  if (!attrs.submitAction) {
		  throwTagError("Tag [modalForm] is missing required attribute [submitAction]")
	  }
	  
  }
	
}
