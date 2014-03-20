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
	 *
	 * <g:loadbootrap/> 
	 */
	 
	def loadbootstrap= {
		out << g.render(contextPath: pluginContextPath,template: 'loadbootstrap')
	}
	
	
	/*
	 * g:loadATemplate
	 * <g:loadATemplate fromPlugin="PLUGIN CONTAINING TEMPLATE" template="/path/to/and/call/template.gsp" 
	 * anything else just add it in those 2 are required
	 *  />

	 *	required:
	 *	fromPlugin="Plugin to call from" //can be left blank not tried for any results
	 *	template="as above"
	 *	
	 */
	
	def loadATemplate= { attrs,body->
		if (attrs.template&&attrs.fromPlugin) {
			out << g.render(plugin: attrs.fromPlugin,template: attrs.template, model:[params:attrs])
		}
	}
	
	/*
	 * g:getModalButton
	 * <g:getModalButton divId="something" id="MATCHIDSETFOR_modalForm_BELOW"  title="hover title" value="click my button"/> 
	 * 
	 * Loads up button that triggers your modalbox containing forms or whatever
	 * 
	 */
	def genModalButton= { attrs,body->
			
		/*
		 * This is the DivId that is defined further below on the main page
		 * must match that ID otherwise things won't work
		 * 
		 */
		if (!attrs.divId) {
			throwTagError("Tag [genModalButton] is missing required attribute [divId]")
		}


		/*
		 * This ID must match the ID of your DIV calls further down on the main page declaring these tags
		 * 
		 */
		if (!attrs.id) {
			throwTagError("Tag [genModalButton] is missing required attribute [id]")
		}
		
		/*
		 * title - sets the title of the modalbox link when hovering
		 * defaults to SET HOVER TITLE
		 */
		if (!attrs.title) {
			attrs.title='SET HOVER TITLE'
		}
		
		/*
		 * 
		 * This is the button value or tag explaining the button link
		 * Defaults to CLICK ME 
		 */
		if (!attrs.value) {
			
			attrs.value='CLICK ME'
		}

		out << g.render(contextPath: pluginContextPath,template: 'loadmodalbutton', model:[attrs:attrs])
	}
	

	
	
	/*
	 * modalForm call 
	 * ==========================
	 * 
	 * This carries out all the form control
	 * 
	 * 
	 * 
	 */
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
		 * Attribute: id
		 * This must be set to be the same value as defined in genModalButton: Id
		 */
		if (!attrs.id) {
			throwTagError("Tag [modalForm] is missing required attribute [id] (must be set to be the same value as defined in genModalButton: Id)")
		}
		
		
		
		
		
		// Specific checks for modalRemoteForm call within plugin:
		if (attrs.modalTemplate.equals('/modaldynamix/modalRemoteForm')) {
			VerifyRemoteFormAttrs(attrs)
		}
		
		// Specific configuration + checks for modaliframe call within plugin:
		if (attrs.modalTemplate.equals('/modaldynamix/modaliframe')) {
			verifyIframe(attrs)
		}	
		
		// Specific configuration + checks for modalSelfPostForm call within plugin:
		if (attrs.modalTemplate.equals('/modaldynamix/modalSelfPostForm')) {
			verifyGeneral(attrs)
		}
		
		out << g.render(contextPath: pluginContextPath,template: attrs.modalTemplate, model: [attrs:attrs])
		
	}
	
	
	private void verifyGeneral(attrs) {
		
		/*
		 * Attribute: divId
		 * This is the div id value that contains your calls below, so its pure name
		 */
		if (!attrs.divId) {
			throwTagError("Tag [modalForm] is missing required attribute [divId] ( div id value that contains your calls below")
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
		 * Attribute: formId
		 * This by default will set it as [ID]FORM
		 *
		 * Its the form name/id
		 *
		 * You can override this by setting:
		 *  queryiController='MyController'
		 *
		 *
		 */
		
		if (!attrs.formId) {
			attrs.formId="${attrs.id}-FORM"
		}
		
		
		/*   Attribute: returnController
		 * 
		 *  This is the current controller that is serving this taglib call
		 *  So where ever this call is being made from get the controller that is being used to serve it
		 *  		 
		 */
		if (!attrs.returnController) {
			throwTagError("Tag [modalForm] is missing required attribute [returnController] - current controller that is serving this taglib call")
		}
		
		
		
	}
	
	private void verifyIframe(attrs) {
		
		verifyGeneral(attrs)
		 
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
		
		if (!attrs.url) {
			def g = new org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib()
			attrs.url=g.createLink(controller: ''+attrs.iController+'', action: ''+attrs.iAction+'', params:attrs, ,  absolute: 'true')
		}	
		
	}
	
	private void VerifyRemoteFormAttrs(attrs){
		verifyGeneral(attrs)
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
