pipeline {
     agent none
	 tools {
	     maven 'NodeBMaven'
	 }
	 stages {
	      stage('SCM Connect') {
		       agent{label "NodeB"}
		       steps {
		            git(url:'https://github.com/neluc/projectmod5.git', branch: 'master', poll:true)
				}
		  }	 
		  stage('Compile') {
		       agent{label "NodeB"}
			   steps {
			        sh 'mvn compile'
			   }
		  }
		  stage('Testing') {
		       agent{label "NodeA"}
			   steps {
			        sh 'mvn test'
			   }
		  }
		  stage ('Package') {
		      agent{label "NodeB"}
			  steps {
			      sh "mvn package"
			  }
		  }
		  stage ('QA Run war Package') {
		      agent{label "NodeB"}
			  steps {
			       sh 'java -jar target/demo-0.0.1-SNAPSHOT.jar'
			  }
		  }
	 }
}
Save
