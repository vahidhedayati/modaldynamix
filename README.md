modaldynamix 0.5
=======================


ModalDynamix is a Grails plugin which makes use of jquery, bootstrap and modalbox to load various types of forms  Self Posting,I Frame, Remote Forms and normal calls via ModalBox, upon trigger save or close depending on type of call, the underlying form is updated with new values without page refreshes.'
 
A common problem when it comes to forms within a website is having the ability to update preset values on the form without redirecting or opening up new tabs etc.
This plugin aims to help in the process of producing dynamic forms that sit on top of other forms that are then opened in a pop up modalbox and their 
actions update your underlying form without refreshing actual page.

## Installation:
Add plugin Dependency :
```groovy
	compile ":modaldynamix:0.5" 
```




## Getting started

### 2.4+ grails assets based apps how to:

[example 2.4 site](https://github.com/vahidhedayati/testmodaldynamix)

```
grails create-app testmodaldynamix

vi grails-app/conf/BuildConfig.groovy  add:

 compile ":modaldynamix:0.5"

grails refresh-depenedencies

grails create-domain-class MyLocalDomain

vi grails-app/domain/testmodaldynamix/MyLocalDomain.groovy 

package testmodaldynamix

class MyLocalDomain {
	String myUsers
    static constraints = {
    }
	String toString() { "$myUsers"}
}

grails generate-all *

Now refer to the example site above and the controllers / views for :

grails-app/controllers/testmodaldynamix/TestdynamixController.groovy 
package testmodaldynamix

class TestdynamixController {

	def index() { 
		
	}
	
    def testRemoteForm() {}
	def testIFrame() {}
		
	def testSelfPostForm() { }
	def testBasicForm() { }
}


ls -l grails-app/views/testdynamix/

-rw-rw-r-- 1 vahid vahid 1.1K Aug 13 09:04 1index.gsp
-rw-rw-r-- 1 vahid vahid  235 Aug 13 09:04 index.gsp
-rw-rw-r-- 1 vahid vahid  200 Aug 13 09:04 _MyDivDisplay.gsp
-rw-rw-r-- 1 vahid vahid  559 Aug 13 09:04 _MyDivForm.gsp
-rw-rw-r-- 1 vahid vahid  165 Aug 13 09:04 _MyIframeDivDisplay.gsp
-rw-rw-r-- 1 vahid vahid  522 Aug 13 09:04 _MyIframeDivForm.gsp
-rw-rw-r-- 1 vahid vahid 1.2K Aug 13 09:04 _MySelfPostDivDisplay.gsp
-rw-rw-r-- 1 vahid vahid  377 Aug 13 09:04 _MySelfPostDivForm.gsp
-rw-rw-r-- 1 vahid vahid  531 Aug 13 09:04 _MySelfPostDivForm-morefields.gsp
-rw-rw-r-- 1 vahid vahid 1.9K Aug 13 09:04 testBasicForm.gsp
-rw-rw-r-- 1 vahid vahid 2.9K Aug 13 09:04 testIFrame.gsp
-rw-rw-r-- 1 vahid vahid 3.0K Aug 13 09:04 testRemoteForm.gsp
-rw-rw-r-- 1 vahid vahid 2.6K Aug 13 09:04 testSelfPostForm.gsp

```

With above in place the example site should work -

In order to get this all working I have manually hacked in jquery-ui in 2.4 asset based apps

It should just work with 2.4 so long as you call it correctly as per examples/documentation. No reason to add any extra plugins to get it working under 2.4







### Modify views/layouts/main.gsp  (Pre 2.4 grails resources based applications)

your layouts main.gsp: (add jquery-ui,jquery + loadbootstrap)

```gsp
<g:layoutHead/>
<g:javascript library="application"/>
<g:javascript library="jquery"/>
<g:javascript library="jquery-ui"/>	
<r:layoutResources />
<g:loadbootstrap/>
</head>
```

You will notice from a default installed application the extra jquery jquery-ui and <g:loadbootstrap/>

If your site is already bootstrapped then no need to load that up.


Please refer to [Example site](https://github.com/vahidhedayati/grails-modaldx-test) to see this being used and where all the below examples were taken from.

### With above in place here are some examples on how to use this plugin:

## Version info
```
0.5 	Tidy up removal of 0.4 experiment, updates to bring in line with assets based 2.4 based sites.
0.4		Experiment to get rid of rendering issues with resources based plugin call - not worked.
0.3 	btn-block removed from button generation
0.2 	Issues with templates from within plugins, new fields fromPlugin="template_from_within_plugin" added 
0.1 	Release
```

# Real life examples 
try out [mailinglist|http://grails.org/plugin/mailinglist]  Installing this plugin into an existing project, then once instructions followed the buttons within contactclients.gsp are all driven by this plugin.
There are upload file CSV, create template using Ckeditor and standard form update via remote form examples provided. Results displayed to end project via the plugin so the example DivIDFORM pages all have extra fromPlugin field defined.
 

# Example 1: Basic modalbox form
 
###### Opens a pop up modalbox form (your own local one) and upon submission the results refresh main page calling the form

[testBasicForm.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/testBasicForm.gsp)
```gsp
<g:genModalButton
id="ModalDynamixBASIC"
divId="MyBasicDiv1"
style='btn btn-success'
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
  
```

So what is going on above?

##### g:genModalButton 
loads up a button that triggers modalbox
```
ID -> must match the ID of the id set further within the DIVS templates
divId -> This is the divId put above your main form that contains the modalbox itself and the form within it
title -> hover title of your new button
value -> display text in the button
```
	
#### g:modalForm
Main DIV wrapping the call  'MyBasicDiv1'  [ the name must match divId label above (usually) in this case of a basic call maybe not ] 
```
-> ID	Must match above href
-> modalTemplate This must be left as is or overriden -	this loads up basic modal wrapper
-> modalTemplatePage This is the path to where your TEMPLATE file is which contains the form that is being called. 

```
[_formBasic.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/myLocalDomain/_formBasic.gsp)

--> feel free to use this form template as your own template if you just require a basic call



# Example 2: Self Post Form 


###### Opens a pop up modalbox form (your own local one) and upon submission the results refresh a form field within the underlying form.

It is referred to as selfposting since it uses java scripts to post the results back to itself, 
regardless of outcome upon completion a CloseModal java script is called which
simply closes the modalbox and sends the updated listing of the domain class in question back to whatever 
form of display was being used for that form element. Since that is actually set by you.

[testSelfPostForm.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/testSelfPostForm.gsp)

This should be good for all sorts of form actions including ckeditor items within pop up form. It will not be good for FILE UPLOADS - 
please refer to iframe example for this feature.

```gsp
<g:genModalButton
  id="ModalDynamixSELFPOST"
  divId="MySelfPostDiv1"
  style='btn btn-primary'
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
```  
 

So what is going on above?

##### g:genModalButton 
loads up a button that triggers modalbox
```
ID -> must match the ID of the id set further within the DIVS templates
divId -> This is the divId put above your main form that contains the modalbox itself and the form within it
title -> hover title of your new button
value -> display text in the button
```
	
#### MySelfPostDiv1
Main DIV wrapping the call  'MySelfPostDiv1'  [ the name must match divId label below in g:genModalButton call ] 
This now calls a template within my example project the project which is making the call, this is the taglib call back to this plugin but needs to be in a template.
The reason is that the plugin later on calls this page to store its content for reuse of same button calls.

[_MySelfPostDivForm.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MySelfPostDivForm.gsp)

So lets take a look inside this file what is going on here?

```gsp
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
```

#### g:modalForm
```
id -> must match the ID of the id set further within the DIVS templates

formId -> must be the name you wish to give your actual form must be unique
 
title -> The title for your modal page

divId -> This must be the mainDiv containing yet another template which actually displays the field within your form

returnController -> The current controller calling this page and contains the templates for your main divs on the page

modalTemplatePage ->a template within your local project that contains a complete form
```
  
[_formSelfPost.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/myLocalDomain/_formSelfPost.gsp)

```
modalTemplate -> This is the template within the plugin to call must match the above name if you are using selfPost method, 
You can write your own and override the value

domain -> Full path.domainName to access the domain that is in question or being updated, it simply does a listing and returns list 
on your final div call to the Display file as returnResult:
```

[_MySelfPostDivDisplay.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MySelfPostDivDisplay.gsp)

```
from="${returnResult ?:.....

```
  

### MySelfPostDiv our Final Div
This is within our main form on this page and contains a render template to /testdynamix/MySelfPostDivDisplay.

So imagine you have your form to make this work, you take out the segment in the form that is to be updated and put it in its own template file,
 the naming as above all match the DivId name given to the form and ends with Display

What is in this file?

[_MySelfPostDivDisplay.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MySelfPostDivDisplay.gsp)

```gsp
<label>Field2: auto updated</label>
<g:select from="${returnResult ?: grails.modaldx.test.MyLocalDomain.list()}" id="myfield" name="mynextfield"/>
 </div>
```

It is just a simple select element with its tags etc. the only difference the from value has been amended to include returnResult :? and rest as was...




#### g:modalForm flexibility 

Take a look at these two pages,it shows you that if you wanted to make the process even more dynamic by assigning form actions controllers from 
the main page doing the calls:
 
[_MySelfPostDivForm-morefields.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MySelfPostDivForm-morefields.gsp)

[_formSelfPost-morefields.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/myLocalDomain/_formSelfPost-morefields.gsp)

```	
  submitController="MyLocalDomain"
  submitAction="save"
  submitValue="Save Modal Form and update existing form no refreshing"
```

The above could be added and the form in question then refers to them, possibilities are endless you could add a further 
value here and make this some template that opens up and then reuse the form by adding all of the above plus a tweaked new value that opens up this template.





For all the files related to self posting example refer to:

[testSelfPostForm.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/testSelfPostForm.gsp)
[_MySelfPostDivDisplay.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MySelfPostDivDisplay.gsp)
[_MySelfPostDivForm.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MySelfPostDivForm.gsp)
[_formSelfPost.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/myLocalDomain/_formSelfPost.gsp)

--> feel free to use this form template as your own template if you just require a self posting form




# Example 3: Remote Form Function

From what I understand this is soon to be the past, so maybe this will be revisited for grails 2.4

This is quite similar to above but actual calls on g:remoteForm functionality and does require for you to provide more 
fields within the g:modalForm tag as you will see in this example.

[testRemoteForm.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/testRemoteForm.gsp)

This should be good for all sorts of form actions including ckeditor items within pop up form. It will not be good for FILE UPLOADS -
 please refer to iframe example for this feature.
 
```gsp
<g:genModalButton
id="ModalDynamixSPECIALFORM"
divId="MyDiv1"
style='btn btn-danger'
title="Create New MyUser"
value="Generate New MyUser?"
/>
	
<div id="MyDiv1">
   <g:render template='/testdynamix/MyDivForm' />
</div>

<h1>ACTUAL FORM</h1>
	 
<g:form name="mynextForm" action="step2">

<div id="MyDiv">
  <g:render template='/testdynamix/MyDivDisplay' />
</div>
	
</g:form>
```
##### g:genModalButton 
loads up a button that triggers modalbox
```
ID -> must match the ID of the id set further within the DIVS templates
divId -> This is the divId put above your main form that contains the modalbox itself and the form within it
title -> hover title of your new button
value -> display text in the button
style -> css style you wish to set the button - above exmaples use bootstrap btn btn-{type} values..
```


	
#### MyDiv1
Main DIV wrapping the call  'MyDiv1'  [ the name must match divId label in g:genModalButton call] 
This now calls a template within my example project the project which is making the call, this is the taglib call back to this plugin but needs to be in a template.
The reason is that the plugin later on calls this page to store its content for reuse of same button calls.

[_MyDivForm.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MyDivForm.gsp)

So lets take a look inside this file what is going on here?
```gsp
<g:modalForm
  id="ModalDynamixSPECIALFORM"
  formId="MyRemoteForma"
  title="My Modal Title"
 
  submitController="MyLocalDomain"
  submitAction="save"
  submitValue="Save Modal Form and update existing form no refreshing"
 
  divId="MyDiv"
  returnController="testdynamix"
  close="XX"
  modalTemplatePage="/myLocalDomain/form"
  modalTemplate='/modaldynamix/modalRemoteForm'
  domain="grails.modaldx.test.MyLocalDomain"
  />
```

#### g:modalForm
```
id -> must match the ID of the id set further within the DIVS templates

formId -> must be the name you wish to give your actual form must be unique
 
title -> The title for your modal page

divId -> This must be the mainDiv containing yet another template which actually displays the field within your form

returnController -> The current controller calling this page and contains the templates for your main divs on the page

modalTemplatePage ->a template within your local project that contains a complete form
``` 

[_form.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views//myLocalDomain/_form.gsp)
```
modalTemplate -> This is the template within the plugin to call must match the above name if you are using modalRemoteForm method, 
You can write your own and override the value

domain -> Full path.domainName to access the domain that is in question or being updated, it simply does a listing and returns list 
on your final div call to the Display file as returnResult:
```
[_MyDivDisplay.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MyDivDisplay.gsp)

```
from="${returnResult ?:.....

submitController -> The controller that will process your form being called by RemoteForm 
submitAction	-> The action from this controller
submitValue 	-> The value to show in the submit value of the RemoteForm
  
```

### MyDiv our Final Div
This is within our main form on this page and contains a render template to /testdynamix/MDivDisplay.

So imagine you have your form to make this work, you take out the segment in the form that is to be updated and put it in its own template file,
 the naming as above all match the DivId name given to the form and ends with Display

What is in this file?

[_MyDivDisplay.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MyDivDisplay.gsp)

<label>Field2: auto updated</label>
 	<g:select from="${returnResult ?: grails.modaldx.test.MyLocalDomain.list()}" id="myfield" name="mynextfield"/>
 </div>

It is just a simple select element with its tags etc. the only difference the from value has been amended to include returnResult :? and rest as was...

 

For all the files related to RemotForm Call refer to:


[testRemoteForm.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/testRemoteForm.gsp)
[_MyDivDisplay.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MyDivDisplay.gsp)
[_MyDivForm.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MyDivForm.gsp)
[_form.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/myLocalDomain/_form.gsp)

--> feel free to use this form template as your own template if you just require a remote form functionality to your existing form








# Example 4: IFrame form call 
##### Good for forms that will be doing file uploads since its a full http call to your template which is loaded up in div1
When the user clicks close on top/bottom of the modal box, closeModal java script is triggered which then updates the underlying form with new value  


[testIFrame.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/testIFrame.gsp)
 

This should be good for all sorts of form actions including ckeditor items within pop up form. It will not be good for FILE UPLOADS -
 please refer to iframe example for this feature.
```gsp 
<g:genModalButton 
id="ModalDynamixSPECIALFORM"
divId="MyIframeDiv1"
title="Create New MyUser"
value="Generate New MyUser Remote Form Example?"
/>
	
<div id="MyIframeDiv1">
  <g:render template='/testdynamix/MyIframeDivForm' />
</div>


<h1>ACTUAL FORM</h1>
 
<g:form name="mynextForm" action="step2">
<div id="MyIframeDiv">
  <g:render template='/testdynamix/MyIframeDivDisplay' />
 </div>
</g:form>
```   

##### g:genModalButton 
loads up a button that triggers modalbox
```
ID -> must match the ID of the id set further within the DIVS templates
divId -> This is the divId put above your main form that contains the modalbox itself and the form within it
title -> hover title of your new button
value -> display text in the button

```

	
#### MyIframeDiv1
Main DIV wrapping the call  'MyIframeDiv1'  [ the name must match divId label in g:genModalButton call] 
This now calls a template within my example project the project which is making the call, this is the taglib call back to this plugin but needs to be in a template.
The reason is that the plugin later on calls this page to store its content for reuse of same button calls.

[_MyIframeDivForm.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MyIframeDivForm.gsp)

So lets take a look inside this file what is going on here?
```gsp
	<g:modalForm
 id="ModalDynamixSPECIALFORM"
 formId="MyRemoteForma"
 title="My Modal Title"
 
 divId="MyIframeDiv"
 returnController="testdynamix"
 
 close="XX"
 	
 
 submitController="MyLocalDomain" 
 submitAction="save"
 submitValue="Save form"

 
 modalTemplatePage="/myLocalDomain/form-IFRAME"
 
 modalTemplate='/modaldynamix/modaliframe'
 	
 domain="grails.modaldx.test.MyLocalDomain"

 	
 	/>
```

#### g:modalForm
```
id -> must match the ID of the id set further within the DIVS templates

formId -> must be the name you wish to give your actual form must be unique
 
title -> The title for your modal page

divId -> This must be the mainDiv containing yet another template which actually displays the field within your form

returnController -> The current controller calling this page and contains the templates for your main divs on the page

modalTemplatePage ->a template within your local project that contains a complete form
  
[_form-IFRAME.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/myLocalDomain/_form-IFRAME.gsp)

modalTemplate -> This is the template within the plugin to call must match the above name if you are using modalRemoteForm method, 
You can write your own and override the value

domain -> Full path.domainName to access the domain that is in question or being updated, it simply does a listing and returns list 
on your final div call to the Display file as returnResult:
```

[_MyIframeDivDisplay.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MyIframeDivDisplay.gsp)

```
from="${returnResult ?:.....

submitController -> The controller that will process your form being called by iFrame 
submitAction	-> The action from this controller
submitValue 	-> The value to show in the submit value of the RemoteForm
```

 Finally:
```	
 url -> you can set url="http://yoururl.to.your.form/controller/call_to_get_form
```
 
By default it will take your templatepage myLocalDomain/_form-IFRAME.gsp and get it via a plugin
 call to render the template. This may cause issues and for this you can just define url="likeabove"
 
  

### MyIframeDiv our Final Div
This is within our main form on this page and contains a render template to /testdynamix/MyIframeDivDisplay.

So imagine you have your form to make this work, you take out the segment in the form that is to be updated and put it in its own template file,
 the naming as above all match the DivId name given to the form and ends with Display

What is in this file?

[_MyIframeDivDisplay.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MyIframeDivDisplay.gsp)
```gsp
<label>Field2: auto updated</label>
  <g:select from="${returnResult ?: grails.modaldx.test.MyLocalDomain.list()}" id="myfield" name="mynextfield"/>
</div>
```
It is just a simple select element with its tags etc. the only difference the from value has been amended to include returnResult :? and rest as was...

 

For all the files related to RemotForm Call refer to:


[testIFrame.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/testIFrame.gsp)
[_MyIframeDivDisplay.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MyIframeDivDisplay.gsp)
[_MyIframeDivForm.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MyIframeDivForm.gsp)
[_form-IFRAME.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views//myLocalDomain/_form-IFRAME.gsp)

--> feel free to use this form template as your own template if you just require a Iframe form functionality to your existing form

If you inspect the form pages from all the types of calls this the myLocalDomain/_form files you will notice all use 

	attrs 
	
besides iframe form which uses 

	params
	
A heads up to watch for this when putting your forms together.


I have updated  [_MySelfPostDivForm.gsp](https://github.com/vahidhedayati/grails-modaldx-test/blob/master/grails-app/views/testdynamix/_MySelfPostDivForm.gsp) to display the results as updating check boxes rather than updating a select box


