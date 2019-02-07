#!/bin/sh
cho "Downloading Elasticsearch"
sudo wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.4.0.deb
echo "Installing Elasticsearch"
sudo dpkg -i elasticsearch-5.4.0.deb
pause 5 seconds
echo "Starting Elasticsearch"
sudo -i service elasticsearch start


echo "Downloading Kibana"
sudo wget https://artifacts.elastic.co/downloads/kibana/kibana-5.4.0-amd64.deb
echo "Installing Kibana"
sudo dpkg -i kibana-5.4.0-amd64.deb
pause 5 seconds
echo "Starting Kibana"
sudo -i service kibana start

echo "Downloading Metricbeat"
sudo wget https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.4.0-amd64.deb
echo "Installing Metricbeat"
sudo dpkg -i metricbeat-5.4.0-amd64.deb
echo "Downloading Sample Dashboard"
sudo wget https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.4.0-linux-x86_64.tar.gz
sudo tar zxvf metricbeat-5.4.0-linux-x86_64.tar.gz
cd metricbeat-5.4.0-linux-x86_64
pause 60 seconds
echo "Loading Index Elasticsearch"
sudo curl -H 'Content-Type: application/json' -XPUT 'http://localhost:9200/_template/metricbeat' -d@/etc/metricbeat/metricbeat.template.json
echo "Loading Sample Dashboard"
sudo ./scripts/import_dashboards -es http://localhost:9200 -user elastic -pass changeme 
cd ..
sudo rm -rf metricbeat-5.4.0-linux-x86_64
echo "Starting Metricbeat"
sudo /etc/init.d/metricbeat start

sudo curl -XPUT http://localhost:9200/.kibana/index-pattern/stat* -d '{"title":"stat*","timeFieldName":"@timestamp","notExpandable":true,"fields":"[{\"name\":\"process\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":true,\"analyzed\":true,\"doc_values\":false,\"searchable\":true,\"aggregatable\":false},{\"name\":\"end_time\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":true,\"analyzed\":true,\"doc_values\":false,\"searchable\":true,\"aggregatable\":false},{\"name\":\"process.keyword\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":true,\"analyzed\":false,\"doc_values\":true,\"searchable\":true,\"aggregatable\":true},{\"name\":\"elapsed\",\"type\":\"number\",\"count\":0,\"scripted\":false,\"indexed\":true,\"analyzed\":false,\"doc_values\":true,\"searchable\":true,\"aggregatable\":true},{\"name\":\"start_time\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":true,\"analyzed\":true,\"doc_values\":false,\"searchable\":true,\"aggregatable\":false},{\"name\":\"start_time.keyword\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":true,\"analyzed\":false,\"doc_values\":true,\"searchable\":true,\"aggregatable\":true},{\"name\":\"@timestamp\",\"type\":\"date\",\"count\":0,\"scripted\":false,\"indexed\":true,\"analyzed\":false,\"doc_values\":true,\"searchable\":true,\"aggregatable\":true},{\"name\":\"_source\",\"type\":\"_source\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":false,\"aggregatable\":false},{\"name\":\"end_time.keyword\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":true,\"analyzed\":false,\"doc_values\":true,\"searchable\":true,\"aggregatable\":true},{\"name\":\"_id\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":false,\"aggregatable\":false},{\"name\":\"_type\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":true,\"aggregatable\":true},{\"name\":\"_index\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":false,\"aggregatable\":false},{\"name\":\"_score\",\"type\":\"number\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":false,\"aggregatable\":false}]"}'

sudo curl -XPUT http://localhost:9200/.kibana/index-pattern/annotation* -d '{"title":"annotation*","timeFieldName":"@timestamp","notExpandable":true,"fields":"[{\"name\":\"annotation\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":true,\"analyzed\":true,\"doc_values\":false,\"searchable\":true,\"aggregatable\":false},{\"name\":\"@timestamp\",\"type\":\"date\",\"count\":0,\"scripted\":false,\"indexed\":true,\"analyzed\":false,\"doc_values\":true,\"searchable\":true,\"aggregatable\":true},{\"name\":\"_source\",\"type\":\"_source\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":false,\"aggregatable\":false},{\"name\":\"annotation.keyword\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":true,\"analyzed\":false,\"doc_values\":true,\"searchable\":true,\"aggregatable\":true},{\"name\":\"_id\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":false,\"aggregatable\":false},{\"name\":\"_type\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":true,\"aggregatable\":true},{\"name\":\"_index\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":false,\"aggregatable\":false},{\"name\":\"_score\",\"type\":\"number\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":false,\"aggregatable\":false}]"}'



