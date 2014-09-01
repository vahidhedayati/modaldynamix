grails.project.work.dir = 'target'
//grails.project.dependency.resolver = 'maven'
grails.project.dependency.resolution = {

	inherits 'global'
	log 'warn'

	repositories {
		mavenLocal()
		mavenCentral()
		grailsCentral()
		
	}

	plugins {
		compile ":jquery-ui:1.10.3", { excludes 'jquery' }
		runtime ':pluginbuddy:0.3'
		build ':release:3.0.1', ':rest-client-builder:1.0.3', {
			export = false
		}
	}
}
