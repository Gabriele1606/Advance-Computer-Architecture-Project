# Advance Computer Architecture Project
Repository for Advance Computer Architecture A.Y. 2016/2017, Group: Bressan, deSantis. <br />

Project Presentation: [Presentation](https://github.com/Gabriele1606/Advance-Computer-Architecture-Project/blob/master/Presentation/Presentazione%20ACA%20P10a.pdf)<br />
Project Documentation and Set-up: [Documentation](https://github.com/Gabriele1606/Advance-Computer-Architecture-Project/blob/master/Documentation/DocumentazioneProgetto%20P10a.pdf)

## Project Goal
The goal of this project was to create a web server used to retrieve and show
the real-time information (such as, CPU and RAM percentage, number of cores used, processes
currently running and network usage) from a benchmark tool (daemon) running on a remote
Linux machine.<br /> 
For this project three different tools were used: Metricbeat, a lightweight shipper that
collects and ships various system and service metrics to a specified output destination. The output
destination was Elasticsearch database, which is a distributed RESTful search and analytics engine capable
of solving a growing number of use cases. The last tool used is Kibana, which is an open source data
visualization plugin for Elasticsearch. It provides visualization capabilities on top of the content indexed
on an Elasticsearch cluster.

![example_1](https://github.com/Gabriele1606/Advance-Computer-Architecture-Project/blob/master/Images%20example/example_1.png)

The final result is the Kibana Dashboad:

![example_1](https://github.com/Gabriele1606/Advance-Computer-Architecture-Project/blob/master/Images%20example/example_2.jpg)

## Setup
For the installation of all components, we have built a script that supply all the installation and
configuration steps of Elasticsearch, Kibana and Metricbeat. Moreover the script will configure
and sets itself all the custom visualization, dashboard, and sets the index pattern required by
Kibana to show properly our collected data.
Following the next steps is possible to download and run the `p10_install.sh` script.<br />
(Please, to set correctly the enviroment look the [Documentation](https://github.com/Gabriele1606/Advance-Computer-Architecture-Project/blob/master/Documentation/DocumentazioneProgetto%20P10a.pdf)).
<br />
Once downloaded the `p10_install.sh` script you have to make it executable so in the command line:
```
chmod +x p10_install.sh
```
and run it:
```
sudo ./p10_install.sh
```

### Start Elasticsearch, Kibana and Metricbeat
Elasitcsearch:
```
sudo -i service elasticsearch start
```
Kibana:
```
sudo -i service kibana start
```
Metricbeat:
```
sudo /etc/init.d/metricbeat start
```
### Stop Elasticsearch, Kibana and Metricbeat
Elasitcsearch:
```
sudo -i service elasticsearch stop
```
Kibana:
```
sudo -i service kibana stop
```
Metricbeat:
```
sudo /etc/init.d/metricbeat stop
```