sudo curl -XPUT http://localhost:9200/.kibana/index-pattern/max_value -d '{"title":"max_value","timeFieldName":"@timestamp","fields":"[{\"name\":\"max\",\"type\":\"number\",\"count\":0,\"scripted\":false,\"indexed\":true,\"analyzed\":false,\"doc_values\":true,\"searchable\":true,\"aggregatable\":true},{\"name\":\"@timestamp\",\"type\":\"date\",\"count\":0,\"scripted\":false,\"indexed\":true,\"analyzed\":false,\"doc_values\":true,\"searchable\":true,\"aggregatable\":true},{\"name\":\"_source\",\"type\":\"_source\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":false,\"aggregatable\":false},{\"name\":\"_id\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":false,\"aggregatable\":false},{\"name\":\"_type\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":true,\"aggregatable\":true},{\"name\":\"_index\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":false,\"aggregatable\":false},{\"name\":\"_score\",\"type\":\"number\",\"count\":0,\"scripted\":false,\"indexed\":false,\"analyzed\":false,\"doc_values\":false,\"searchable\":false,\"aggregatable\":false}]"}'

curl -XPUT http://localhost:9200/.kibana/dashboard/6af853e0-3fd6-11e7-ad7c-2de5dd951c6a -d '{
      "title": "Dashboard P10",
      "hits": 0,
      "description": "",
      "panelsJSON": "[{\"col\":1,\"id\":\"25fb8000-3fd6-11e7-8fe6-6fd58db07c00\",\"panelIndex\":1,\"row\":1,\"size_x\":8,\"size_y\":5,\"type\":\"visualization\"},{\"col\":1,\"id\":\"d39a3460-3ff7-11e7-999f-63e66503cb1e\",\"panelIndex\":2,\"row\":6,\"size_x\":8,\"size_y\":4,\"type\":\"visualization\"},{\"col\":1,\"id\":\"74a8d770-3fcc-11e7-877e-8f9f87a677b8\",\"panelIndex\":3,\"row\":10,\"size_x\":8,\"size_y\":3,\"type\":\"visualization\"},{\"col\":9,\"id\":\"Top-processes-by-CPU-usage\",\"panelIndex\":4,\"row\":1,\"size_x\":4,\"size_y\":6,\"type\":\"visualization\"},{\"col\":9,\"id\":\"dae65820-405b-11e7-9f3d-910c973cf0e7\",\"panelIndex\":5,\"row\":10,\"size_x\":4,\"size_y\":6,\"type\":\"visualization\"},{\"size_x\":4,\"size_y\":3,\"panelIndex\":6,\"type\":\"visualization\",\"id\":\"9dff3070-49fd-11e7-ada8-e917198ca7f3\",\"col\":9,\"row\":7}]",
      "optionsJSON": "{\"darkTheme\":false}",
      "uiStateJSON": "{\"P-4\":{\"spy\":{\"mode\":{\"fill\":false,\"name\":null}},\"vis\":{\"params\":{\"sort\":{\"columnIndex\":null,\"direction\":null}}}},\"P-5\":{\"vis\":{\"params\":{\"sort\":{\"columnIndex\":null,\"direction\":null}}}}}",
      "version": 1,
      "timeRestore": false,
      "kibanaSavedObjectMeta": {
        "searchSourceJSON": "{\"filter\":[{\"query\":{\"query_string\":{\"analyze_wildcard\":true,\"query\":\"*\"}}}],\"highlightAll\":true,\"version\":true}"
      }
    }'
	
	
	
