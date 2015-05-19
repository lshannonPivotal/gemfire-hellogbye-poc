# Prerequisites
To run this 4 machines are required. They need a dedicated network with at least 10Gb bandwidth in between members. For this POC AWS was using and c4.8xlarge instances

# Configure the environment
In the ServerConfigs project locate the environment.sh file and add the IP addresses of the server. The first address will be the primary locator, the second address the secondary locator and the last two addresses data servers. Server processes will also be started on the locator machine. It is assumed that there will be a directory called /home/ubuntu/cluster. This is the home directory all scripts will work from.

# Upload the files
By running the scp script in the ServerConfigs project a prompt will appear to determine which files should be uploaded:

{% highlight bash %}
Luke-Shannons-Macbook-Pro:ServerConfigs lshannon$ ./scp.sh 
What to upload?
1: Everything
2: scripts
3: conf
4: lib
5: data
6: Client App
{% endhighlight %}

Everything is all the dependancies, scripts is the shell scripts used to start and stop the Gemfire processes on each member, conf is the Gemfire configurations for each member, lib is where custom code Gemfire uses can be loaded (everything in here will be loaded in the CLASSPATH of Gemfire), data is the sample data for the POC and Client App is a sample application and shell scripts to start and stop it.

== Starting the Cluster
Once the environment is configured and files have been loaded, from a control machine the start_cluster script can be executed.
