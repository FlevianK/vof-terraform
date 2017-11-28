# Release Management

### Introduction 
Release management is the process of managing, planning, scheduling and controlling a software build through different stages and environments; including testing and deploying software releases.  As part of the VOF migration to GCP, it's one of the many practices that was implemented. Described below are the ways team keeps the release process on track for upcoming releases.

### CircleCI
It's the tool that has been used on this VOF project migrated to GCP. CircleCI acts as a platform for both Continuous Integration and Continuous Deployment. CircleCI fits well into this flow being the perfect suit to ensure our needs are met. Furthermore, it's the prefered tool that is being used currently by Andela as an Organization. 

### Setting up Vof on CircleCI (Standard procedures)
> To add a project, you must have a GitHub or GitHub Enterprise account.
> Navigate to the IP address in your browser for the CircleCI application as installed by your administrator. The Welcome page appears with a Get Started button.
> Click the Get Started button on the Welcome to CircleCI page. If you are not already logged into GitHub, the Sign in to GitHub to continue to Local CCIE Enterprise page appears.
> Enter your GitHub login credentials and click the Sign in button followed by your Two-factor authentication if appropriate. The CircleCI application appears with a Getting Started section. 
> Select or deselect projects from the list and click the Follow and Build button to start building your projects. The Builds page appears with your first project in the Running state. 
> To view the real-time build console and details, click the link to your build from the Builds page. The details page for your build appears. The Build Timing tab is shown in the following screenshot. Notice the red section of the timeline indicates where it failed. 
> Click the red section or scroll down to see the console error for the failure. 

### Vof CircleCI Environment Variables management.
CircleCI allows to associate environment variables with an app via the app settings > Build Settings > Environment Variables page. Currently, one can set only name and value, equivalent to export NAME=VALUE. It’s important to note that environment variables configured through the UI are exported during the machine section of the build.

Some of the set VOF environment variables in circleci include, Login_url Logout_url, Secrte_key.

Steps to configure environment variables:
    Visit app builds page on CircleCI
    Hit "Project Settings" link in upper right
    Select "Environment Variables" from the second column on the left

### Vof Requirements
Developers should be able to continuously deploy new changes to the application and roll back to old versions as necessary. This should be executed automatically from a Continuous Integration pipeline. 
- Can deploy newest HEAD of master branch to any environment.

- Can rollback to last deployment as needed.

- Packages assets as needed.

- Restarts application and web servers as needed.

- During deployments the application should have zero downtime.

### Solution
Pipeline Steps
- changes are pushed to the VOF git repository.

- Automatically trigger and execute whenever changes are pushed.

- Pipeline pulls the codebase.

- Runs the test.

- Pipeline should deploy the changes automatically to the staging environment.

- Deployment to production is to be triggered manually via the circleCI web interface and deployed automatically by the pipeline.

- Integrated configured alerts should be sent to notify VOF team of any complete deployment.

To enable easy rollbacks, A build revert will have to be carried out. Successful builds are given a commit, so the previous succesful run build will be re-run and the deployment process of the previous version will be triggered.

### VOF CI & CD Pipeline Structure

#### Pipeline Components
The pipeline is made up of  a number of jobs which include Build, tests, release to staging, release to production, deploy staging and deploy production. Each job inherits from the default setup where environment variables and images (custom docker image and prebuilt postgresdatabase image) to use have been declared.

![screenshot](https://github.com/vof-deployment-scripts/blob/master/docs/screenshots/add_env.png)

![screenshot](https://github.com/vof-deployment-scripts/blob/master/docs/screenshots/env_variables.png)

![screenshot](https://github.com/vof-deployment-scripts/blob/master/docs/screenshots/pipeline.png)

#### Workflows / dependacies
A workflow is a set of rules for defining a collection of jobs and their run order that shortens the feedback loop. it helps to achieve a number of things;
1. Run and troubleshoot jobs independently with fast status feedback as each job runs
2. Fan-out to run multiple jobs in parallel for efficient testing of versions  
3. Fan-in for deployment to separate platforms with increased speed

VOF workflows are structured in the following way;
>build.
>test (chich requires build).
>release to staging which is of a manual approval filtering the develop branch only.
>deploy staging (required release to staging). works on develop branch only.
>release to production which is of a manual approval filtering the master branch only.
>deploy staging (required release to production). works on master branch only.

![screenshot](https://github.com/vof-deployment-scripts/blob/master/docs/screenshots/workflows.png)

#### Approvals
We used them to hold a Workflow for a Manual Approval. Workflows may be configured to wait for manual approval of a job before continuing by using the type: approval key. The type: approval key is a special job and type that is only added under in your workflow key.

In the VOF pipeline, release to staging and release to production jobs which are depended on by both deploys will not run until you click the hold job in the Workflows page of the CircleCI app and then click Approve. Notice that the hold job must have a unique name that is not used by any other job. The workflow will wait with the status of On Hold until you click the job and Approve. After you approve the job with type: approval, the jobs which require the approval job will start.

Example of an approval prompt.
![screenshot](https://github.com/vof-deployment-scripts/blob/master/docs/screenshots/approvals.png)

#### Re-running a job
When you use workflows to orchestrate parts of your build, you increase your ability to respond to failures rapidly. Click the Workflows icon in the app and select a workflow to see the status of each job as shown in the next screenshot. Click the Rerun button and select From failed to restart only the failed job and continue the workflow. Only jobs after the failure will run, saving time and resources.

![screenshot](https://github.com/vof-deployment-scripts/blob/master/docs/screenshots/rerun.png)

> To-Do's
To ensure the application has zero downtime during deployment, Blue-Green deployment will be used. This is a technique that reduces downtime and risk by running two identical production environments called Blue and Green. At any time, only one of the environments is live, with the live environment serving all production traffic.

Semantic Versioning which implements automated release version bumping though not initially being used by VOF on heroku is to be an added feature. This will ensure proper tracking os releases.  

### Conclusion
As per the time of the second presentation, The pipeline is halfway done serving the purposes of running the tests and deployment to a two environments (Staging and Production).
