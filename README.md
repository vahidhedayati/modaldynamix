modaldynamix 0.1
=======================


ModalDynamix is a Grails plugin which makes use of jquery, bootstrap and modalbox to load various types of forms  Self Posting,I Frame, Remote Forms and normal calls via ModalBox, upon trigger save or close depending on type of call, the underlying form is updated with new values without page refreshes.'
 
A common problem when it comes to making a website is having objects that require updating on the fly and this plugin aims to help in the process of producing dynamical forms that sit on top of other forms that are then opened in a pop up modalbox and their actions update your underlying form.


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



