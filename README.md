modaldynamix 0.1
=======================


ModalDynamix is a Grails plugin which makes use of jquery, bootstrap and modalbox to load various types of forms  Self Posting,I Frame, Remote Forms and normal calls via ModalBox, upon trigger save or close depending on type of call, the underlying form is updated with new values without page refreshes.'
 
A common problem when it comes to forms within a website is having the ability to update preset values on the form without redirecting or opening up new tabs etc.
This plugin aims to help in the process of producing dynamic forms that sit on top of other forms that are then opened in a pop up modalbox and their 
actions update your underlying form without refreshing actual page.


# Not released as yet !

## Installation:
Add plugin Dependency :

	compile ":modaldynamix:0.1" 

Or via grails command line:

	grails install-plugin modaldynamix



## Getting started

### Modify views/layouts/main.gsp

your layouts main.gsp: (add jquery-ui,jquery + loadbootstrap)


		<g:layoutHead/>
		<g:javascript library="application"/>
		<g:javascript library="jquery"/>
		<g:javascript library="jquery-ui"/>	
		<r:layoutResources />
		<g:loadbootstrap/>		
	</head>
	
You will notice from a default installed application the extra jquery jquery-ui and <g:loadbootstrap/>		

If your site is already bootstrapped then no need to load that up.



### With above in place here are some examples on how to use this plugin:


## Example 1: Basic modalbox form
 
#### Opens a pop up modalbox form (your own local one) and upon submission the results refresh main page calling the form

https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/testBasicForm.gsp

--> feel free to use this page as your own template if you just require a basic call

		<g:genModalButton
		id="ModalDynamixBASIC"
		divId="MyBasicDiv1"
		title="Create New MyUser"
		value="Generate New MyUser Remote Form Example?"
		/>
			
		<div id="MyBasicDiv1">
		  <g:modalForm
		  id="ModalDynamixBASIC"
		  title="My Modal Title"
		  modalTemplate='/modaldynamix/modalbasic'
		  modalTemplatePage='/myLocalDomain/formBasic' 
		  />
		</div>
		
		  SOME HTML PAGE............<br/>
		  
		  Contains above button which kicks off a pop up form people fill it in, results takes over this page.





So what is going on above?

##### g:genModalButton 
loads up a button that triggers modalbox

		ID -> must match the ID of the id set further within the DIVS templates
		divId -> This is the divId put above your main form that contains the modalbox itself and the form within it
		title -> hover title of your new button
		value -> display text in the button
		
			
#### g:modalForm
Main DIV wrapping the call  'MyBasicDiv1'  [ the name must match divId label above (usually) in this case of a basic call maybe not ] 

		-> ID	Must match above href
		-> modalTemplate This must be left as is or overriden -	this loads up basic modal wrapper for your form below:
		-> modalTemplatePage This is the path to where your TEMPLATE file is containing the main form. orm must include all of the tags including action submit etc
		

This calls another page within this project: https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/myLocalDomain/_formBasic.gsp

--> feel free to use this form template as your own template if you just require a basic call



## Example 2: Basic modalbox form
		