curl -XPUT http://localhost:9200/.kibana/visualization/25fb8000-3fd6-11e7-8fe6-6fd58db07c00 -d '{
      "title": "ProcessiCPU",
      "visState": "{\"title\":\"ProcessiCPU\",\"type\":\"metrics\",\"params\":{\"id\":\"ef129ac0-3fd4-11e7-8fe6-6fd58db07c00\",\"type\":\"timeseries\",\"series\":[{\"id\":\"ef129ac1-3fd4-11e7-8fe6-6fd58db07c00\",\"color\":\"#68BC00\",\"split_mode\":\"terms\",\"metrics\":[{\"id\":\"ef129ac2-3fd4-11e7-8fe6-6fd58db07c00\",\"type\":\"avg\",\"field\":\"system.process.cpu.total.pct\"}],\"seperate_axis\":0,\"axis_position\":\"right\",\"formatter\":\"percent\",\"chart_type\":\"bar\",\"line_width\":1,\"point_size\":1,\"fill\":0.5,\"stacked\":\"stacked\",\"terms_field\":\"system.process.name\",\"terms_order_by\":\"ef129ac2-3fd4-11e7-8fe6-6fd58db07c00\",\"split_color_mode\":\"rainbow\",\"label\":\"CPU Usage\",\"terms_size\":\"100\"}],\"time_field\":\"@timestamp\",\"index_pattern\":\"metricbeat-*\",\"interval\":\"auto\",\"axis_position\":\"left\",\"axis_formatter\":\"number\",\"show_legend\":1,\"annotations\":[{\"fields\":\"annotation\",\"template\":\"{{annotation}}\",\"index_pattern\":\"annotation*\",\"query_string\":\"*\",\"id\":\"e2188820-3ff7-11e7-999f-63e66503cb1e\",\"color\":\"rgba(211,49,21,1)\",\"time_field\":\"@timestamp\",\"icon\":\"fa-tag\"}],\"gauge_color_rules\":[{\"id\":\"7a9f6860-4053-11e7-9463-738b1160f40b\"}],\"gauge_width\":10,\"gauge_inner_width\":10,\"gauge_style\":\"half\"},\"aggs\":[],\"listeners\":{}}",
      "uiStateJSON": "{}",
      "description": "",
      "version": 1,
      "kibanaSavedObjectMeta": {
        "searchSourceJSON": "{\"query\":{\"query_string\":{\"query\":\"*\"}},\"filter\":[]}"
      }
    }'
	
	
curl -XPUT http://localhost:9200/.kibana/visualization/d39a3460-3ff7-11e7-999f-63e66503cb1e -d '{
      "title": "Memory Annotation",
      "visState": "{\"title\":\"Memory Annotation\",\"type\":\"metrics\",\"params\":{\"id\":\"3b63d5c0-3ff7-11e7-999f-63e66503cb1e\",\"type\":\"timeseries\",\"series\":[{\"id\":\"3b63d5c1-3ff7-11e7-999f-63e66503cb1e\",\"color\":\"rgba(0,44,188,1)\",\"split_mode\":\"everything\",\"metrics\":[{\"id\":\"3b63d5c2-3ff7-11e7-999f-63e66503cb1e\",\"type\":\"avg\",\"field\":\"system.memory.used.bytes\"}],\"seperate_axis\":0,\"axis_position\":\"right\",\"formatter\":\"bytes\",\"chart_type\":\"line\",\"line_width\":\"7\",\"point_size\":\"1\",\"fill\":0.5,\"stacked\":\"stacked\",\"label\":\"Memory Usage\"}],\"time_field\":\"@timestamp\",\"index_pattern\":\"metricbeat-*\",\"interval\":\"auto\",\"axis_position\":\"left\",\"axis_formatter\":\"number\",\"show_legend\":1,\"annotations\":[{\"fields\":\"annotation\",\"template\":\"{{annotation}}\",\"index_pattern\":\"annotation*\",\"query_string\":\"*\",\"id\":\"6f95a6c0-3ff7-11e7-999f-63e66503cb1e\",\"color\":\"rgba(211,49,21,1)\",\"time_field\":\"@timestamp\",\"icon\":\"fa-tag\"}],\"ignore_global_filter\":1},\"aggs\":[],\"listeners\":{}}",
      "uiStateJSON": "{}",
      "description": "",
      "version": 1,
      "kibanaSavedObjectMeta": {
        "searchSourceJSON": "{\"query\":{\"query_string\":{\"query\":\"*\"}},\"filter\":[]}"
      }
    }'


