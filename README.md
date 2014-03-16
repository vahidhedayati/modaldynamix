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
 
###### Opens a pop up modalbox form (your own local one) and upon submission the results refresh main page calling the form

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
		-> modalTemplate This must be left as is or overriden -	this loads up basic modal wrapper
		-> modalTemplatePage This is the path to where your TEMPLATE file is which contains the form that is being called. 
		

https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/myLocalDomain/_formBasic.gsp

--> feel free to use this form template as your own template if you just require a basic call



## Example 2: Self Post Form 


###### Opens a pop up modalbox form (your own local one) and upon submission the results refresh a form field within the underlying form.

It is referred to as selfposting since it uses java scripts to post the results back to itself, 
regardless of outcome upon completion a CloseModal java script is called which
simply closes the modalbox and sends the updated listing of the domain class in question back to whatever 
form of display was being used for that form element. Since that is actually set by you.

https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/testSelfPostForm.gsp

--> feel free to use this page as your own template if you just require a self posting form - 

This should be good for all sorts of form actions including ckeditor items within pop up form. It will not be good for FILE UPLOADS - please refer to iframe model for this feature.


	<g:genModalButton
		id="ModalDynamixSPECIALFORM"
		divId="MySelfPostDiv1"
		title="Create New MyUser"
		value="Generate New MyUser?"
	/>
	
	  <div id="MySelfPostDiv1">
		<g:render template='/testdynamix/MySelfPostDivForm' />
	  </div>
	  
	  <h1>ACTUAL FORM</h1>
	  
	  <g:form name="mynextForm" action="step2">
	  
	   	<div id="MySelfPostDiv">
	  		<g:render template='/testdynamix/MySelfPostDivDisplay' />
	  	</div>
	  	
	  </g:form>
  
 

So what is going on above?

##### g:genModalButton 
loads up a button that triggers modalbox

		ID -> must match the ID of the id set further within the DIVS templates
		divId -> This is the divId put above your main form that contains the modalbox itself and the form within it
		title -> hover title of your new button
		value -> display text in the button
		
			
#### MySelfPostDiv1
Main DIV wrapping the call  'MySelfPostDiv1'  [ the name must match divId label above (usually) in this case of a basic call maybe not ] 
This now calls a template within my example project the project which is making the call, this is the taglib call back to this plugin but needs to be in a template.
The reason is that the plugin later on calls this page to store its content for reuse of same button calls.

https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MySelfPostDivForm.gsp

So lets take a look inside this file what is going on here?


	<g:modalForm
	 
	  id="ModalDynamixSELFPOST"
	  formId="MyForm"
	 
	  title="My Modal Title"
	
	  divId="MySelfPostDiv"
	  returnController="testdynamix"
	 
	 
	  modalTemplatePage="/myLocalDomain/formSelfPost"
	  modalTemplate='/modaldynamix/modalSelfPostForm'
	 
	  domain="grails.modaldx.test.MyLocalDomain"
	  />


#### g:modalForm

		id -> must match the ID of the id set further within the DIVS templates
		
		formId -> must be the name you wish to give your actual form must be unique
		 
		title -> The title for your modal page
		
		divId -> This must be the mainDiv containing yet another template which actually displays the field within your form
		
		returnController -> The current controller calling this page and contains the templates for your main divs on the page
		
		modalTemplatePage ->a template within your local project that contains a complete form  
		https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/myLocalDomain/_formSelfPost.gsp
		
		modalTemplate -> This is the template within the plugin to call must match the above name if you are using selfPost method, 
		You can write your own and override the value
		
		domain -> Full path.domainName to access the domain that is in question or being updated, it simply does a listing and returns list 
		on your final div call to the Display file as returnResult:
		https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MySelfPostDivDisplay.gsp
		
			from="${returnResult ?:.....
		
	  	  
		  



#### g:modalForm flexibility 

Take a look at these two pages,it shows you that if you wanted to make the process even more dynamic by assigning form actions controllers from the main page doing the calls:
 
https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MySelfPostDivForm-morefields.gsp

https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/myLocalDomain/_formSelfPost-morefields.gsp

	
	  submitController="MyLocalDomain"
	  submitAction="save"
	  submitValue="Save Modal Form and update existing form no refreshing"


The above could be added and the form in question then referes to them, possibilities are endless you could add a further value here and make this some template that opens up and then reuse the form by adding all of the above plus a tweaked new value that opens up this template.



For all the files related to selfposting:
		
		
https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MySelfPostDivDisplay.gsp		

https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MySelfPostDivForm.gsp

https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/myLocalDomain/_formSelfPost.gsp

--> feel free to use this form template as your own template if you just require a self posting form

The Display Page is your basic page.






 
		