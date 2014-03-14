package modaldynamix

class ModalDynamixTagLib {
  
	/*
	 * This loads in customised bootstrap.css and default bootstrap.js
	 * If your site already has these then no need to run, otherwise: 
	 *  
	 * <r:layoutResources />
	 * <g:loadboostrap/>
	 * </head>
	 * 
	 *(notice the extra tag loadboostrap above)
	 *In your main file to run in overall site 
	 *OR just call this on a specific gsp page if you have specific use
	 */
	 
	def loadbootstrap= {
		out << g.render(contextPath: pluginContextPath,template: 'loadbootstrap')
	}

	def modalForm={attrs,body ->
		
		if (!attrs.formType) { 
			attrs.formType='modalRemoteForm'
		}	
		if (!attrs.close) {
			attrs.close='X'
		}
		out << g.render(contextPath: pluginContextPath,template: attrs.modalTemplate, model: [attrs:attrs])
		
	}
	

	
}