curl -XPUT http://localhost:9200/.kibana/visualization/dae65820-405b-11e7-9f3d-910c973cf0e7 -d '{
      "title": "Table Process",
      "visState": "{\"title\":\"Table Process\",\"type\":\"table\",\"params\":{\"perPage\":10,\"showPartialRows\":false,\"showMeticsAtAllLevels\":false,\"sort\":{\"columnIndex\":null,\"direction\":null},\"showTotal\":false,\"totalFunc\":\"sum\"},\"aggs\":[{\"id\":\"1\",\"enabled\":true,\"type\":\"avg\",\"schema\":\"metric\",\"params\":{\"field\":\"elapsed\",\"customLabel\":\"Elapsed Time\"}},{\"id\":\"3\",\"enabled\":true,\"type\":\"terms\",\"schema\":\"bucket\",\"params\":{\"field\":\"process.keyword\",\"size\":5,\"order\":\"desc\",\"orderBy\":\"1\",\"customLabel\":\"Process\"}},{\"id\":\"2\",\"enabled\":false,\"type\":\"terms\",\"schema\":\"bucket\",\"params\":{\"field\":\"@timestamp\",\"size\":5,\"order\":\"desc\",\"orderBy\":\"_term\",\"customLabel\":\"Data\"}},{\"id\":\"4\",\"enabled\":true,\"type\":\"terms\",\"schema\":\"bucket\",\"params\":{\"field\":\"start_time.keyword\",\"size\":5,\"order\":\"desc\",\"orderBy\":\"_term\",\"customLabel\":\"Start Date\"}},{\"id\":\"5\",\"enabled\":true,\"type\":\"terms\",\"schema\":\"bucket\",\"params\":{\"field\":\"end_time.keyword\",\"size\":5,\"order\":\"desc\",\"orderBy\":\"_term\",\"customLabel\":\"End Date\"}}],\"listeners\":{}}",
      "uiStateJSON": "{\"vis\":{\"params\":{\"sort\":{\"columnIndex\":null,\"direction\":null}}}}",
      "description": "",
      "version": 1,
      "kibanaSavedObjectMeta": {
        "searchSourceJSON": "{\"index\":\"stat*\",\"query\":{\"query_string\":{\"query\":\"*\",\"analyze_wildcard\":true}},\"filter\":[]}"
      }
    }'


curl -XPUT http://localhost:9200/.kibana/visualization/9dff3070-49fd-11e7-ada8-e917198ca7f3 -d '{
      "title": "Max_value",
      "visState": "{\"aggs\":[{\"enabled\":true,\"id\":\"1\",\"params\":{\"customLabel\":\"Max Value\",\"field\":\"max\"},\"schema\":\"metric\",\"type\":\"avg\"},{\"enabled\":true,\"id\":\"2\",\"params\":{\"customLabel\":\"Timestamp\",\"field\":\"@timestamp\",\"order\":\"asc\",\"orderBy\":\"_term\",\"size\":999999999},\"schema\":\"segment\",\"type\":\"terms\"}],\"listeners\":{},\"params\":{\"addLegend\":true,\"addTimeMarker\":false,\"addTooltip\":true,\"categoryAxes\":[{\"id\":\"CategoryAxis-1\",\"labels\":{\"show\":true,\"truncate\":100},\"position\":\"bottom\",\"scale\":{\"type\":\"linear\"},\"show\":true,\"style\":{},\"title\":{\"text\":\"Timestamp\"},\"type\":\"category\"}],\"defaultYExtents\":false,\"drawLinesBetweenPoints\":true,\"grid\":{\"categoryLines\":false,\"style\":{\"color\":\"#eee\"}},\"interpolate\":\"linear\",\"legendPosition\":\"right\",\"radiusRatio\":9,\"scale\":\"linear\",\"seriesParams\":[{\"data\":{\"id\":\"1\",\"label\":\"Max Value\"},\"drawLinesBetweenPoints\":true,\"mode\":\"stacked\",\"show\":\"true\",\"showCircles\":true,\"type\":\"histogram\",\"valueAxis\":\"ValueAxis-1\"}],\"setYExtents\":false,\"showCircles\":true,\"times\":[],\"valueAxes\":[{\"id\":\"ValueAxis-1\",\"labels\":{\"filter\":false,\"rotate\":0,\"show\":true,\"truncate\":100},\"name\":\"LeftAxis-1\",\"position\":\"left\",\"scale\":{\"mode\":\"normal\",\"type\":\"linear\"},\"show\":true,\"style\":{},\"title\":{\"text\":\"Max Value\"},\"type\":\"value\"}]},\"title\":\"Max_value\",\"type\":\"histogram\"}",
      "uiStateJSON": "{}",
      "description": "",
      "version": 1,
      "kibanaSavedObjectMeta": {
        "searchSourceJSON": "{\"index\":\"max_value\",\"query\":{\"query_string\":{\"analyze_wildcard\":true,\"query\":\"*\"}},\"filter\":[]}"
      }
    }'

	
	
