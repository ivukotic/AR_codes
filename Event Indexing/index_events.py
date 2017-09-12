import json
from elasticsearch import Elasticsearch
from elasticsearch.helpers import bulk

allDocs=[]

es = Elasticsearch([{'host':'atlas-kibana.mwt2.org', 'port':9200}],timeout=60)
ind='ar-events'
        
with open("events.json") as json_file:
    events = json.load(json_file)
    print('events:',len(events))
    for e in events:
        eid=str(e['eventnr'])
        ev={'_index':ind, '_type':'event', 'description':e['description'], 'runnr':e['runnr'], '_id':eid}
        allDocs.append(ev)
        del e['description']
        del e['runnr']
        del e['eventnr']
        for c,v in e.items():  #loop over collections
            print(c)
            print(len(v))
            for ci in range(len(v)):  #loop over elements in collection
                co={'_index':ind, '_type':c, '_parent': eid}
                co.update(v[ci])
                if 'pos' in co:
                    hits=[]
                    for xyz in co['pos']:
                        hits.append({"x":xyz[0],"y":xyz[1],"z":xyz[2]})
                    co['hits']=hits
                    del co['pos']
                print(co)
                allDocs.append(co)

res = bulk(client=es, actions=allDocs, stats_only=True, timeout="5m")
print(res)
print('Done.')