curl -XPUT http://localhost:9200/.kibana/visualization/74a8d770-3fcc-11e7-877e-8f9f87a677b8 -d '{
      "title": "CPU Annotation",
      "visState": "{\"title\":\"CPU Annotation\",\"type\":\"metrics\",\"params\":{\"annotations\":[{\"color\":\"#F00\",\"fields\":\"annotation\",\"icon\":\"fa-bolt\",\"id\":\"79e051d0-3fc9-11e7-877e-8f9f87a677b8\",\"index_pattern\":\"annotation*\",\"query_string\":\"*\",\"template\":\"{{annotation}}\",\"time_field\":\"@timestamp\"}],\"axis_formatter\":\"number\",\"axis_position\":\"left\",\"background_color_rules\":[{\"id\":\"dd3744e0-3fca-11e7-877e-8f9f87a677b8\"}],\"id\":\"5d7bcba0-3fc9-11e7-877e-8f9f87a677b8\",\"ignore_global_filter\":1,\"index_pattern\":\"metricbeat-*\",\"interval\":\"auto\",\"series\":[{\"axis_position\":\"right\",\"chart_type\":\"line\",\"color\":\"rgba(194,4,21,1)\",\"fill\":0.5,\"formatter\":\"percent\",\"id\":\"5d7bcba1-3fc9-11e7-877e-8f9f87a677b8\",\"line_width\":\"4\",\"metrics\":[{\"field\":\"system.cpu.user.pct\",\"id\":\"5d7bcba2-3fc9-11e7-877e-8f9f87a677b8\",\"type\":\"avg\"}],\"point_size\":1,\"seperate_axis\":0,\"split_color_mode\":\"rainbow\",\"split_mode\":\"everything\",\"stacked\":\"stacked\"}],\"show_legend\":1,\"time_field\":\"@timestamp\",\"type\":\"timeseries\"},\"aggs\":[],\"listeners\":{}}",
      "uiStateJSON": "{}",
      "description": "",
      "version": 1,
      "kibanaSavedObjectMeta": {
        "searchSourceJSON": "{\"query\":{\"query_string\":{\"query\":\"*\"}},\"filter\":[]}"
      }
    }'

sudo -i service elasticsearch stop
sudo -i service kibana stop
sudo /etc/init.d/metricbeat stop
echo "Installation Finished"
cat << "EOF"
__________      .__  .__  __                       .__                   .___.__     _____  .__.__                        
\______   \____ |  | |__|/  |_  ____   ____   ____ |__| ____  ____     __| _/|__|   /     \ |__|  | _____    ____   ____  
 |     ___/  _ \|  | |  \   __\/ __ \_/ ___\ /    \|  |/ ___\/  _ \   / __ | |  |  /  \ /  \|  |  | \__  \  /    \ /  _ \ 
 |    |  (  <_> )  |_|  ||  | \  ___/\  \___|   |  \  \  \__(  <_> ) / /_/ | |  | /    Y    \  |  |__/ __ \|   |  (  <_> )
 |____|   \____/|____/__||__|  \___  >\___  >___|  /__|\___  >____/  \____ | |__| \____|__  /__|____(____  /___|  /\____/ 
                                   \/     \/     \/        \/             \/              \/             \/     \/        
EOF
echo "A.Y. 2016/2017 ACA Project Professor: Gianluca Palermo, Teaching Professor: Cristina Silvano"
echo "Students: S. de Santis & G. Bressan"
